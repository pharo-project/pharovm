tests
testMoveRMbr
	"self new testMoveRMbr"
	CogIA32CompilerForTests byteRegistersWithNamesDo:
		[:sreg :srname|
		CogIA32CompilerForTests registersWithNamesDo:
			[:dreg :drname|
			((1 to: 19 by: 3) collect: [:po2| 2 raisedToInteger: po2]) do:
				[:offset| | inst len |
				inst := self gen: MoveRMbr operand: sreg operand: offset operand: dreg.
				len := inst concretizeAt: 0.
				self processor
					disassembleInstructionAt: 0
					In: inst machineCode object
					into: [:str :sz| | plainJane herIntended |
						plainJane := self strip: str.
						herIntended := 'movb ', srname, ', 0x', (offset hex allButFirst: 3), '(', drname, ')'.
						self assert: herIntended equals: plainJane.
						self assert: len = sz]]]]