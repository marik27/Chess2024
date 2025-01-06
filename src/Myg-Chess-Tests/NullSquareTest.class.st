Class {
	#name : 'NullSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
NullSquareTest >> testSquareUpOutOfLimits [

	| board square result |
	board := MyChessBoard empty.
	square := board at: 'd8'. "Position en bordure"
	result := square up.

	"Vérifie que la case au-dessus des limites retourne NullSquare"
	self assert: result class equals: NullSquare
]
