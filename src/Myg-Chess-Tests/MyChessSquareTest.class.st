Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testDisplaySolution [
	|solution board |
    board := MyChessBoard empty.
    board initializeWithSize: 9.

    solution := #(1 3 5 7 9 2 4 6 8).
    board displaySolution: solution.

    "Vérifie que les bonnes cases contiennent des reines"
    1 to: 9 do: [:row |
        | col coordinate square |
        col := solution at: row.
        coordinate := (Character value: ($a asciiValue + col - 1)) asString , row asString.
        square := board grid at: coordinate.
        self assert: (square contents isKindOf: MyQueen).
    ].
]

{ #category : 'tests' }
MyChessSquareTest >> testDown [
| board square testSquare |
board := MyChessGame freshGame board. 
	square := board at: 'e2'.
	
testSquare := square down.
self assert: testSquare name equals:'e1'.
]

{ #category : 'tests' }
MyChessSquareTest >> testPlaceQueen [
    | board queen |
    board := MyChessBoard empty.
    board initializeWithSize: 9.

    queen := MyQueen white.
    board at: 'e4' put: queen.

    self assert: ((board grid at: 'e4') contents) == queen.
]
