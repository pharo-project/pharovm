simulation stack
ssAllocateCallReg: requiredReg1 and: requiredReg2 and: requiredReg3 and: requiredReg4
	"Allocate registers needed in a run-time call (i.e. flush uses of the
	 registers to the real stack).  Since the run-time can smash any and
	 all caller-saved registers also flush all caller-saved registers."
	self ssAllocateRequiredRegMask: (CallerSavedRegisterMask
										bitOr: ((self registerMaskFor: requiredReg1)
										bitOr: ((self registerMaskFor: requiredReg2)
										bitOr: ((self registerMaskFor: requiredReg3)
										bitOr: (self registerMaskFor: requiredReg4)))))
		upThrough: simStackPtr