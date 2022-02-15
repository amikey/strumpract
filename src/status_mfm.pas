unit status_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,status;

const
 objdata: record size: integer; data: array[0..2635] of byte end =
      (size: 2636; data: (
  84,80,70,48,9,116,115,116,97,116,117,115,102,111,8,115,116,97,116,117,
  115,102,111,5,99,111,108,111,114,4,185,201,167,0,15,102,97,99,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,116,101,
  109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,97,99,101,
  112,108,97,121,101,114,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,186,1,8,98,111,117,110,100,115,95,121,3,3,1,9,
  98,111,117,110,100,115,95,99,120,3,32,1,9,98,111,117,110,100,115,95,
  99,121,2,60,12,98,111,117,110,100,115,95,99,120,109,105,110,3,32,1,
  12,98,111,117,110,100,115,95,99,120,109,97,120,3,32,1,26,99,111,110,
  116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,
  97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,2,0,3,32,1,
  2,60,0,13,111,112,116,105,111,110,115,119,105,110,100,111,119,11,9,119,
  111,95,100,105,97,108,111,103,22,119,111,95,119,105,110,100,111,119,99,101,
  110,116,101,114,109,101,115,115,97,103,101,0,9,102,111,110,116,46,110,97,
  109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,15,102,111,110,116,
  46,108,111,99,97,108,112,114,111,112,115,11,0,7,99,97,112,116,105,111,
  110,6,6,76,97,121,111,117,116,15,105,99,111,110,46,111,114,105,103,102,
  111,114,109,97,116,6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,
  101,10,4,3,0,0,0,0,0,0,0,0,0,0,16,0,0,0,15,0,
  0,0,208,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,220,
  192,5,191,219,191,1,136,156,136,1,78,89,78,1,88,101,88,1,155,177,
  155,1,192,220,192,10,191,219,191,1,115,132,115,1,3,4,3,1,90,103,
  90,1,72,83,72,1,9,10,9,1,151,174,151,1,192,220,192,5,189,216,
  189,1,192,220,192,1,191,219,191,1,192,220,192,2,41,47,41,1,116,133,
  116,1,192,220,192,1,194,222,194,1,75,87,75,1,77,88,77,1,192,220,
  192,2,191,219,191,1,192,220,192,1,189,216,189,1,102,118,102,1,61,71,
  61,1,189,217,189,1,192,220,192,2,24,28,24,1,151,173,151,1,192,220,
  192,2,135,155,135,1,96,110,96,1,192,220,192,2,189,217,189,1,61,71,
  61,1,102,118,102,1,174,199,174,1,35,40,35,1,73,84,73,1,193,221,
  193,1,192,220,192,1,59,68,59,1,66,75,66,1,160,184,160,1,158,181,
  158,1,172,198,172,1,195,224,195,1,192,220,192,1,193,221,193,1,73,84,
  73,1,33,38,33,1,169,193,169,1,191,219,191,1,177,203,177,1,10,12,
  10,1,138,158,138,1,184,211,184,1,57,65,57,1,0,0,0,3,9,10,
  9,1,72,82,72,1,184,211,184,1,138,158,138,1,10,12,10,1,169,193,
  169,1,191,219,191,1,192,220,192,2,82,94,82,1,45,52,45,2,22,51,
  22,1,82,183,82,1,90,201,90,1,52,117,52,1,1,3,1,1,4,11,
  4,1,45,52,45,2,82,94,82,1,192,220,192,3,191,219,191,1,147,169,
  147,1,0,0,0,1,22,50,22,1,109,246,109,1,112,255,112,2,113,255,
  113,1,46,101,46,1,42,96,42,1,22,50,22,1,0,0,0,1,147,169,
  147,1,191,219,191,1,192,220,192,3,160,184,160,1,0,0,0,1,86,197,
  86,1,64,147,64,1,105,239,105,1,112,255,112,2,59,127,59,1,42,97,
  42,1,85,195,85,1,0,0,0,1,160,184,160,1,192,220,192,4,160,184,
  160,1,6,15,6,1,103,236,103,1,23,53,23,1,67,150,67,1,112,254,
  112,2,43,93,43,1,44,102,44,1,102,234,102,1,5,13,5,1,160,184,
  160,1,192,220,192,4,160,184,160,1,7,17,7,1,104,237,104,1,67,153,
  67,1,9,21,9,1,65,150,65,1,58,134,58,1,5,11,5,1,85,192,
  85,1,104,237,104,1,7,17,7,1,160,184,160,1,192,220,192,4,176,202,
  176,1,2,5,2,1,98,224,98,1,111,254,111,1,65,148,65,1,23,53,
  23,1,26,61,26,1,76,173,76,1,112,254,112,1,98,224,98,1,2,5,
  2,1,176,202,176,1,192,220,192,4,194,223,194,1,54,62,54,1,49,113,
  49,1,113,254,113,1,112,255,112,1,113,255,113,2,112,255,112,1,113,254,
  113,1,49,113,49,1,54,62,54,1,194,223,194,1,192,220,192,4,191,219,
  191,1,155,178,155,1,9,12,9,1,63,141,63,1,113,255,113,1,111,254,
  111,2,113,255,113,1,63,141,63,1,9,12,9,1,155,178,155,1,191,219,
  191,1,192,220,192,6,140,160,140,1,13,15,13,1,19,44,19,1,51,118,
  51,2,19,44,19,1,13,15,13,1,140,160,140,1,192,220,192,4,13,119,
  105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,0,0,
  128,255,255,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,
  8,116,109,115,101,102,111,114,109,0,7,116,98,117,116,116,111,110,2,111,
  107,14,111,112,116,105,111,110,115,119,105,100,103,101,116,49,11,0,5,99,
  111,108,111,114,4,3,0,0,128,17,102,114,97,109,101,46,111,112,116,105,
  111,110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,
  95,111,112,116,105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,49,11,0,19,102,97,99,101,46,102,
  97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,19,102,97,99,101,
  46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,1,2,0,2,1,
  0,21,102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,99,111,
  117,110,116,2,2,21,102,97,99,101,46,102,97,100,101,95,99,111,108,111,
  114,46,105,116,101,109,115,1,4,235,235,235,0,4,158,158,158,0,0,19,
  102,97,99,101,46,102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,
  7,103,100,95,100,111,119,110,15,102,97,99,101,46,108,111,99,97,108,112,
  114,111,112,115,11,15,102,97,108,95,102,97,100,105,114,101,99,116,105,111,
  110,0,8,116,97,98,111,114,100,101,114,2,1,8,98,111,117,110,100,115,
  95,120,3,212,0,8,98,111,117,110,100,115,95,121,2,4,9,98,111,117,
  110,100,115,95,99,120,2,72,9,98,111,117,110,100,115,95,99,121,2,24,
  12,98,111,117,110,100,115,95,99,120,109,105,110,2,35,5,115,116,97,116,
  101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,
  97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,13,97,115,95,108,111,99,97,108,99,111,108,111,114,17,
  97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,
  97,112,116,105,111,110,6,3,38,79,107,9,111,110,101,120,101,99,117,116,
  101,7,4,111,110,111,107,0,0,7,116,98,117,116,116,111,110,6,99,97,
  110,99,101,108,14,111,112,116,105,111,110,115,119,105,100,103,101,116,49,11,
  0,5,99,111,108,111,114,4,3,0,0,128,17,102,114,97,109,101,46,111,
  112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,
  13,102,115,111,95,102,111,99,117,115,114,101,99,116,0,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,111,112,
  116,105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,19,102,97,99,101,46,102,97,100,101,
  95,112,111,115,46,99,111,117,110,116,2,2,19,102,97,99,101,46,102,97,
  100,101,95,112,111,115,46,105,116,101,109,115,1,2,0,2,1,0,21,102,
  97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,99,111,117,110,116,
  2,2,21,102,97,99,101,46,102,97,100,101,95,99,111,108,111,114,46,105,
  116,101,109,115,1,4,235,235,235,0,4,158,158,158,0,0,19,102,97,99,
  101,46,102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,100,
  95,100,111,119,110,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,
  115,11,15,102,97,108,95,102,97,100,105,114,101,99,116,105,111,110,0,8,
  116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,3,
  212,0,8,98,111,117,110,100,115,95,121,2,30,9,98,111,117,110,100,115,
  95,99,120,2,72,9,98,111,117,110,100,115,95,99,121,2,24,12,98,111,
  117,110,100,115,95,99,120,109,105,110,2,35,5,115,116,97,116,101,11,15,
  97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,13,97,115,95,108,
  111,99,97,108,99,111,108,111,114,0,7,99,97,112,116,105,111,110,6,7,
  38,67,97,110,99,101,108,11,109,111,100,97,108,114,101,115,117,108,116,7,
  9,109,114,95,99,97,110,99,101,108,0,0,11,116,115,116,114,105,110,103,
  101,100,105,116,10,108,97,121,111,117,116,110,97,109,101,12,102,114,97,109,
  101,46,108,101,118,101,108,111,2,0,16,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,10,102,114,108,95,108,101,118,101,108,111,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,
  2,2,19,102,97,99,101,46,102,97,100,101,95,112,111,115,46,105,116,101,
  109,115,1,2,0,2,1,0,21,102,97,99,101,46,102,97,100,101,95,99,
  111,108,111,114,46,99,111,117,110,116,2,2,21,102,97,99,101,46,102,97,
  100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,255,255,255,0,
  4,201,201,201,0,0,19,102,97,99,101,46,102,97,100,101,95,100,105,114,
  101,99,116,105,111,110,7,7,103,100,95,100,111,119,110,15,102,97,99,101,
  46,108,111,99,97,108,112,114,111,112,115,11,15,102,97,108,95,102,97,100,
  105,114,101,99,116,105,111,110,0,7,118,105,115,105,98,108,101,8,8,98,
  111,117,110,100,115,95,120,2,4,8,98,111,117,110,100,115,95,121,2,5,
  9,98,111,117,110,100,115,95,99,120,3,204,0,9,98,111,117,110,100,115,
  95,99,121,2,49,11,102,111,110,116,46,104,101,105,103,104,116,2,16,9,
  102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,
  108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,10,
  102,108,112,95,104,101,105,103,104,116,0,9,116,101,120,116,102,108,97,103,
  115,11,12,116,102,95,120,99,101,110,116,101,114,101,100,12,116,102,95,121,
  99,101,110,116,101,114,101,100,11,116,102,95,110,111,115,101,108,101,99,116,
  0,5,118,97,108,117,101,6,8,109,121,108,97,121,111,117,116,13,114,101,
  102,102,111,110,116,104,101,105,103,104,116,2,19,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tstatusfo,'');
end.
