generate machine code
concretizeMoveRsM32r
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg offset destReg |
	srcReg := operands at: 0.
	offset := operands at: 1.
	destReg := operands at: 2.
	destReg ~= ESP ifTrue:
		[(self isQuick: offset) ifTrue:
			"MOVSD destReg, srcReg"
			[machineCode
				at: 0 put: 16rF3;
				at: 1 put: 16r0F;
				at: 2 put: 16r11;
				at: 3 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
				at: 4 put: (offset bitAnd: 16rFF).
			 ^machineCodeSize := 5].
		"MOVSD destReg, srcReg"
		machineCode
			at: 0 put: 16rF3;
			at: 1 put: 16r0F;
			at: 2 put: 16r11;
			at: 3 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
			at: 4 put: (offset bitAnd: 16rFF);
			at: 5 put: (offset >> 8 bitAnd: 16rFF);
			at: 6 put: (offset >> 16 bitAnd: 16rFF);
			at: 7 put: (offset >> 24 bitAnd: 16rFF).
		^machineCodeSize := 8].
	"ESP:"
	(self isQuick: offset) ifTrue:
		[machineCode
			at: 0 put: 16rF3;
			at: 1 put: 16r0F;
			at: 2 put: 16r11;
			at: 3 put: (self mod: ModRegRegDisp8 RM: destReg RO: srcReg);
			at: 4 put: (self s: SIB1 i: 4 b: destReg);
			at: 5 put: (offset bitAnd: 16rFF).
		 ^machineCodeSize := 6].
	machineCode
		at: 0 put: 16rF3;
		at: 1 put: 16r0F;
		at: 2 put: 16r11;
		at: 3 put: (self mod: ModRegRegDisp32 RM: destReg RO: srcReg);
		at: 4 put: (self s: SIB1 i: 4 b: destReg);
		at: 5 put: (offset bitAnd: 16rFF);
		at: 6 put: (offset >> 8 bitAnd: 16rFF);
		at: 7 put: (offset >> 16 bitAnd: 16rFF);
		at: 8 put: (offset >> 24 bitAnd: 16rFF).
	^machineCodeSize := 9