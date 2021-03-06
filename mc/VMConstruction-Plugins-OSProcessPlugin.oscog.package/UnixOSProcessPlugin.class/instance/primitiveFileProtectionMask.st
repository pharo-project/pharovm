primitives - files
primitiveFileProtectionMask
	"Call stat(2) to obtain the file protection mask for a file. Answer an Array of
	four integers representing the protection mask, or answer errno on failure. The
	protection mask is four Integers, each of which may be considered an octal digit
	(0-7), with bit values 4, 2, and 1. The first digit selects the set user ID (4) and set
	group ID (2) and save text image (1) attributes. The second digit selects permissions
	for the user who owns the file: read (4), write (2), and execute (1); the third
	selects permissions for other users in the file's group, with the same values; and
	the fourth for other users not in the file's group, with the same values."

	| path statBuf buffer mode errno result |
	<export: true>
	<var: 'path' declareC: 'char *path'>
	<var: 'statBuf' declareC: 'struct stat *statBuf'>
	<var: 'errno' declareC: 'extern int errno'>

	buffer := interpreterProxy
				instantiateClass: interpreterProxy classByteArray
				indexableSize: (self cCode: 'sizeof(struct stat)' inSmalltalk: [1000]).
	statBuf := interpreterProxy arrayValueOf: buffer.
	path := self transientCStringFromString: (interpreterProxy stackObjectValue: 0).
	mode := (self cCode: 'stat(path, statBuf)' inSmalltalk: [0]).
	(mode == 0) ifTrue:
			[mode := self cCode: 'statBuf->st_mode' inSmalltalk: [0].
			result := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 4.
			interpreterProxy
				stObject: result
				at: 4
				put: (interpreterProxy integerObjectOf: (self cCode: 'mode & 07' inSmalltalk: [0])).
			interpreterProxy
				stObject: result
				at: 3
				put: (interpreterProxy integerObjectOf: (self cCode: '(mode & 070) >> 3' inSmalltalk: [0])).
			interpreterProxy
				stObject: result
				at: 2
				put: (interpreterProxy integerObjectOf: (self cCode: '(mode & 0700) >> 6' inSmalltalk: [0])).
			interpreterProxy
				stObject: result
				at: 1
				put: (interpreterProxy integerObjectOf: (self cCode: '(mode & 07000) >> 9' inSmalltalk: [0])).
			interpreterProxy pop: 2; push: result]
		ifFalse:
			[interpreterProxy pop: 2; pushInteger: errno].

