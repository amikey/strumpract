unit status_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,status;

const
 objdata: record size: integer; data: array[0..2114] of byte end =
      (size: 2115; data: (
  84,80,70,48,9,116,115,116,97,116,117,115,102,111,8,115,116,97,116,117,
  115,102,111,5,99,111,108,111,114,4,167,188,201,0,7,118,105,115,105,98,
  108,101,8,8,98,111,117,110,100,115,95,120,3,28,2,8,98,111,117,110,
  100,115,95,121,3,22,1,9,98,111,117,110,100,115,95,99,120,3,32,1,
  9,98,111,117,110,100,115,95,99,121,3,140,0,12,98,111,117,110,100,115,
  95,99,120,109,105,110,3,32,1,12,98,111,117,110,100,115,95,99,121,109,
  105,110,3,140,0,12,98,111,117,110,100,115,95,99,120,109,97,120,3,32,
  1,12,98,111,117,110,100,115,95,99,121,109,97,120,3,140,0,26,99,111,
  110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,11,0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,
  116,97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,2,0,3,32,
  1,3,140,0,0,13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,
  9,119,111,95,100,105,97,108,111,103,22,119,111,95,119,105,110,100,111,119,
  99,101,110,116,101,114,109,101,115,115,97,103,101,0,7,99,97,112,116,105,
  111,110,6,6,76,97,121,111,117,116,13,119,105,110,100,111,119,111,112,97,
  99,105,116,121,5,0,0,0,0,0,0,0,128,255,255,9,111,110,99,114,
  101,97,116,101,100,7,9,111,110,99,114,101,97,116,101,100,15,109,111,100,
  117,108,101,99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,
  114,109,0,11,116,115,116,114,105,110,103,101,100,105,116,10,108,97,121,111,
  117,116,110,97,109,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,
  6,20,67,104,111,111,115,101,32,97,32,108,97,121,111,117,116,32,110,97,
  109,101,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,
  102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,102,114,97,
  109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,17,2,0,
  2,0,0,8,98,111,117,110,100,115,95,120,2,7,8,98,111,117,110,100,
  115,95,121,2,46,9,98,111,117,110,100,115,95,99,120,3,214,0,9,98,
  111,117,110,100,115,95,99,121,2,55,11,102,111,110,116,46,104,101,105,103,
  104,116,2,16,9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,
  100,101,102,97,117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,
  111,112,115,11,10,102,108,112,95,104,101,105,103,104,116,0,9,116,101,120,
  116,102,108,97,103,115,11,12,116,102,95,120,99,101,110,116,101,114,101,100,
  12,116,102,95,121,99,101,110,116,101,114,101,100,11,116,102,95,110,111,115,
  101,108,101,99,116,0,5,118,97,108,117,101,6,8,109,121,108,97,121,111,
  117,116,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,19,0,0,
  7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,49,17,102,114,
  97,109,101,46,111,112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,
  95,102,108,97,116,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,8,116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,115,95,
  120,3,228,0,8,98,111,117,110,100,115,95,121,2,40,9,98,111,117,110,
  100,115,95,99,120,2,56,9,98,111,117,110,100,115,95,99,121,2,28,5,
  115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,
  0,7,99,97,112,116,105,111,110,6,2,79,75,9,111,110,101,120,101,99,
  117,116,101,7,4,111,110,111,107,0,0,7,116,98,117,116,116,111,110,8,
  116,98,117,116,116,111,110,50,17,102,114,97,109,101,46,111,112,116,105,111,
  110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,
  111,112,116,105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,8,116,97,98,111,114,100,101,
  114,2,2,8,98,111,117,110,100,115,95,120,3,229,0,8,98,111,117,110,
  100,115,95,121,2,80,9,98,111,117,110,100,115,95,99,120,2,56,9,98,
  111,117,110,100,115,95,99,121,2,28,5,115,116,97,116,101,11,15,97,115,
  95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,
  97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,110,
  6,6,67,97,110,99,101,108,9,111,110,101,120,101,99,117,116,101,7,8,
  111,110,99,97,110,99,101,108,0,0,13,116,102,105,108,101,108,105,115,116,
  118,105,101,119,10,108,105,115,116,95,102,105,108,101,115,13,111,112,116,105,
  111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,
  111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,115,17,111,
  119,95,102,111,99,117,115,98,97,99,107,111,110,101,115,99,13,111,119,95,
  109,111,117,115,101,119,104,101,101,108,17,111,119,95,100,101,115,116,114,111,
  121,119,105,100,103,101,116,115,0,13,102,114,97,109,101,46,99,97,112,116,
  105,111,110,6,15,67,104,111,111,115,101,32,97,32,108,97,121,111,117,116,
  22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,108,
  97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,17,2,0,2,0,
  0,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,
  116,2,2,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,105,116,
  101,109,115,1,2,0,2,1,0,21,102,97,99,101,46,102,97,100,101,95,
  99,111,108,111,114,46,99,111,117,110,116,2,2,21,102,97,99,101,46,102,
  97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,6,0,0,
  160,4,161,161,161,0,0,15,102,97,99,101,46,108,111,99,97,108,112,114,
  111,112,115,11,15,102,97,108,95,102,97,100,105,114,101,99,116,105,111,110,
  0,8,116,97,98,111,114,100,101,114,2,3,8,98,111,117,110,100,115,95,
  120,2,3,8,98,111,117,110,100,115,95,121,2,8,9,98,111,117,110,100,
  115,95,99,120,3,220,0,9,98,111,117,110,100,115,95,99,121,2,126,16,
  100,97,116,97,114,111,119,108,105,110,101,99,111,108,111,114,4,5,0,0,
  160,16,100,97,116,97,99,111,108,108,105,110,101,99,111,108,111,114,4,5,
  0,0,160,9,99,101,108,108,119,105,100,116,104,3,214,0,10,99,101,108,
  108,104,101,105,103,104,116,2,20,11,111,112,116,105,111,110,115,103,114,105,
  100,11,19,111,103,95,102,111,99,117,115,99,101,108,108,111,110,101,110,116,
  101,114,13,111,103,95,97,117,116,111,97,112,112,101,110,100,9,111,103,95,
  115,111,114,116,101,100,17,111,103,95,109,111,117,115,101,115,99,114,111,108,
  108,99,111,108,0,7,111,112,116,105,111,110,115,11,12,108,118,111,95,114,
  101,97,100,111,110,108,121,13,108,118,111,95,100,114,97,119,102,111,99,117,
  115,15,108,118,111,95,102,111,99,117,115,115,101,108,101,99,116,15,108,118,
  111,95,109,111,117,115,101,115,101,108,101,99,116,13,108,118,111,95,107,101,
  121,115,101,108,101,99,116,10,108,118,111,95,108,111,99,97,116,101,19,108,
  118,111,95,104,105,110,116,99,108,105,112,112,101,100,116,101,120,116,0,18,
  105,116,101,109,108,105,115,116,46,105,109,97,103,101,108,105,115,116,7,20,
  102,105,108,101,100,105,97,108,111,103,114,101,115,46,105,109,97,103,101,115,
  19,105,116,101,109,108,105,115,116,46,105,109,97,103,101,119,105,100,116,104,
  2,16,20,105,116,101,109,108,105,115,116,46,105,109,97,103,101,104,101,105,
  103,104,116,2,16,12,99,101,108,108,119,105,100,116,104,109,105,110,2,50,
  11,111,112,116,105,111,110,115,102,105,108,101,11,16,102,108,118,111,95,99,
  104,101,99,107,115,117,98,100,105,114,0,16,102,105,108,101,108,105,115,116,
  46,111,112,116,105,111,110,115,11,12,102,108,111,95,115,111,114,116,110,97,
  109,101,12,102,108,111,95,115,111,114,116,116,121,112,101,0,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,14,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tstatusfo,'');
end.
