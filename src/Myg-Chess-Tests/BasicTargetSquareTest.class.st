Class {
	#name : 'BasicTargetSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
BasicTargetSquareTest >> testBasicTargetSquaresAfterModification [
	| king squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (king := MyKing white).
	
	squares := king basicTargetSquares.
	
	"Après la modification, il ne doit plus y avoir de nil"
	self assert: (squares includes: nil) equals: false.

]

{ #category : 'tests' }
BasicTargetSquareTest >> testBasicTargetSquaresBeforeModification [

	| king squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (king := MyKing white).

	squares := king basicTargetSquares.

	"Avant la modification, il est possible qu'une case cible soit nil"
	"ce test nesera pas vert après modification de basicTargetSquares"
	self assert: (squares includes: nil) equals: true
]
