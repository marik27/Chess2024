Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

    ^ (self isWhite
        ifTrue: [ 
            square ifNotNil: [ 
                { square up ifNotNil: [ :sq | sq ] } 
            ] ifNil: [ #() ] 
        ]
        ifFalse: [
            square ifNotNil: [ 
                { square down ifNotNil: [ :sq | sq ] } 
            ] ifNil: [ #() ] 
        ]
    ) select: [ :s |
        s notNil and: [
            s hasPiece not or: [ s contents color ~= color ]
        ]
    ].

]
