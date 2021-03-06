object access
fetchFloat: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the C double precision floating point value of that instance variable, or fail if it is not a Float."
	"Note: May be called by translated primitive code."

	| floatOop |
	<returnTypeC: 'double'>
	floatOop := self fetchPointer: fieldIndex ofObject: objectPointer.
	^ self floatValueOf: floatOop