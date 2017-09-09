
// automatically generated by m4 from headers in proto subdir


#ifndef __ARCH_ZXN_H__
#define __ARCH_ZXN_H__

#include <arch.h>

#include <stddef.h>
#include <rect.h>

// COMMON CONSTANTS

#define INK_BLACK                   0x00
#define INK_BLUE                    0x01
#define INK_RED                     0x02
#define INK_MAGENTA                 0x03
#define INK_GREEN                   0x04
#define INK_CYAN                    0x05
#define INK_YELLOW                  0x06
#define INK_WHITE                   0x07

#define PAPER_BLACK                 0x00
#define PAPER_BLUE                  0x08
#define PAPER_RED                   0x10
#define PAPER_MAGENTA               0x18
#define PAPER_GREEN                 0x20
#define PAPER_CYAN                  0x28
#define PAPER_YELLOW                0x30
#define PAPER_WHITE                 0x38

#define BRIGHT                      0x40
#define FLASH                       0x80

// GLOBAL VARIABLES

extern unsigned char GLOBAL_ZX_PORT_FE;
extern unsigned char GLOBAL_ZX_PORT_1FFD;
extern unsigned char GLOBAL_ZX_PORT_7FFD;

// IO MAPPED REGISTERS

#ifdef __CLANG

// SPECTRUM

extern unsigned char IO_FE;
extern unsigned char IO_1FFD;
extern unsigned char IO_7FFD;

// TBBLUE I/O Port system

extern unsigned char IO_REGISTRY_REG;
extern unsigned char IO_REGISTRY_DAT;

extern unsigned char IO_253B;
extern unsigned char IO_243B;

// Layer 2

extern unsigned char IO_LAYER_2_ACCESS;
extern unsigned char IO_123B;

// Hardware Sprites

extern unsigned char IO_SPRITE_SLOT;   // write
extern unsigned char IO_SPRITE_FLAGS;  // read

extern unsigned char IO_SPRITE_PALETTE;
extern unsigned char IO_SPRITE_ATTRIBUTE;
extern unsigned char IO_SPRITE_PATTERN;

extern unsigned char IO_303B;

extern unsigned char IO_53;
extern unsigned char IO_57;
extern unsigned char IO_5B;

// Audio

extern unsigned char IO_AUDIO_SELECT;

extern unsigned char IO_AUDIO_REG;
extern unsigned char IO_AUDIO_DAT;

extern unsigned char IO_FFFD;
extern unsigned char IO_BFFD;

#else

// SPECTRUM

__sfr __at 0xfe IO_FE;

__sfr __banked __at 0x1ffd IO_1FFD;
__sfr __banked __at 0x7ffd IO_7FFD;

// TBBLUE I/O Port system

__sfr __banked __at __IO_REGISTRY_REG IO_REGISTRY_REG;
__sfr __banked __at __IO_REGISTRY_DAT IO_REGISTRY_DAT;

__sfr __banked __at 0x253b IO_253B;
__sfr __banked __at 0x243b IO_243B;

// Layer 2

__sfr __banked __at __IO_LAYER_2_ACCESS IO_LAYER_2_ACCESS;
__sfr __banked __at 0x123b IO_123B;

// Hardware Sprites

__sfr __banked __at __IO_SPRITE_SLOT  IO_SPRITE_SLOT;   // write
__sfr __banked __at __IO_SPRITE_FLAGS IO_SPRITE_FLAGS;  // read

__sfr __at __IO_SPRITE_PALETTE   IO_SPRITE_PALETTE;
__sfr __at __IO_SPRITE_ATTRIBUTE IO_SPRITE_ATTRIBUTE;
__sfr __at __IO_SPRITE_PATTERN   IO_SPRITE_PATTERN;

__sfr __banked __at 0x303b IO_303B;

__sfr __at 0x53 IO_53;
__sfr __at 0x57 IO_57;
__sfr __at 0x5b IO_5B;

// Audio

__sfr __banked __at __IO_AUDIO_SELECT IO_AUDIO_SELECT;

__sfr __banked __at __IO_AUDIO_REG    IO_AUDIO_REG;
__sfr __banked __at __IO_AUDIO_DAT    IO_AUDIO_DAT;

__sfr __banked __at 0xfffd IO_FFFD;
__sfr __banked __at 0xbffd IO_BFFD;

#endif

// special zx next opcodes

#ifdef __CLANG
#define ZXN_NEXTREG(reg,data) ((void)ZXN_NEXTREG_##reg##_##data())
#endif

#ifdef __SDCC
#define ZXN_NEXTREG(reg,data) { extern void ZXN_NEXTREG_##reg##_##data(void) __preserves_regs(a,b,c,d,e,h,l,iyl,iyh); ZXN_NEXTREG_##reg##_##data(); }
#endif

#ifdef __SCCZ80
#define ZXN_NEXTREG(reg,data) ((void)ZXN_NEXTREG_##reg##_##data())
#endif

// tape i/o

struct zxtapehdr
{
	unsigned char hdtype;      // 0 = program, 1 = num array, 2 = char array, 3 = code/binary
	unsigned char hdname[10];  // space padded
	unsigned int  hdlen;       // ELINE - PROG, length field, length field, length in bytes
	unsigned int  hdadd;       // starting line number 0x8000 = none, lsb=0 msb=id, lsb=0 msb=id, address
	unsigned int  hdvars;      // VARS - PROG, 0, 0, 0
};

#define ZXT_TYPE_HEADER  0
#define ZXT_TYPE_DATA    0xff

extern unsigned char __LIB__ zx_tape_load_block(void *dst,unsigned int len,unsigned char type) __smallc;
extern unsigned char __LIB__ __CALLEE__ zx_tape_load_block_callee(void *dst,unsigned int len,unsigned char type) __smallc;
#define zx_tape_load_block(a,b,c) zx_tape_load_block_callee(a,b,c)


extern unsigned char __LIB__ zx_tape_save_block(void *src,unsigned int len,unsigned char type) __smallc;
extern unsigned char __LIB__ __CALLEE__ zx_tape_save_block_callee(void *src,unsigned int len,unsigned char type) __smallc;
#define zx_tape_save_block(a,b,c) zx_tape_save_block_callee(a,b,c)


extern unsigned char __LIB__ zx_tape_verify_block(void *dst,unsigned int len,unsigned char type) __smallc;
extern unsigned char __LIB__ __CALLEE__ zx_tape_verify_block_callee(void *dst,unsigned int len,unsigned char type) __smallc;
#define zx_tape_verify_block(a,b,c) zx_tape_verify_block_callee(a,b,c)



// miscellaneous

extern void __LIB__ __FASTCALL__ zx_border(unsigned char colour) __smallc;


extern void __LIB__ __FASTCALL__ zx_cls(unsigned char attr) __smallc;


extern void __LIB__ __FASTCALL__ zx_cls_attr(unsigned char attr) __smallc;


extern void __LIB__ __FASTCALL__ zx_cls_pix(unsigned char pix) __smallc;


extern void __LIB__ zx_cls_wc(struct r_Rect8 *r,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_cls_wc_callee(struct r_Rect8 *r,unsigned char attr) __smallc;
#define zx_cls_wc(a,b) zx_cls_wc_callee(a,b)


extern void __LIB__ zx_cls_wc_attr(struct r_Rect8 *r,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_cls_wc_attr_callee(struct r_Rect8 *r,unsigned char attr) __smallc;
#define zx_cls_wc_attr(a,b) zx_cls_wc_attr_callee(a,b)


extern void __LIB__ zx_cls_wc_pix(struct r_Rect8 *r,unsigned char pix) __smallc;
extern void __LIB__ __CALLEE__ zx_cls_wc_pix_callee(struct r_Rect8 *r,unsigned char pix) __smallc;
#define zx_cls_wc_pix(a,b) zx_cls_wc_pix_callee(a,b)


extern void __LIB__ zx_scroll_up(unsigned char rows,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_up_callee(unsigned char rows,unsigned char attr) __smallc;
#define zx_scroll_up(a,b) zx_scroll_up_callee(a,b)


extern void __LIB__ zx_scroll_up_attr(unsigned char rows,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_up_attr_callee(unsigned char rows,unsigned char attr) __smallc;
#define zx_scroll_up_attr(a,b) zx_scroll_up_attr_callee(a,b)


extern void __LIB__ zx_scroll_up_pix(unsigned char rows,unsigned char pix) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_up_pix_callee(unsigned char rows,unsigned char pix) __smallc;
#define zx_scroll_up_pix(a,b) zx_scroll_up_pix_callee(a,b)


extern void __LIB__ zx_scroll_wc_up(struct r_Rect8 *r,unsigned char rows,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_wc_up_callee(struct r_Rect8 *r,unsigned char rows,unsigned char attr) __smallc;
#define zx_scroll_wc_up(a,b,c) zx_scroll_wc_up_callee(a,b,c)


extern void __LIB__ zx_scroll_wc_up_attr(struct r_Rect8 *r,unsigned char rows,unsigned char attr) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_wc_up_attr_callee(struct r_Rect8 *r,unsigned char rows,unsigned char attr) __smallc;
#define zx_scroll_wc_up_attr(a,b,c) zx_scroll_wc_up_attr_callee(a,b,c)


extern void __LIB__ zx_scroll_wc_up_pix(struct r_Rect8 *r,unsigned char rows,unsigned char pix) __smallc;
extern void __LIB__ __CALLEE__ zx_scroll_wc_up_pix_callee(struct r_Rect8 *r,unsigned char rows,unsigned char pix) __smallc;
#define zx_scroll_wc_up_pix(a,b,c) zx_scroll_wc_up_pix_callee(a,b,c)



#ifdef __CLANG

extern void __LIB__ zx_visit_wc_attr(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_attr_callee(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
#define zx_visit_wc_attr(a,b) zx_visit_wc_attr_callee(a,b)


extern void __LIB__ zx_visit_wc_pix(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_pix_callee(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
#define zx_visit_wc_pix(a,b) zx_visit_wc_pix_callee(a,b)



#endif

#ifdef __SDCC

extern void __LIB__ zx_visit_wc_attr(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_attr_callee(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
#define zx_visit_wc_attr(a,b) zx_visit_wc_attr_callee(a,b)


extern void __LIB__ zx_visit_wc_pix(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_pix_callee(struct r_Rect8 *r,void (*visit)(unsigned char *)) __smallc;
#define zx_visit_wc_pix(a,b) zx_visit_wc_pix_callee(a,b)



#endif

#ifdef __SCCZ80

extern void __LIB__ zx_visit_wc_attr(struct r_Rect8 *r,void *visit) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_attr_callee(struct r_Rect8 *r,void *visit) __smallc;
#define zx_visit_wc_attr(a,b) zx_visit_wc_attr_callee(a,b)


extern void __LIB__ zx_visit_wc_pix(struct r_Rect8 *r,void *visit) __smallc;
extern void __LIB__ __CALLEE__ zx_visit_wc_pix_callee(struct r_Rect8 *r,void *visit) __smallc;
#define zx_visit_wc_pix(a,b) zx_visit_wc_pix_callee(a,b)



#endif

// display

// In the following, screen address refers to a pixel address within the display file while
// attribute address refers to the attributes area.
//
// Function names are constructed from the following atoms:
//
// saddr = screen address
// aaddr = attribute address
// 
// px    = pixel x coordinate (0..255)
// py    = pixel y coordinate (0..191)
// pxy   = pixel (x,y) coordinate
//
// cx    = character x coordinate (0..31)
// cy    = character y coordinate (0..23)
// cxy   = character (x,y) coordinate
//
// So for example:
//
// zx_saddr2cy(saddr) will return the character y coordinate corresponding to the given screen address
// zx_saddr2aaddr(saddr) will return the attribute address corresponding to the given screen address
// zx_pxy2aaddr(px,py) will return the attribute address corresponding to the given (x,y) pixel coordinate
//
// Some functions will return with carry flag set if coordinates or addresses move out of
// bounds.  In these cases the special z88dk keywords iferror() and ifnerror() can be used
// to test the carry flag and determine if invalid results are returned.  Check with the
// wiki documentation or the asm source files to see which functions support this.  If
// comments in the asm source file do not mention this, it is not supported.

extern unsigned char __LIB__ __FASTCALL__ zx_aaddr2cx(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_aaddr2cy(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_aaddr2px(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_aaddr2py(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_aaddr2saddr(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_aaddrcdown(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_aaddrcleft(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_aaddrcright(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_aaddrcup(void *aaddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_bitmask2px(unsigned char bitmask) __smallc;


extern unsigned char __LIB__ *zx_cxy2aaddr(unsigned char x,unsigned char y) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_cxy2aaddr_callee(unsigned char x,unsigned char y) __smallc;
#define zx_cxy2aaddr(a,b) zx_cxy2aaddr_callee(a,b)


extern unsigned char __LIB__ *zx_cxy2saddr(unsigned char x,unsigned char y) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_cxy2saddr_callee(unsigned char x,unsigned char y) __smallc;
#define zx_cxy2saddr(a,b) zx_cxy2saddr_callee(a,b)


extern unsigned char __LIB__ __FASTCALL__ *zx_cy2aaddr(unsigned char y) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_cy2saddr(unsigned char y) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_px2bitmask(unsigned char x) __smallc;


extern unsigned char __LIB__ *zx_pxy2aaddr(unsigned char x,unsigned char y) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_pxy2aaddr_callee(unsigned char x,unsigned char y) __smallc;
#define zx_pxy2aaddr(a,b) zx_pxy2aaddr_callee(a,b)


extern unsigned char __LIB__ *zx_pxy2saddr(unsigned char x,unsigned char y) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_pxy2saddr_callee(unsigned char x,unsigned char y) __smallc;
#define zx_pxy2saddr(a,b) zx_pxy2saddr_callee(a,b)


extern unsigned char __LIB__ __FASTCALL__ *zx_py2aaddr(unsigned char y) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_py2saddr(unsigned char y) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddr2aaddr(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_saddr2cx(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ zx_saddr2cy(void *saddr) __smallc;


extern unsigned int __LIB__ __FASTCALL__ zx_saddr2px(void *saddr) __smallc;


extern unsigned int __LIB__ __FASTCALL__ zx_saddr2py(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrcdown(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrcleft(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrcright(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrcup(void *saddr) __smallc;


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrpdown(void *saddr) __smallc;


extern unsigned char __LIB__ *zx_saddrpleft(void *saddr,unsigned char bitmask) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_saddrpleft_callee(void *saddr,unsigned char bitmask) __smallc;
#define zx_saddrpleft(a,b) zx_saddrpleft_callee(a,b)


extern unsigned char __LIB__ *zx_saddrpright(void *saddr,unsigned char bitmask) __smallc;
extern unsigned char __LIB__ __CALLEE__ *zx_saddrpright_callee(void *saddr,unsigned char bitmask) __smallc;
#define zx_saddrpright(a,b) zx_saddrpright_callee(a,b)


extern unsigned char __LIB__ __FASTCALL__ *zx_saddrpup(void *saddr) __smallc;



// graphics

extern int __LIB__ zx_pattern_fill(unsigned char x,unsigned char y,void *pattern,unsigned int depth) __smallc;
extern int __LIB__ __CALLEE__ zx_pattern_fill_callee(unsigned char x,unsigned char y,void *pattern,unsigned int depth) __smallc;
#define zx_pattern_fill(a,b,c,d) zx_pattern_fill_callee(a,b,c,d)



#endif
