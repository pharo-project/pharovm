inline primitive register allocation
allocateRegistersForLowcodeInteger3ResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rNext rNextNext rResult nativeValueIndex rTop nextRegisterMask |
	rTop := rNext := rNextNext := NoReg.
	nativeValueIndex := 1.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
		self ssNativeTop nativeRegisterSecondOrNone ~= NoReg ifTrue:
			[ rNext := self ssNativeTop nativeRegisterSecondOrNone]
	].

	rNext = NoReg ifTrue: [
		(self ssNativeValue: nativeValueIndex)  nativeRegisterOrNone ~= NoReg ifTrue:  [
			rNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
			(self ssNativeValue: nativeValueIndex) nativeRegisterSecondOrNone ~= NoReg ifTrue: [
				rNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterSecondOrNone.
			].
			nativeValueIndex := nativeValueIndex + 1
		].
	].

	rNextNext = NoReg ifTrue: [
		(self ssNativeValue: nativeValueIndex)  nativeRegisterOrNone ~= NoReg ifTrue:  [
			rNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
		].
	].

	rTop = NoReg ifTrue: [
		nextRegisterMask := 0.
		rNext ~= NoReg ifTrue: [ nextRegisterMask := self registerMaskFor: rNext].
		rNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNext)].
		rTop := self allocateRegNotConflictingWith: nextRegisterMask
	].
	
	rNext = NoReg ifTrue: [
		nextRegisterMask := self registerMaskFor: rTop.
		rNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNext)].
		rNext := self allocateRegNotConflictingWith: nextRegisterMask
	].

	rNextNext = NoReg ifTrue: [
		nextRegisterMask := self registerMaskFor: rTop and: rNext.
		rNextNext := self allocateRegNotConflictingWith: nextRegisterMask
	].

	self deny: (rTop = NoReg or: [rNext = NoReg or: [rNextNext = NoReg]]).
	
	"Allocate the result"
	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rNext and: rNextNext).
	self deny: (rResult = NoReg).
	
	^ aBlock value: rTop value: rNext value: rNextNext value: rResult
