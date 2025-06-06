"
Keyboard Distance Algorithm

The Keyboard Distance is a string metric that calculates the physical distance between characters on a standard QWERTY keyboard. It uses Euclidean distance between key positions and adds a penalty for length differences.

This metric is particularly useful for:
1. Detecting likely typos based on keyboard proximity
2. Suggesting spelling corrections
3. Analyzing typing patterns and common errors

The algorithm models the staggered rows of a physical keyboard with appropriate offsets.

Examples:
keyboardDistance := AIKeyboardDistance new.
keyboardDistance distanceBetween: 'cat' and: 'cat'.  """"Returns: 0.0 (identical strings)""""
keyboardDistance distanceBetween: 'cat' and: 'vat'.  """"Returns: 1.0 (c and v are adjacent)""""
keyboardDistance distanceBetween: 'hello' and: 'kello'.  """"Returns: 2.0 (h and k are two keys apart)""""
keyboardDistance distanceBetween: 'hello' and: 'hell'.  """"Returns: 1.0 (length difference penalty)""""

"
Class {
	#name : 'AIKeyboardDistance',
	#superclass : 'AIAbstractEditDistance',
	#instVars : [
		'keyboardLayout'
	],
	#category : 'AI-EditDistances-Distances',
	#package : 'AI-EditDistances',
	#tag : 'Distances'
}

{ #category : 'initialization' }
AIKeyboardDistance >> addKeysToLayout: keys atRow: row offset: offset [

	keys doWithIndex: [ :char :index |
		keyboardLayout at: char put: {
				row.
				(index - 1 + offset) } ]
]

{ #category : 'api' }
AIKeyboardDistance >> distanceBetween: firstString and: secondString [

	"Compute the keyboard distance between two strings.
	Returns the sum of Euclidean distances between corresponding characters."
	
	| totalDistance minLength |
	(firstString isEmpty and: [secondString isEmpty]) ifTrue: [ ^ 0.0 ].
	firstString isEmpty ifTrue: [ ^ secondString size asFloat ].
	secondString isEmpty ifTrue: [ ^ firstString size asFloat ].
	
	minLength := firstString size min: secondString size.
	totalDistance := 0.0.
	
	1 to: minLength do: [ :i |
		totalDistance := totalDistance + (self keyDistance: (firstString at: i) and: (secondString at: i)).
	].
	
	totalDistance := totalDistance + ((firstString size - secondString size) abs).
	
	^ totalDistance
]

{ #category : 'initialization' }
AIKeyboardDistance >> initialize [

	super initialize.
	keyboardLayout := Dictionary new.
	self initializeKeyboardLayout
]

{ #category : 'initialization' }
AIKeyboardDistance >> initializeKeyboardLayout [

	self addKeysToLayout: '`1234567890-=' atRow: 0 offset: 0.0.
	self addKeysToLayout: '~!@#$%^&*()_+' atRow: 0 offset: 0.0.
	
	self addKeysToLayout: 'qwertyuiop[]\\' atRow: 1 offset: 0.5.
	self addKeysToLayout: 'QWERTYUIOP{}|' atRow: 1 offset: 0.5.
	
	self addKeysToLayout: 'asdfghjkl;''' atRow: 2 offset: 0.75.
	self addKeysToLayout: 'ASDFGHJKL:"' atRow: 2 offset: 0.75.
	
	self addKeysToLayout: 'zxcvbnm,./' atRow: 3 offset: 1.25.
	self addKeysToLayout: 'ZXCVBNM<>?' atRow: 3 offset: 1.25.
	
	keyboardLayout at: Character space put: {4. 5}.
]

{ #category : 'api' }
AIKeyboardDistance >> keyDistance: firstChar and: secondChar [

	| pos1 pos2 |
	firstChar = secondChar ifTrue: [ ^ 0.0 ].
	
	pos1 := keyboardLayout at: firstChar ifAbsent: [ ^ 5.0 ].
	pos2 := keyboardLayout at: secondChar ifAbsent: [ ^ 5.0 ].
	
	^ ((pos1 first - pos2 first) squared + (pos1 second - pos2 second) squared) sqrt
]
