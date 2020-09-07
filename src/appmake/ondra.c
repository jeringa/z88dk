/*
 * RK* generator 
 */


#include "appmake.h"

static char             *binname      = NULL;
static char             *outfile      = NULL;
static char             *crtfile      = NULL;
static int               origin       = -1;
static int               exec         = -1;
static char              help         = 0;

static void writebyte_ondra(uint8_t byte, FILE *fp, FILE *wavfile, uint8_t *cksump);

/* Options that are available for this module */
option_t ondra_options[] = {
    { 'h', "help",       "Display this help",                OPT_BOOL,  &help },
    { 'b', "binfile",    "Binary file to embed",             OPT_STR,   &binname },
    {  0 , "org",        "Origin of the embedded binary",    OPT_INT,   &origin },
    {  0 , "exec",       "Starting execution address",       OPT_INT,   &exec },
    { 'c', "crt0file",   "crt0 used to link binary",         OPT_STR,   &crtfile },
    { 'o', "output",     "Name of output file",              OPT_STR,   &outfile },
    {  0,   NULL,        NULL,                               OPT_NONE,  NULL }
};



// Leader: 283.5us high, 296us low, 283.5us high, 212.5us low
// Bit 0 = 283.5us high, 296us low, 463.5us high, 392.5us low
// Bit 1 = 463.5us high, 476us low, 283.5us high, 212.5us low
// Trailer: 193.5us high, 206us low, 283.5us high, 212.5us low
//
// Time periods: 193.5, 206, 212.5, 283.5, 296, 463.5 476


static int lengths[4][4] = {
    // Leader
    { 13, 13, 13, 13 },
    // Bit 0
    { 13, 13, 21, 21 },
    // Bit 1
    { 21, 21, 13, 13 },
    // Trailer
    { 9, 9, 12, 13 }
};

static uint8_t    h_lvl = 0xff;
static uint8_t    l_lvl = 0x00;

static void ondra_bit(FILE* fpout, int index)
{
    int  i;

    for ( i = 0; i < lengths[index][0]; i++ ) {
        fputc(h_lvl, fpout);
    }
    for ( i = 0; i < lengths[index][1]; i++ ) {
        fputc(l_lvl, fpout);
    }
    for ( i = 0; i < lengths[index][2]; i++ ) {
        fputc(h_lvl, fpout);
    }
    for ( i = 0; i < lengths[index][3]; i++ ) {
        fputc(l_lvl, fpout);
    }
}

static void ondra_rawout(FILE *fpout, unsigned char b)
{
    unsigned char c[8] = { 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01 };
    int i;

    for (i = 0; i < 8; i++)
        ondra_bit(fpout, (b & c[i]) ? 2 : 1);
}


int ondra_exec(char *target)
{
    char    filename[FILENAME_MAX+1];
    char   *blockname;
    struct  stat binname_sb;
    FILE   *fpin;
    FILE   *fpout;
    FILE   *fpwav;
    uint8_t cksum;
    int     i,c,blk,num_blks;
    int     size;
    
    if ( help )
        return -1;

    if ( binname == NULL ) {
        return -1;
    }

    if ( outfile == NULL ) {
        strcpy(filename,binname);
        suffix_change(filename,".tap");
    } else {
        strcpy(filename,outfile);
    }

    blockname = zbasename(binname);
    
    if ((origin == -1) && ((crtfile == NULL) || ((origin = get_org_addr(crtfile)) == -1))) {
        origin = 0;
    }
    if ( exec == -1 ) {
        exec = origin;
    }
    
    if ( stat(binname, &binname_sb) < 0 ||
         ( (fpin=fopen_bin(binname, NULL) ) == NULL )) {
        exit_log(1,"Can't open input file %s\n",binname);
    }
    
    if ( ( fpout = fopen(binname, "rb")) == NULL ) {
        exit_log(1,"Can't open input file %s\n", binname);
    }
    
    if ( ( fpout = fopen(filename, "wb")) == NULL ) {
        exit_log(1,"Can't open output file %s\n", filename);
    }

    suffix_change(filename,".raw");
    if ( ( fpwav = fopen(filename, "wb")) == NULL ) {
        exit_log(1,"Can't open output file %s\n", filename);
    }

    /* Per block
     * defb 0x48 = type code
     * defs 12 -filename
     * defb '.K', 0xef,'D'
     * defm " XX" - XX = block number 
     * defb 0 (load) 0xff autorun
     * defw block length
     * defb type (0 =code)
     * defb checksum
     * defb padding
     *
     * defs block
     * defb checksum 
     */

    size = binname_sb.st_size;
    num_blks = size / 1024;

    if ( size > num_blks * 1024) 
        num_blks++;

    for ( blk = 0; blk < num_blks; blk++ ) {
        int tmp;
        writebyte_ondra(0x48, fpout,fpwav,&cksum);  // File type
        cksum = 0x00;
        for ( i = 0 ; i < 12; i++) {
            writebyte_ondra(i < strlen(blockname) ? blockname[i] : ' ',fpout,fpwav,&cksum);
        }
        writebyte_ondra('.',fpout,fpwav,&cksum);
        writebyte_ondra('K',fpout,fpwav,&cksum);
        writebyte_ondra(0xef,fpout,fpwav,&cksum);
        writebyte_ondra('D',fpout,fpwav,&cksum);
        writebyte_ondra(' ',fpout,fpwav,&cksum);
        writebyte_ondra(blk >= 9 ? ((blk+1) / 10) + '0' : ' ',fpout,fpwav,&cksum);
        writebyte_ondra(((blk+1) % 10) + '0',fpout,fpwav,&cksum);
        writebyte_ondra(blk == num_blks - 1 ? 0xff : 0x00,fpout,fpwav,&cksum); // Exec indicator
        tmp = blk != num_blks - 1 ? 1024 : (size - (blk) * 1024);
        writebyte_ondra(tmp % 256,fpout,fpwav,&cksum);
        writebyte_ondra(tmp / 256,fpout,fpwav,&cksum);
        writebyte_ondra(0,fpout,fpwav,&cksum);
        writebyte_ondra(cksum,fpout,fpwav,&cksum);
        writebyte_ondra(0x44,fpout,fpwav,&cksum); // padding
        cksum = 0x00;
        tmp = blk != num_blks - 1 ? 1024 : (size - (blk) * 1024);
        for ( i = 0; i < tmp; i++ ) {
            c = getc(fpin);
            writebyte_ondra(c, fpout, fpwav, &cksum);
        }
        writebyte_ondra(cksum,fpout, fpwav, &cksum);
    }

    fclose(fpwav);
    fclose(fpin);
    fclose(fpout);

    // And now convert raw to a .wav
    //raw2wav(filename);
    
    return 0;
}


// Initial value of cksum should be 0x56
static void writebyte_ondra(uint8_t byte, FILE *fp, FILE *fpwav, uint8_t *cksump)
{
   uint8_t cksum = *cksump;

   ondra_rawout(fpwav,byte);
   fputc(byte, fp);

   cksum += byte;
   *cksump = cksum;
}

