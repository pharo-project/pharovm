inline primitive generators generated code
genLowcodeUint64ToFloat64
	<option: #LowcodeVM>
	<inline: true>
	"Generated by the Lowcode instruction generator."
	| valueHigh value valueLow result |
	self allocateRegistersForLowcodeIntegerResultFloat: [:valueValue :resultValue |
		value := valueValue.
		result := resultValue.
	].

	self ssNativeTop nativePopToReg: value.
	self ssNativePop: 1.

	self abort.

	^ 0

