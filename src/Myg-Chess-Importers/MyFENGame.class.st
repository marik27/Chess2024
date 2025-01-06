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
    "Initialise un plateau dynamique basé sur la taille de la collection fournie."
  | size columnRange |
    board := Dictionary new.

 
    size := aCollection first size. "Taille dynamique basée sur la première ligne"
    columnRange := ($a asciiValue) to: ($a asciiValue + size - 1).

    aCollection reversed withIndexDo: [:rankPieces :rank |
        (rankPieces size = size) ifFalse: [
            self error: 'Toutes les rangées doivent avoir le même nombre de colonnes.'
        ].

        rankPieces withIndexDo: [:piece :index |
            | column position |
            column := (columnRange at: index) asCharacter asString.
            position := column , rank asString.
            board at: position put: piece.
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
