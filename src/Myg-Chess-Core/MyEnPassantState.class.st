Class {
	#name : 'MyEnPassantState',
	#superclass : 'MyPawnState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyEnPassantState >> moveTo: aSquare for: aPawn [ 
      aPawn square emptyContents.
        aPawn square: aSquare.
        aSquare contents: aPawn.
aPawn state: MyStandardMoveState new.
]

{ #category : 'rendering' }
MyEnPassantState >> targetSquaresLegal: aPawn [ 

	| singleStepSquare |
	singleStepSquare := aPawn isWhite
		             ifTrue: [ aPawn square up ]
		             ifFalse: [ aPawn square down ].
		
	"if true renvoi signleStep sinon tableau vide"
  ^ (singleStepSquare notNil and: [ singleStepSquare hasPiece not ])
            ifTrue: [ { singleStepSquare } ]
            ifFalse: [ #() ].
]
