simulation only
showDisplayBits: aForm Left: l Top: t Right: r Bottom: b
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter showDisplayBits: aForm Left: l Top: t Right: r Bottom: b