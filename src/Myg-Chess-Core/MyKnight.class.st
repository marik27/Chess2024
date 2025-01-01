Class {
	#name : 'MyKnight',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyKnight >> id [
	
	^ 'N'
]

{ #category : 'rendering' }
MyKnight >> renderPieceOn: aSquare [

	^ aSquare renderKnight: self
]

{ #category : 'rendering' }
MyKnight >> targetSquaresLegal: aBoolean [
    ^ {
        (square ifNotNil: [ square right ifNotNil: [ :p | p right ifNotNil: [ p up ] ] ]).
        (square ifNotNil: [ square right ifNotNil: [ :p | p right ifNotNil: [ p down ] ] ]).
        (square ifNotNil: [ square left ifNotNil: [ :p | p left ifNotNil: [ p up ] ] ]).
        (square ifNotNil: [ square left ifNotNil: [ :p | p left ifNotNil: [ p down ] ] ]).
        (square ifNotNil: [ square up ifNotNil: [ :p | p up ifNotNil: [ p left ] ] ]).
        (square ifNotNil: [ square up ifNotNil: [ :p | p up ifNotNil: [ p right ] ] ]).
        (square ifNotNil: [ square down ifNotNil: [ :p | p down ifNotNil: [ p left ] ] ]).
        (square ifNotNil: [ square down ifNotNil: [ :p | p down ifNotNil: [ p right ] ] ])
    } select: [ :s |
        s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ]
    ]

]
