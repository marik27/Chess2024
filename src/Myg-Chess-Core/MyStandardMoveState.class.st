Class {
	#name : 'MyStandardMoveState',
	#superclass : 'MyPawnState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyStandardMoveState >> moveTo: aSquare for: aPawn [ 
        aPawn square emptyContents.
        aPawn square: aSquare.
        aSquare contents: aPawn.

]

{ #category : 'rendering' }
MyStandardMoveState >> targetSquaresLegal: aPawn [

	| singleStepSquare |
	singleStepSquare := aPawn isWhite
		             ifTrue: [ aPawn square up ]
		             ifFalse: [ aPawn square down ].
		
	
  ^ (singleStepSquare notNil and: [ singleStepSquare hasPiece not ])
            ifTrue: [ { singleStepSquare } ]
            ifFalse: [ #() ].
]
