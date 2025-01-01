Class {
	#name : 'MyKing',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyKing >> attackingSquares [

	^ self basicTargetSquares
]

{ #category : 'rendering' }
MyKing >> basicTargetSquares [
    "The king can move one square in each direction, including diagonals"
    ^ {
        (square ifNotNil: [ square right ]).
        (square ifNotNil: [ square up ifNotNil: [ :sq | sq right ] ]).
        (square ifNotNil: [ square up ]).
        (square ifNotNil: [ square up ifNotNil: [ :sq | sq left ] ]).
        (square ifNotNil: [ square left ]).
        (square ifNotNil: [ square left ifNotNil: [ :sq | sq down ] ]).
        (square ifNotNil: [ square down ]).
        (square ifNotNil: [ square down ifNotNil: [ :sq | sq right ] ])
    } select: [:s | s notNil].

]

{ #category : 'accessing' }
MyKing >> id [
	
	^ 'K'
]

{ #category : 'testing' }
MyKing >> isCheckMated [
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ self legalTargetSquares isEmpty and: [
		  threatenedSquares includes: self square ]
]

{ #category : 'testing' }
MyKing >> isInCheck [
	"We check if the opponent pieces target all my potential movements and myself"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].

	^ threatenedSquares includes: self square
]

{ #category : 'testing' }
MyKing >> isKing [
	
	^ true
]

{ #category : 'accessing' }
MyKing >> opponentPieces [

	^ self board pieces select: [ :e |
		  e notNil and: [ e color = color negated ] ]
]

{ #category : 'rendering' }
MyKing >> renderPieceOn: aSquare [

	^ aSquare renderKing: self
]

{ #category : 'rendering' }
MyKing >> targetSquaresLegal: aBoolean [
	"The king cannot move to threatened squares"

	| threatenedSquares |
	threatenedSquares := self opponentPieces flatCollect: [ :e |
		                     e attackingSquares ].
	^ self basicTargetSquares select: [ :s |
		  s notNil and: [
			  (threatenedSquares includes: s) not and: [
				  s hasPiece not or: [ 
					"The square has an opponent piece"
					s contents color ~= color and: [ 
						"Let's hope the piece is not defended"
						threatenedSquares includes: s  ] ] ] ] ]
]
