
/* 
 * Old-school way to deal with graphics on a ZX81
 * It show how to deal with big pictures with simple memory-copy operations.
 *
 * Horse animation, keep tapping on the keyboard to make it run faster !
 * by Stefano Bodrato, 2020
 *
 * To add text on top, first build the program disabling autorun:
 * zcc +zx81 -create-app horse.c -Cz--disable-autorun
 * ..then edit line 2 (RAND USR..) and copy it, e.g. to line 10,
 * and add your PRINT instruction just after line 1 (REM..).
 * Save before testing it !
 *
 * It works on a LAMBDA 8300, use 'subtypes' for different ROM versions (cac3, lambdamono)
 */

#include <stdio.h>
//#include <string.h>

char horseg[] =
{
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x82, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x83, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x80, 0x07, 0x03, 0x80, 0x80, 0x05, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x02, 0x03, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x87, 0x80, 0x07, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x02, 0x84, 0x80, 0x01, 0x02, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x81, 0x80, 0x07, 0x00, 0x00, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00, 0x84, 0x80, 0x80, 0x07, 0x00, 0x02, 0x03, 0x03, 0x03, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x84, 0x82, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x84, 0x80, 0x82, 0x04, 0x00, 0x00, 0x00, 0x87, 0x80, 0x05, 0x00, 0x80, 0x05, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x02, 0x84, 0x80, 0x00, 0x00, 0x87, 0x80, 0x07, 0x00, 0x00, 0x85, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x82, 0x04, 0x00, 0x80, 0x05, 0x00, 0x85, 0x03, 0x00, 0x00, 0x00, 0x02, 0x84, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x80, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x02, 0x84, 0x80, 0x05, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x87, 0x80, 0x80, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x83, 0x80, 0x80, 0x01, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x87, 0x80, 0x07, 0x00, 0x02, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x03, 0x07, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x03, 0x03, 0x03, 0x03, 0x80, 0x80, 0x80, 0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x07, 0x85, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84, 0x80, 0x07, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x07, 0x00, 0x85, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 0x05, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x00, 0x02, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x07, 0x00, 0x00, 0x00, 0x84, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x00, 0x00, 0x00, 0x84, 0x80, 0x83, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x80, 0x80, 0x80, 0x82, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x83, 0x83, 0x00, 0x00, 0x00, 0x83, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x84, 0x80, 0x80, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x81, 0x07, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x02, 0x03, 0x00, 0x76, 
0x00, 0x00, 0x85, 0x80, 0x01, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x02, 0x80, 0x80, 0x00, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x87, 0x80, 0x80, 0x05, 0x00, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x02, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x03, 0x03, 0x03, 0x84, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x07, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x84, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x87, 0x80, 0x05, 0x85, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x85, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x85, 0x07, 0x00, 0x02, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x07, 0x00, 0x00, 0x85, 0x80, 0x04, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x87, 0x80, 0x05, 0x00, 0x00, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x05, 0x00, 0x00, 0x00, 0x84, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x85, 0x80, 0x07, 0x00, 0x00, 0x00, 0x85, 0x80, 0x83, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x82, 0x00, 0x00, 0x00, 0x00, 0x80, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x81, 0x80, 0x80, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x00, 0x87, 0x83, 0x83, 0x83, 0x00, 0x00, 0x87, 0x83, 0x83, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x82, 0x00, 0x76, 
0x00, 0x00, 0x81, 0x80, 0x03, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x02, 0x80, 0x80, 0x00, 0x76, 
0x00, 0x87, 0x80, 0x07, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x87, 0x07, 0x80, 0x01, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x81, 0x07, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x07, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x81, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x03, 0x03, 0x84, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x80, 0x07, 0x01, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x80, 0x01, 0x02, 0x80, 0x82, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x80, 0x84, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x07, 0x00, 0x00, 0x84, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x87, 0x81, 0x07, 0x85, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x00, 0x00, 0x00, 0x00, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x87, 0x80, 0x07, 0x01, 0x85, 0x80, 0x83, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x04, 0x00, 0x00, 0x00, 0x85, 0x80, 0x83, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x05, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x83, 0x80, 0x80, 0x05, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x83, 0x83, 0x83, 0x81, 0x82, 0x83, 0x04, 0x00, 0x00, 0x87, 0x83, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x76, 
0x00, 0x00, 0x87, 0x81, 0x80, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x80, 0x80, 0x82, 0x76, 
0x00, 0x00, 0x81, 0x80, 0x05, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x84, 0x80, 0x76, 
0x00, 0x84, 0x80, 0x80, 0x00, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x84, 0x07, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x02, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x80, 0x03, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x80, 0x07, 0x01, 0x00, 0x00, 0x03, 0x03, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x80, 0x05, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x87, 0x81, 0x80, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x03, 0x02, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x81, 0x07, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x07, 0x01, 0x00, 0x00, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x81, 0x80, 0x80, 0x82, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x83, 0x83, 0x83, 0x80, 0x83, 0x04, 0x00, 0x00, 0x00, 0x83, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x04, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x81, 0x80, 0x03, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x80, 0x80, 0x82, 0x00, 0x76, 
0x00, 0x00, 0x85, 0x80, 0x05, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x84, 0x80, 0x00, 0x76, 
0x00, 0x83, 0x80, 0x80, 0x00, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x87, 0x81, 0x80, 0x05, 0x00, 0x85, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x84, 0x01, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x07, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x02, 0x03, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x85, 0x05, 0x84, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x81, 0x05, 0x02, 0x80, 0x05, 0x00, 0x00, 0x00, 0x81, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x81, 0x80, 0x01, 0x00, 0x80, 0x05, 0x00, 0x00, 0x85, 0x80, 0x80, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00, 0x84, 0x01, 0x00, 0x00, 0x00, 0x84, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x05, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x83, 0x83, 0x83, 0x83, 0x04, 0x83, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x83, 0x80, 0x82, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x84, 0x80, 0x01, 0x00, 0x76, 
0x00, 0x00, 0x81, 0x80, 0x07, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x83, 0x80, 0x80, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x87, 0x80, 0x80, 0x01, 0x00, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x02, 0x85, 0x05, 0x00, 0x00, 0x02, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x81, 0x80, 0x80, 0x80, 0x00, 0x00, 0x03, 0x03, 0x80, 0x80, 0x80, 0x82, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x03, 0x84, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x80, 0x05, 0x00, 0x81, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x80, 0x84, 0x80, 0x04, 0x00, 0x00, 0x81, 0x80, 0x86, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x84, 0x80, 0x82, 0x81, 0x80, 0x01, 0x85, 0x07, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x00, 0x84, 0x80, 0x80, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 

0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x05, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x80, 0x04, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x87, 0x80, 0x80, 0x80, 0x80, 0x80, 0x82, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x81, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x02, 0x80, 0x80, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x83, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x81, 0x80, 0x01, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x87, 0x80, 0x07, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x85, 0x80, 0x80, 0x00, 0x00, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x02, 0x80, 0x01, 0x00, 0x00, 0x00, 0x84, 0x80, 0x80, 0x07, 0x00, 0x03, 0x84, 0x80, 0x80, 0x80, 0x80, 0x80, 0x82, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 0x07, 0x03, 0x84, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x85, 0x80, 0x00, 0x85, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x84, 0x80, 0x80, 0x04, 0x00, 0x00, 0x87, 0x83, 0x81, 0x80, 0x87, 0x80, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 0x80, 0x05, 0x85, 0x80, 0x80, 0x07, 0x00, 0x85, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x84, 0x80, 0x04, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76 

};

//char *display;
//extern int d_file @16396;


void copy_frame(char *spr) {
#asm
	pop bc
	pop de
	push de        ; picture: current frame data
	push bc
#endasm

#ifdef LAMBDA
#asm
	ld hl,16510
#endasm
#else
#asm
	ld hl,(16396)  ; D_FILE, starts with 0x76 (EOL), so we add 1
#endasm
#endif

#asm
	ld bc,33*4+1   ; move the picture away from the top
	add hl,bc
	ex de,hl
	ld bc,416      ; picture: single frame size
	push hl
	
	ld hl,$4034    ; FRAMES (counter of the ZX81 video refresh cycles)
	ld a,(hl)      ; get old FRAMES
Sync:
	cp (hl)        ; compare to new FRAMES
	jp z,Sync	   ; exit after a change is detected, to avoid flicker
	
	pop hl
	ldir           ; copy picture data
	
#endasm
}


main()
{
	int x, y, a ,b;
	int speed, flg;

// Set up the color attributes, in case we have the hardware for it
#ifdef LAMBDA
#asm
	ld hl,$207D
	ld bc,33*4+1   ; move the picture away from the top
	add hl,bc
	ld (hl),6
	ld d,h
	ld e,l
	inc de
	ld bc,416      ; picture: single frame size
	ldir
#endasm
#endif



	//display=d_file+1;
	// Approx. way to collapse the display file,
	// possible way for direct video memory access from C
	//memset(display,0x76,693);
	
	speed=300;
	flg=0;
	while (1) {
		for(y=0 ; y<8 ; y++) {
			copy_frame(horseg+(416*y));

			for (x=0; x<(speed/3); x++) {
				if (getk() & !flg) { speed/=2;	flg=1; }
				if (!getk()) flg=0;
			}
			speed++;	
		}
	}
	
}

