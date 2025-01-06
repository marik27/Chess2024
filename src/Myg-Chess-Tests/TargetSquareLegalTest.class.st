Class {
	#name : 'TargetSquareLegalTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
TargetSquareLegalTest >> testTargetSquaresExcludesNil [

	| king squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	squares := king targetSquares.

	"Vérifie que nil n'est pas inclus dans les cases accessibles"
	self assert: (squares includes: nil) equals: false.

]

{ #category : 'tests' }
TargetSquareLegalTest >> testTargetSquaresExcludesNullSquare [

	| king squares board |
	board := MyChessBoard empty.
	board at: 'e4' put: (king := MyKing white).

	squares := king targetSquares.

	"Vérifie que NullSquare n'apparaît pas parmi les cases légales"
	self assert: (squares includes: NullSquare new) equals: false.

]
