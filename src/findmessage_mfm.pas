unit findmessage_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,findmessage;

const
 objdata: record size: integer; data: array[0..4467] of byte end =
      (size: 4468; data: (
  84,80,70,48,14,116,102,105,110,100,109,101,115,115,97,103,101,102,111,13,
  102,105,110,100,109,101,115,115,97,103,101,102,111,7,118,105,115,105,98,108,
  101,8,8,98,111,117,110,100,115,95,120,3,203,1,8,98,111,117,110,100,
  115,95,121,3,42,1,9,98,111,117,110,100,115,95,99,120,3,96,1,9,
  98,111,117,110,100,115,95,99,121,2,58,26,99,111,110,116,97,105,110,101,
  114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,
  46,98,111,117,110,100,115,1,2,0,2,0,3,96,1,2,58,0,7,99,
  97,112,116,105,111,110,6,17,70,105,110,100,32,105,110,32,115,111,110,103,
  32,108,105,115,116,12,105,99,111,110,46,111,112,116,105,111,110,115,11,10,
  98,109,111,95,109,97,115,107,101,100,12,98,109,111,95,103,114,97,121,109,
  97,115,107,0,15,105,99,111,110,46,111,114,105,103,102,111,114,109,97,116,
  6,3,112,110,103,10,105,99,111,110,46,105,109,97,103,101,10,0,8,0,
  0,0,0,0,0,18,0,0,0,24,0,0,0,24,0,0,0,136,5,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,30,182,101,43,
  1,183,102,46,1,184,105,51,1,183,103,47,2,184,105,51,1,183,102,46,
  1,182,101,43,1,255,255,255,14,175,97,41,1,177,100,47,1,182,105,58,
  1,204,129,107,1,217,144,134,1,224,156,153,1,224,159,157,1,224,160,153,
  1,215,151,134,1,189,118,76,1,177,101,47,1,175,98,41,1,255,255,255,
  11,169,94,40,1,169,96,44,1,192,117,91,1,208,136,134,1,144,88,79,
  1,92,53,45,1,69,39,30,1,75,43,33,1,100,62,56,1,165,117,109,
  1,233,183,182,1,213,155,139,1,172,98,47,1,169,94,40,1,255,255,255,
  9,162,90,38,1,163,92,42,1,197,124,111,1,170,103,98,1,92,53,37,
  1,92,62,43,1,87,64,48,1,73,60,50,1,74,61,52,1,84,62,47,
  1,86,59,43,1,89,56,42,1,212,167,163,1,227,173,169,1,165,94,45,
  1,163,91,38,1,255,255,255,8,158,89,41,1,178,106,79,1,173,105,98,
  1,96,58,36,1,83,63,49,1,75,77,77,1,94,94,94,1,153,155,157,
  1,218,218,218,1,212,212,213,1,118,118,118,1,82,63,51,1,82,52,36,
  1,198,145,141,1,203,140,124,1,158,89,41,1,255,255,255,7,150,83,35,
  1,155,87,45,1,188,116,112,1,103,59,38,1,85,66,52,1,91,94,94,
  1,123,123,123,1,139,143,143,1,226,226,227,1,251,252,252,1,255,255,255,
  1,245,245,246,1,156,157,157,1,91,71,58,1,93,58,42,1,222,159,158,
  1,168,101,65,1,150,83,35,1,255,255,255,6,144,81,35,1,166,99,75,
  1,148,88,72,1,93,65,45,1,94,94,94,1,131,135,135,1,163,163,168,
  1,188,188,195,1,218,218,218,1,251,251,251,1,253,253,253,1,246,246,246,
  1,194,197,197,1,104,104,104,1,90,63,48,1,159,105,94,1,192,124,109,
  1,145,81,36,1,255,255,255,6,140,79,38,1,173,104,89,1,119,68,51,
  1,101,78,63,1,121,124,124,1,167,167,172,1,204,204,204,1,204,217,217,
  1,213,213,213,1,210,225,225,1,217,217,217,1,208,218,218,1,178,178,184,
  1,133,137,137,1,103,81,68,1,117,76,60,1,201,130,122,1,140,79,38,
  1,255,255,255,6,132,73,33,1,182,109,103,1,117,67,46,1,109,90,82,
  1,144,148,148,1,185,193,193,1,204,204,217,1,204,221,221,1,209,232,232,
  1,209,209,209,1,200,219,219,1,213,213,213,1,204,204,204,1,156,161,161,
  1,114,102,91,1,96,62,41,1,206,131,128,1,133,74,33,1,131,73,30,
  1,255,255,255,5,126,70,30,1,178,105,99,1,128,71,54,1,119,98,89,
  1,156,161,161,1,202,202,213,1,210,225,225,1,232,232,232,1,213,213,213,
  1,204,204,204,1,204,204,230,1,207,207,223,1,209,209,209,1,166,172,172,
  1,120,107,96,1,100,67,45,1,200,123,120,1,127,70,32,1,125,69,29,
  1,255,255,255,5,122,67,32,1,162,93,80,1,152,80,68,1,134,96,84,
  1,159,164,164,1,211,211,211,1,210,210,210,1,230,230,230,1,255,255,255,
  1,170,170,170,1,198,227,227,1,221,221,221,1,206,206,219,1,174,174,180,
  1,116,94,77,1,120,77,61,1,182,106,98,1,122,69,32,1,255,255,255,
  6,112,63,27,1,144,82,62,1,178,92,83,1,143,90,79,1,149,154,154,
  1,191,200,200,1,201,215,215,1,216,216,235,1,227,227,227,1,223,223,223,
  1,213,213,213,1,210,225,225,1,200,211,211,1,163,163,168,1,112,83,63,
  1,142,86,73,1,158,91,75,1,114,63,28,1,255,255,255,6,110,61,25,
  1,119,66,35,1,183,99,94,1,183,94,90,1,153,105,94,1,176,176,182,
  1,209,209,220,1,213,213,213,1,221,221,221,1,204,221,221,1,210,210,210,
  1,206,206,206,1,188,195,195,1,125,104,87,1,112,77,54,1,179,102,98,
  1,124,69,40,1,110,61,25,1,255,255,255,7,113,63,28,1,139,77,56,
  1,197,96,92,1,185,101,98,1,159,108,98,1,183,183,190,1,211,211,211,
  1,206,219,219,2,200,211,211,1,188,195,195,1,131,108,92,1,114,80,57,
  1,156,90,82,1,146,80,63,1,95,57,31,1,0,0,0,1,255,255,255,
  7,110,61,25,1,112,62,27,1,157,85,75,1,192,94,90,1,185,99,93,
  1,160,99,87,1,153,108,92,1,151,126,112,1,148,127,114,1,132,103,82,
  1,124,89,67,1,116,79,56,1,152,87,76,1,159,86,76,1,116,71,40,
  1,70,71,73,1,33,37,43,1,255,255,255,8,110,61,25,1,112,62,27,
  1,138,75,54,1,178,92,87,1,170,89,80,1,159,90,77,1,144,87,68,
  1,130,82,61,1,127,81,60,1,137,82,67,1,163,87,84,1,139,75,57,
  1,111,63,30,1,91,86,79,1,141,151,159,1,54,59,62,1,33,38,42,
  1,255,255,255,8,110,61,25,1,112,62,28,1,118,65,33,1,139,74,56,
  1,151,81,69,1,162,85,80,2,151,81,69,1,140,74,56,1,116,64,33,
  1,90,53,28,1,87,72,60,1,89,80,70,1,85,94,99,1,136,146,152,
  1,41,43,48,1,32,37,39,1,0,0,0,1,255,255,255,7,0,0,0,
  1,108,60,25,1,110,61,26,1,112,62,28,1,111,61,26,2,111,61,28,
  1,103,57,25,1,85,47,19,1,14,19,21,1,20,22,25,1,55,53,48,
  1,72,68,62,1,87,97,103,1,127,135,142,1,31,35,39,1,23,23,27,
  1,0,0,0,2,255,255,255,4,0,0,0,5,4,2,1,1,6,4,1,
  1,0,0,0,4,9,9,12,1,19,21,24,1,33,35,36,1,56,56,55,
  1,92,100,106,1,115,123,129,1,28,32,36,1,6,12,12,1,0,0,0,
  1,255,255,255,4,0,0,0,12,4,4,4,1,17,19,21,1,23,26,29,
  1,41,46,48,1,95,103,108,1,64,70,75,1,17,19,21,1,0,0,0,
  1,255,255,255,4,0,0,0,13,0,2,2,1,15,18,19,1,20,23,26,
  1,27,32,35,1,20,23,27,1,15,19,19,1,0,0,0,1,255,255,255,
  5,0,0,0,14,15,18,20,1,17,21,24,2,0,0,0,2,255,255,255,
  7,0,0,0,15,255,255,255,2,64,2,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,66,137,199,243,244,201,139,69,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,17,173,244,254,255,255,255,255,254,246,180,21,0,0,0,
  0,0,0,0,0,0,0,0,61,237,249,255,255,252,253,253,253,254,255,252,
  241,68,0,0,0,0,0,0,0,0,0,18,238,255,255,251,226,173,146,146,
  177,227,252,255,255,242,22,0,0,0,0,0,0,0,0,174,248,255,251,168,
  106,95,113,172,172,116,169,251,255,252,184,0,0,0,0,0,0,0,66,244,
  255,249,164,95,77,64,126,226,252,214,117,159,251,255,246,74,0,0,0,0,
  0,0,136,253,255,220,95,70,50,34,33,139,195,171,102,88,222,254,254,147,
  0,0,0,0,0,0,198,255,247,163,76,49,25,20,18,17,20,27,43,69,
  158,248,255,208,0,0,0,0,0,0,243,255,248,127,62,33,20,15,11,11,
  14,18,25,54,112,250,255,247,1,0,0,0,0,0,244,255,250,124,54,24,
  17,11,6,5,10,16,22,46,106,250,255,248,2,0,0,0,0,0,200,255,
  249,167,53,23,17,10,4,3,9,15,21,44,144,247,255,210,0,0,0,0,
  0,0,138,253,254,228,58,28,19,13,9,8,12,17,23,50,202,253,254,149,
  0,0,0,0,0,0,69,243,255,253,160,42,22,18,15,15,17,21,34,122,
  247,255,244,77,0,0,0,0,0,0,0,178,248,255,254,150,39,23,21,21,
  23,34,112,246,255,255,240,2,0,0,0,0,0,0,0,19,238,255,255,253,
  219,139,80,76,121,193,248,255,255,255,252,164,0,0,0,0,0,0,0,0,
  65,239,248,255,254,248,249,248,244,253,255,255,255,255,255,251,124,0,0,0,
  0,0,0,0,0,21,181,243,254,255,255,255,255,254,250,250,250,255,255,255,
  250,87,1,0,0,0,0,0,0,0,1,75,148,208,247,248,213,160,100,110,
  242,244,255,255,255,250,62,4,1,0,0,0,0,1,2,5,11,17,26,35,
  41,49,56,63,110,239,244,255,255,255,247,41,4,0,0,0,0,1,3,8,
  15,23,32,40,49,58,66,76,95,134,232,247,255,255,253,127,7,0,0,0,
  0,1,3,7,12,20,27,35,44,52,59,66,74,88,109,203,244,243,245,68,
  4,0,0,0,0,0,1,2,4,8,12,18,24,29,33,35,36,36,35,31,
  87,161,73,3,1,0,0,0,0,0,0,0,1,1,2,4,5,6,7,8,
  7,6,5,4,2,1,1,0,0,13,119,105,110,100,111,119,111,112,97,99,
  105,116,121,5,0,0,0,0,0,0,0,128,255,255,7,111,110,99,108,111,
  115,101,7,11,111,110,99,108,111,115,101,102,105,110,100,15,109,111,100,117,
  108,101,99,108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,
  109,0,7,116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,51,3,
  84,97,103,2,1,17,102,114,97,109,101,46,111,112,116,105,111,110,115,115,
  107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,111,112,116,
  105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,15,102,97,99,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,8,116,97,98,111,114,100,101,114,2,1,8,98,
  111,117,110,100,115,95,120,3,25,1,8,98,111,117,110,100,115,95,121,2,
  2,9,98,111,117,110,100,115,95,99,120,2,66,9,98,111,117,110,100,115,
  95,99,121,2,24,5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,
  117,108,116,15,97,115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,
  97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,
  111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,
  111,110,6,5,69,38,120,105,116,9,111,110,101,120,101,99,117,116,101,7,
  7,111,110,99,108,111,115,101,0,0,7,116,98,117,116,116,111,110,8,116,
  98,117,116,116,111,110,50,17,102,114,97,109,101,46,111,112,116,105,111,110,
  115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,0,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,102,114,108,95,111,
  112,116,105,111,110,115,115,107,105,110,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,15,102,97,99,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,8,98,111,117,110,100,115,95,120,2,6,
  8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,95,99,
  120,2,94,9,98,111,117,110,100,115,95,99,121,2,24,5,115,116,97,116,
  101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,
  97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,
  117,116,101,0,7,99,97,112,116,105,111,110,6,10,70,105,110,100,32,38,
  78,101,120,116,9,111,110,101,120,101,99,117,116,101,7,10,111,110,102,105,
  110,100,110,101,120,116,0,0,12,116,104,105,115,116,111,114,121,101,100,105,
  116,8,102,105,110,100,116,101,120,116,22,102,114,97,109,101,46,99,97,112,
  116,105,111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,
  116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,29,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,
  109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,19,102,114,97,109,101,46,98,117,116,116,
  111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,98,117,
  116,116,111,110,115,46,105,116,101,109,115,14,1,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,0,0,8,116,97,98,111,114,
  100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,6,8,98,111,117,
  110,100,115,95,121,2,32,9,98,111,117,110,100,115,95,99,120,3,218,0,
  9,98,111,117,110,100,115,95,99,121,2,22,7,97,110,99,104,111,114,115,
  11,7,97,110,95,108,101,102,116,6,97,110,95,116,111,112,8,97,110,95,
  114,105,103,104,116,0,8,115,116,97,116,102,105,108,101,7,17,109,97,105,
  110,102,111,46,116,115,116,97,116,102,105,108,101,49,12,111,112,116,105,111,
  110,115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,
  117,112,109,101,110,117,13,111,101,49,95,115,97,118,101,118,97,108,117,101,
  13,111,101,49,95,115,97,118,101,115,116,97,116,101,0,11,111,112,116,105,
  111,110,115,101,100,105,116,11,12,111,101,95,117,110,100,111,111,110,101,115,
  99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,
  104,101,99,107,109,114,99,97,110,99,101,108,20,111,101,95,114,101,115,101,
  116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,120,105,
  116,111,110,99,117,114,115,111,114,13,111,101,95,97,117,116,111,115,101,108,
  101,99,116,25,111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,
  105,114,115,116,99,108,105,99,107,0,8,111,110,99,104,97,110,103,101,7,
  12,111,110,99,104,97,110,103,101,102,105,110,100,19,100,114,111,112,100,111,
  119,110,46,99,111,108,115,46,99,111,117,110,116,2,1,19,100,114,111,112,
  100,111,119,110,46,99,111,108,115,46,105,116,101,109,115,14,1,0,0,13,
  114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,12,116,98,
  111,111,108,101,97,110,101,100,105,116,13,99,97,115,101,115,101,110,115,105,
  116,105,118,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,15,
  67,97,115,101,32,38,83,101,110,115,105,116,105,118,101,16,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,49,11,0,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,89,2,2,
  0,8,116,97,98,111,114,100,101,114,2,3,8,98,111,117,110,100,115,95,
  120,3,242,0,8,98,111,117,110,100,115,95,121,2,32,9,98,111,117,110,
  100,115,95,99,120,2,102,9,98,111,117,110,100,115,95,99,121,2,17,7,
  97,110,99,104,111,114,115,11,6,97,110,95,116,111,112,8,97,110,95,114,
  105,103,104,116,0,8,115,116,97,116,102,105,108,101,7,17,109,97,105,110,
  102,111,46,116,115,116,97,116,102,105,108,101,49,0,0,7,116,98,117,116,
  116,111,110,8,116,98,117,116,116,111,110,52,17,102,114,97,109,101,46,111,
  112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,95,102,108,97,116,
  0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,15,
  102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,15,102,97,99,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,8,116,97,98,111,114,
  100,101,114,2,4,4,104,105,110,116,6,16,82,101,115,101,116,32,105,110,
  100,101,120,32,116,111,32,48,8,98,111,117,110,100,115,95,120,3,206,0,
  8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,95,99,
  120,2,68,9,98,111,117,110,100,115,95,99,121,2,24,5,115,116,97,116,
  101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,
  97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,12,97,115,95,108,111,99,97,108,104,105,110,116,17,97,
  115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,
  112,116,105,111,110,6,6,38,82,101,115,101,116,9,111,110,101,120,101,99,
  117,116,101,7,7,111,110,114,101,115,101,116,0,0,7,116,98,117,116,116,
  111,110,8,116,98,117,116,116,111,110,53,3,84,97,103,2,1,17,102,114,
  97,109,101,46,111,112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,
  95,102,108,97,116,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,8,
  116,97,98,111,114,100,101,114,2,5,8,98,111,117,110,100,115,95,120,2,
  106,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,95,
  99,120,2,94,9,98,111,117,110,100,115,95,99,121,2,24,5,115,116,97,
  116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,
  99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,
  97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,
  99,117,116,101,0,7,99,97,112,116,105,111,110,6,9,70,105,110,100,32,
  65,38,108,108,9,111,110,101,120,101,99,117,116,101,7,9,111,110,102,105,
  110,100,97,108,108,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tfindmessagefo,'');
end.
