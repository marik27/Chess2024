Class {
	#name : 'MyQueenTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyQueenTest >> testDisplaySolution [
    | board solution displayedQueens |

    "Initialisation du plateau"
    board := MyChessBoard empty.
    board initializeWithSize: 9.

    "Solution pré-calculée pour le problème des 9 reines"
    solution := #(5 8 1 4 7 2 9 6 3). "Exemple de solution valide"

    "Afficher la solution sur le plateau"
    board displaySolution: solution.

    "Vérifier que 9 reines sont présentes"
    displayedQueens := board pieces select: [:piece | piece isKindOf: MyQueen].

    self assert: (displayedQueens size = 9).

    "Vérifier que chaque reine est à sa place"
    1 to: solution size do: [:row |
        | col coordinate |
        col := solution at: row.
        coordinate := (Character value: ($a asciiValue + col - 1)) asString , row asString.

        self assert: ((board at: coordinate) contents isKindOf: MyQueen).
    ].

]

{ #category : 'tests' }
MyQueenTest >> testIsSafeAtRowColumnBoard [
    | testBoard board |
board :=MyChessBoard  empty.
    testBoard := Array new: 9.
    
    "Place une reine sur la première ligne, première colonne"
    testBoard at: 1 put: 1.
    
    "Vérifie que les autres lignes et colonnes sont sûres"
    self assert: (board isSafeAtRow: 2 column: 3 board: testBoard).
    self deny: (board isSafeAtRow: 2 column: 1 board: testBoard).
    self deny: (board isSafeAtRow: 2 column: 2 board: testBoard).

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
