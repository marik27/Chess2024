Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testAdjacentEnPassantPawnsInStandardState [ 
    | board pawn Square adjacentPawn1 adjacentPawn2  leftSquare rightSquare enPassantPawns |

     board := MyChessBoard empty.
	 Square:= board at: #e5.
    leftSquare := board  at: #d5. 
    rightSquare := board at: #f5. 

    pawn := MyPawn white.
    pawn state: MyStandardMoveState new.
	 pawn setPosition: Square.
	
    adjacentPawn1 := MyPawn black.
    adjacentPawn1 state: MyEnPassantState new.
    adjacentPawn1  setPosition: leftSquare.
    leftSquare contents: adjacentPawn1.

    adjacentPawn2 := MyPawn black.
    adjacentPawn2 state: MyStandardMoveState new.
    adjacentPawn2 setPosition: rightSquare.
    rightSquare contents: adjacentPawn2.

    enPassantPawns := pawn adjacentEnPassantPawns.
   " Transcript show: 'Pions en état En Passant détectés: ', enPassantPawns printString; cr."
    self assert: (enPassantPawns includes: adjacentPawn1).
    self deny: (enPassantPawns includes: adjacentPawn2).
    self assert: enPassantPawns size equals: 1.


]

{ #category : 'tests' }
MyPawnTest >> testAdjacentSquareTo [ 
"Test si le pion peut correctement identifier ses cases adjacentes "

    | pawn board  square leftSquare rightSquare adjacentSquares |
    board := MyChessBoard empty.
	 square:= board at: 'e4' put: (pawn := MyPawn white).
    leftSquare := board  at: #d4. 
    rightSquare := board at: #f4. 

    adjacentSquares := pawn  adjacentSquareTo.

    self assert: (adjacentSquares includes: leftSquare).
    self assert: (adjacentSquares includes: rightSquare).
    self assert: adjacentSquares size equals: 2.
]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnFirstMove [

	| pawn squares board1 firstSquare |
	board1 := MyChessBoard empty.
	board1 at: 'f7' put: (pawn := MyPawn black).
	squares := pawn targetSquaresLegal: true.
	
	firstSquare := squares anyOne. 
	self assert: firstSquare equals: (board1 at: 'f6').

]

{ #category : 'tests' }
MyPawnTest >> testBlackPawnMovesDoubleStep [

	| pawn board expectedSquares squares |
	board := MyChessBoard empty.
	board at: 'e7' put: (pawn := MyPawn black).
	squares := pawn targetSquaresLegal: true.
	expectedSquares := OrderedCollection new.
	expectedSquares add: (board at: 'e6').
	expectedSquares add: (board at: 'e5').
	self assert: squares asSet equals: expectedSquares asSet
	
]

{ #category : 'tests' }
MyPawnTest >> testDiagonalPawnCapturesTarget [
 

	| pawn board enemyPawn1 enemyPawn2 capturePawn expectedSquares |

	board := MyChessBoard empty.
	board at: 'd4' put: (pawn := MyPawn white).
	board at: 'c5' put: (enemyPawn1 := MyPawn black).
	board at: 'e5' put: (enemyPawn2 := MyPawn black).

	capturePawn := pawn diagonalPawnCaptures.
	expectedSquares := OrderedCollection new.
	expectedSquares add: (board at: 'c5'). 
	expectedSquares add: (board at: 'e5'). 

	self assert: capturePawn asSet equals: expectedSquares asSet
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantToStandardState [ 
" Test si apres avoir effectuer un douple pas pour atteindre état En Passant et ensuite un pas atteindre l' état standard  "

    | pawn board initialSquare standardSquare targetSquare |
    

    board := MyChessBoard empty.
    initialSquare := board  at: #e2.  
    standardSquare := board  at: #e5.  
    targetSquare := board at: #e4.  

 
    pawn := MyPawn white.
    pawn setPosition: initialSquare.
	"etat en passant"
    pawn moveTo: targetSquare.
    self assert: (pawn state isKindOf: MyEnPassantState).
	"etat standard"
    pawn moveTo: standardSquare.
    self assert: (pawn state isKindOf: MyStandardMoveState).


]

{ #category : 'tests' }
MyPawnTest >> testInitialWhitePawnMoves [

	| pawn squares board1 expectedSquares |
	board1 := MyChessBoard empty.
	board1 at: 'e2' put: (pawn := MyPawn white).
	squares := pawn targetSquaresLegal: true.

	expectedSquares := OrderedCollection new.
	expectedSquares add: (board1 at: 'e3').
	self assert: (expectedSquares allSatisfy: [ :each | squares includes: each ]).

]

{ #category : 'tests' }
MyPawnTest >> testWhitePawnMovesDoubleStep [ 

	| pawn board expectedSquares squares |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	squares := pawn targetSquaresLegal: true.
	expectedSquares := OrderedCollection new.
	expectedSquares add: (board at: 'e3').
	expectedSquares add: (board at: 'e4').
	self assert: squares asSet equals: expectedSquares asSet
]
