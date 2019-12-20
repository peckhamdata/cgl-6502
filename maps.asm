

// PETSCII memory layout (example for a 40x25 screen)
// byte  0         = border color
// byte  1         = background color
// bytes 2-1001    = screencodes
// bytes 1002-2001 = color
usa_map:
.byte 32,32,32,32,79,80,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,106,80,32
.byte 32,77,67,115,32,32,68,68,67,79,119,80,32,32,32,44,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,32,77
.byte 32,32,32,66,32,32,32,32,78,80,32,32,119,67,114,67,67,114,67,67,67,44,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,32,32,106
.byte 32,32,70,113,67,67,67,115,32,106,32,32,32,32,66,32,32,72,32,32,32,78,68,67,77,70,67,78,76,32,32,32,32,32,32,106,119,76,79,79
.byte 32,89,32,32,32,32,32,72,32,32,84,32,32,32,107,67,67,115,32,32,78,32,32,32,72,32,72,67,79,76,32,122,69,69,69,69,32,77,78,32
.byte 32,72,32,32,32,32,32,66,32,32,107,67,67,67,115,32,32,93,32,32,77,32,32,32,66,32,66,32,77,67,32,114,67,67,67,115,67,39,32,32
.byte 32,107,67,67,114,67,67,115,32,32,66,32,32,32,107,67,32,107,67,67,67,115,67,67,66,32,66,31,114,103,32,115,32,32,32,93,106,32,32,32
.byte 32,93,32,32,116,32,32,80,67,67,115,32,32,32,66,32,67,115,32,32,32,93,32,32,77,32,78,32,93,68,67,115,68,68,78,77,78,32,32,32
.byte 32,72,32,32,116,32,32,103,32,32,39,67,67,67,115,32,32,32,77,67,67,115,32,32,32,66,32,32,93,32,78,39,111,78,77,111,84,32,32,32
.byte 32,106,32,32,116,32,32,103,32,32,32,66,32,66,67,67,67,67,89,32,32,32,77,32,89,32,78,68,67,67,32,78,32,32,72,32,32,32,32,32
.byte 32,106,32,32,77,32,32,103,32,32,32,66,32,66,32,32,32,32,93,32,32,32,78,69,69,69,32,32,32,78,64,68,68,68,115,32,32,32,32,32
.byte 32,32,80,32,32,77,32,91,67,67,114,67,114,67,67,67,67,67,113,114,67,113,114,67,67,67,67,67,78,32,32,32,32,32,71,32,32,32,32,32
.byte 32,32,32,77,32,32,77,66,32,32,66,32,107,67,71,32,32,32,32,66,32,32,66,32,32,32,32,32,79,67,67,67,70,78,32,32,32,32,32,32
.byte 32,32,32,32,77,32,32,66,32,32,66,32,66,32,76,82,32,32,32,66,32,85,113,114,67,91,67,67,32,32,32,77,78,32,32,32,32,32,32,32
.byte 32,32,32,32,32,69,68,115,32,32,66,32,66,32,32,32,76,67,67,113,114,75,32,66,32,93,32,32,77,32,32,78,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,80,121,64,113,111,66,32,32,32,32,32,32,32,71,66,32,66,32,107,67,68,69,69,69,77,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,77,32,32,32,32,32,32,32,32,84,32,67,113,67,113,82,70,70,70,82,32,77,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,77,70,67,70,32,32,32,78,67,67,67,67,68,69,32,32,32,32,32,77,32,77,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,77,32,78,32,32,32,32,32,32,32,32,32,32,32,32,32,77,32,71,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,77,84,32,32,32,32,32,32,32,32,32,32,32,32,32,32,77,116,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
ussr_map:
.byte 32,32,32,82,32,32,32,32,32,32,32,32,32,32,32,32,111,111,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,111,79,111,116,32,32,32,32,32,32,32,32,79,69,69,32,32,80,32,32,32,32,32,32,32,79,68,116,114,32,32,32,32,32,32,32,32,32,32
.byte 78,32,32,32,77,32,32,32,32,32,32,32,79,32,32,32,32,32,78,32,32,32,32,32,32,32,119,119,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,122,32,32,32,32,32,79,76,116,32,32,32,32,32,119,119,32,32,67,119,119,77,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,78,69,32,32,32,32,32,89,32,32,32,32,32,32,32,32,32,32,119,119,32,32,32,32,119,80,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,79,32,111,67,68,68,119,119,77,77,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,119,119,76,32,32,32,122,80,32,32,32,32
.byte 69,76,122,32,32,32,32,32,32,103,78,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,119,119,119,32,32,69,68,67,114
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,77,116
.byte 32,80,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,122,68,116
.byte 32,32,77,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,32,32
.byte 115,119,119,76,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,77,79,32,32,32
.byte 32,77,32,32,116,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,111,78,78,79,67,68,32,32,32,32,32,32
.byte 32,122,80,32,77,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,82,82,100,78,32,78,32,84,32,32,32,32,32,32,32,32
.byte 79,32,32,77,32,80,32,32,78,119,119,80,32,32,32,32,32,32,32,32,32,32,32,78,32,32,32,32,103,32,78,32,32,32,32,32,32,32,32,32
.byte 76,32,32,32,69,80,32,79,32,32,32,32,77,32,111,111,78,32,32,32,32,32,78,32,32,32,32,32,32,22,32,32,32,32,32,32,32,32,32,32
.byte 32,80,32,32,32,78,32,77,32,32,32,32,32,69,32,32,119,119,68,76,32,32,80,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,122,119,69,80,32,32,32,79,80,32,32,78,76,32,32,32,32,122,32,80,32,32,80,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 119,32,32,32,32,76,32,78,32,103,32,78,32,32,76,32,32,78,32,32,32,76,32,72,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,67,113,32,80,32,32,32,119,32,32,78,32,69,79,32,32,32,32,32,76,78,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,103,32,32,32,32,32,32,32,32,78,32,32,32,78,116,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
two_tribes_map:
.byte 32,32,32,32,32,32,32,32,112,67,67,67,67,67,67,67,67,70,110,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,112,125,32,32,32,32,32,32,32,32,32,109,123,32,32,32,111,111,111,111,47,69,123,60,62,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,78,32,32,32,32,32,32,32,32,32,32,32,32,32,77,111,78,32,32,32,32,32,78,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,116,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,116,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,112,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,77,111,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,112,125,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,80,111,70,64,110,32,32,32,32,32,32,32,32,32,32,32,32,93,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,109,64,70,82,32,32,122,119,77,78,69,123,32,116,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,77,78,32,32,32,32,32,77,78,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,112,67,68,67,110,103,80,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,71,32,32,32,78,78,32,77,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,112,110,32,32,32,82,82,78,79,119,32,32,32,32,119,32,32,32,120,22,110,112,68,67,67,68,80,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,71,109,82,78,69,123,32,32,32,32,32,32,32,32,32,32,32,32,32,32,109,125,32,32,32,32,79,32,32,32,32
.byte 32,32,32,32,32,32,32,111,78,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,78,89,32,32,32,32,32
.byte 32,32,32,32,32,32,78,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,82,70,82,78,79,79,77,78,32,32,32,32,32
.byte 32,32,32,32,32,32,77,32,32,32,32,32,32,32,32,32,32,82,67,111,110,32,32,112,68,80,32,77,32,32,77,78,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,109,110,32,32,32,32,32,32,32,78,32,32,32,32,64,69,125,32,78,47,78,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,109,67,70,111,32,112,111,78,32,32,32,32,32,32,32,32,32,77,78,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,74,75,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
