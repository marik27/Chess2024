Class {
	#name : 'MyKnightTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyKnightTest >> testId [

	self assert: MyKnight new id equals: 'N'

]

{ #category : 'tests' }
MyKnightTest >> testMoves [

	| knight squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (knight := MyKnight white).

	squares := knight targetSquares.
	self
		assertCollection: squares
		includesAll:
			(#( b7 b5 c4 e4 f5 f7 e8 c8 ) collect: [ :name |
				 board at: name ])
]

{ #category : 'tests' }
MyKnightTest >> testMovesWithOponentObstacle [

	| knight squares board |
	board := MyChessBoard empty.
	board at: 'd6' put: (knight := MyKnight white).

	"Knight jump above pieces"
	"and can  eat pieces of the other color"
	"Let's put a black obstacle on f6, to see if the Knight can catch the piece 	and  the square  can still be available "
	board at: 'c4' put: MyBishop black.

	squares := knight  targetSquares.
	
self
		assertCollection: squares
		includesAll:
			(#(  b7 b5 c4 e4 f5 f7 e8 c8 ) collect: [ :name |
				 board at: name ])
]
