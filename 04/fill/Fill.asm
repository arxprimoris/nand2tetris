// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

// Put your code here.
(INIT)
	@24575				// End of video RAM
	D=A		
	@END_VRAM
	M=D
	@SCREEN				// Start of video RAM
	D=A		
	@current_vword	
	M=D					// Init current_vword to start of video ram

(MAIN)
	@KBD
	D=M
	@WHITE
	D;JEQ				// Check for keypress...
	@current_vword
	A=M
	M=-1				// ...if keypress color black...
	@ITERATE
	0;JMP
(WHITE)
	@current_vword
	A=M
	M=0					// ...if no keypress color white
(ITERATE)
	@current_vword
	M=M+1				// Iterate current_vword
	D=M
	@END_VRAM
	D=M-D
	@CONTINUE
	D;JGE				// Check if we have iterated to end of VRAM...
	@SCREEN	
	D=A
	@current_vword
	M=D					// ...and if so reset current_vword to start of VRAM
(CONTINUE)
	@MAIN
	0;JMP
