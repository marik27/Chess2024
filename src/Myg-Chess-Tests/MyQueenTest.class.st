Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testIsCheckByOpponentsRook [

	| queen board |
	board := MyChessBoard empty.
	board at: 'e4' put: (queen := MyKing white).

	"Put an atacker rook on e column"
	board at: 'e1' put: MyRook black.

	self assert: queen isInCheck
]

{ #category : 'tests' }
MyQueenTest >> testQueenMovementWithoutObstacles [

    | queen squares board |
    board := MyChessBoard empty.
    board at: 'd4' put: (queen := MyQueen white).

    "Vérifie les mouvements de la reine sans obstacles"
    squares := queen targetSquares.

    "Impression des cases accessibles pour débogage"
    Transcript show: squares; cr.

    "Vérifie que la reine peut se déplacer librement dans toutes les directions"
    self
        assertCollection: squares
        includesAll: 
            (#( d1 d2 d3 d5 d6 d7 d8 a4 b4 c4 e4 f4 g4 h4 a1 b2 c3 e5 f6 g7 h8 a7 b6 c5 e3 f2 g1 ) collect: [ :name |
                    board at: name ]).

]

{ #category : 'tests' }
MyQueenTest >> testQueenValidMoves [ [
        | board queen |
        board := MyChessBoard new.
       queen := MyQueen new.
		
        
        "Test horizontal movement"
        self assert: (queen moveTo: 'd8') notNil.
        self assert: (queen moveTo: 'd1') notNil.
        
        "Test vertical movement"
        self assert: (queen moveTo: 'a4') notNil.
        self assert: (queen moveTo: 'h4') notNil.
        
        "Test diagonal movement"
        self assert: (queen moveTo: 'g7') notNil.
        self assert: (queen moveTo: 'a1') notNil.
    ].

]
