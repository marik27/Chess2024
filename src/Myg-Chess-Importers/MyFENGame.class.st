Class {
	#name : 'MyFENGame',
	#superclass : 'Object',
	#instVars : [
		'board',
		'sideToMove',
		'players',
		'enPassantTargetSquare',
		'halfMoveClock',
		'moveCount',
		'white',
		'black'
	],
	#category : 'Myg-Chess-Importers',
	#package : 'Myg-Chess-Importers'
}

{ #category : 'accessing' }
MyFENGame >> board [
	^ board
]

{ #category : 'accessing' }
MyFENGame >> castlingAbility: aCollection [

	aCollection do: [ :castling |
		castling = 'K' ifTrue: [ white canCastleKingside ].
		castling = 'Q' ifTrue: [ white canCastleQueenside ].
		castling = 'k' ifTrue: [ black canCastleKingside ].
		castling = 'q' ifTrue: [ black canCastleQueenside ] ]
]

{ #category : 'accessing' }
MyFENGame >> enPassantTargetSquare: aString [ 
	enPassantTargetSquare := aString
]

{ #category : 'accessing' }
MyFENGame >> halfMoveClock: anInteger [ 
	halfMoveClock := anInteger
]

{ #category : 'accessing' }
MyFENGame >> moveCount [
	^ moveCount
]

{ #category : 'accessing' }
MyFENGame >> moveCount: anInteger [ 
	moveCount := anInteger
]

{ #category : 'accessing' }
MyFENGame >> ranks: aCollection [

	board := Dictionary new.
	aCollection reversed with: (1 to: aCollection size) do: [:rankPieces :rank |
    "Vérification que la taille des pièces correspond au nombre de colonnes attendues"
    (rankPieces size = ($a asciiValue to: ($a asciiValue + rankPieces size - 1)) size) ifFalse: [
        self error: 'Taille des pièces et colonnes ne correspondent pas à la ligne ', rank asString.
    ].
    
    "Boucle sur chaque pièce et colonne"
    rankPieces withIndexDo: [:piece :index |
        | column |
        column := (($a asciiValue + index - 1) asCharacter) asString.
        board at: column , rank asString put: piece.
    ].
].

]

{ #category : 'accessing' }
MyFENGame >> sideToMove [
	^ sideToMove
]

{ #category : 'accessing' }
MyFENGame >> sideToMove: aString [ 
	sideToMove := aString
]
