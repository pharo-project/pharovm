inline primitive generators generated code
genLowcodePointerToOop
	<option: #LowcodeVM>
	<inline: true>
	"Generated by the Lowcode instruction generator."
	| pointer pointerClassLiteral |
	pointerClassLiteral := self getLiteral: extA.
	self allocateRegistersForLowcodeInteger: [:pointerValue |
		pointer := pointerValue.
	].

	self ssNativeTop nativePopToReg: pointer.
	self ssNativePop: 1.

	self ssFlushAll.
	objectRepresentation genLcPointerToOop: pointer class: pointerClassLiteral.

	extA := 0.
	^ 0

