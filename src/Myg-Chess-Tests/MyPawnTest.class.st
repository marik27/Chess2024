Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testBlackPawnFirstMove [

	| pawn squares board1 expectedSquares |
	board1 := MyChessBoard empty.
	board1 at: 'f7' put: (pawn := MyPawn black).
	squares := pawn targetSquaresLegal: true.

	expectedSquares := OrderedCollection new.
	expectedSquares add: (board1 at: 'f6').
	self assert: squares asSet equals: expectedSquares asSet
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
MyPawnTest >> testDiagonalPawnCaptures [

	| pawn board enemyPawn1 enemyPawn2 capturePawn expectedSquares |
	"Créer un échiquier vide"
	board := MyChessBoard empty.

	"Placer un pion blanc sur la case 'd4'"
	board at: 'd4' put: (pawn := MyPawn white).

	"Placer des pions ennemis sur les cases de capture diagonale"
	board at: 'c5' put: (enemyPawn1 := MyPawn black).
	board at: 'e5' put: (enemyPawn2 := MyPawn black).

	"Calculer les mouvements de capture légaux"
	capturePawn := pawn diagonalPawnCaptures.

	"Créer la collection des cases attendues"
	expectedSquares := OrderedCollection new.
	expectedSquares add: (board at: 'c5'). "Capture à gauche"
	expectedSquares add: (board at: 'e5'). "Capture à droite"

	"Vérifier que le pion peut capturer les pions ennemis diagonaux"
	self assert: capturePawn asSet equals: expectedSquares asSet
]

{ #category : 'tests' }
MyPawnTest >> testInitialWhitePawnMoves [

	| pawn squares board1 expectedSquares |
	board1 := MyChessBoard empty.
	board1 at: 'e2' put: (pawn := MyPawn white).
	squares := pawn targetSquaresLegal: true.

	expectedSquares := OrderedCollection new.
	expectedSquares add: (board1 at: 'e3').
	self assert: squares asSet equals: expectedSquares asSet
]

{ #category : 'as yet unclassified' }
MyPawnTest >> testIsFirstMove [ 

	|pawnWhite pawnBlack board|
     
		  board := MyChessBoard empty.
	     board at: 'e2' put: (pawnWhite:= MyPawn white).
 		  board at: 'e7' put: (pawnBlack := MyPawn black).
        
			"Verifie si le pion est sur la case de départ"
        self assert: (pawnWhite isFirstMove).
        self assert: (pawnBlack isFirstMove).

        "Modification des positions des pions"
		  " board at: 'e3' put: (pawnWhite:= MyPawn white).
 		  board at: 'e6' put: (pawnBlack := MyPawn black).

        self deny: (pawnWhite isFirstMove).
        self deny: (pawnBlack isFirstMove). "

]

{ #category : 'tests' }
MyPawnTest >> testSingleMove [


	| pawn squares board1 expectedSquares |
	board1 := MyChessBoard empty.
	board1 at: 'f4' put: (pawn := MyPawn black).
	squares := pawn targetSquaresLegal: true.

	expectedSquares := OrderedCollection new.
	expectedSquares add: (board1 at: 'f3').
	self assert: squares asSet equals: expectedSquares asSet
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
