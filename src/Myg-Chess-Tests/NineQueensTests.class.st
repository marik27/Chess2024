Class {
	#name : 'NineQueensTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
NineQueensTests >> testIsSafePosition [ [
        | isSafe board |
        
        "Place une reine sur le plateau"
        board at: 'd4' put: (MyQueen new color: Color white).
        
        "Vérifie que d4 est occupé et que les positions menacées ne sont pas sûres"
        isSafe := board isSafePosition: 'd4'.
        self deny: isSafe.

        isSafe := board isSafePosition: 'e5'.
        self deny: isSafe. "e5 est menacé diagonalement par d4"
        
        isSafe := board isSafePosition: 'f4'.
        self deny: isSafe. "f4 est menacé en ligne par d4"
        
        isSafe := board isSafePosition: 'c3'.
        self deny: isSafe. "c3 est menacé diagonalement par d4"
        
        "Vérifie une position sûre"
        isSafe := board isSafePosition: 'g7'.
        self assert: isSafe. "g7 n'est pas menacé"
    ]

]

{ #category : 'tests' }
NineQueensTests >> testPlaceQueensOnRow [ [
        "Test de placement de reines dans des rangées séparées"
|  board |
        board := MyChessBoard new.
        board placeQueensOnRow: 1.

        "Vérifie que chaque rangée contient une reine unique"
        1 to: 9 do: [ :row |
            | queensInRow |
            queensInRow := board pieces select: [ :piece | piece isQueen and: [ piece square name second asInteger = row ] ].
            self assert: queensInRow size = 1. "Une seule reine par rangée"
        ].

        "Vérifie qu'il n'y a qu'une reine par colonne"
        1 to: 9 do: [ :column |
            | queensInColumn |
            queensInColumn := board pieces select: [ :piece | piece isQueen and: [ (piece square name first asciiValue - $a asciiValue + 1) = column ] ].
            self assert: queensInColumn size = 1. "Une seule reine par colonne"
        ].
    ]

]
