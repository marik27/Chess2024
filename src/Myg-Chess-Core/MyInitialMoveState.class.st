Class {
	#name : 'MyInitialMoveState',
	#superclass : 'MyPawnState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyInitialMoveState >> moveTo: aSquare for: aPawn [
    "Déplace le pion sur une nouvelle case et met à jour son état."
aPawn square emptyContents.
	aPawn square: aSquare.
    aSquare contents: aPawn .
	aPawn state: MyStandardMoveState new.
    
]

{ #category : 'rendering' }
MyInitialMoveState >> targetSquaresLegal: aPawn [

	| singleStepSquare doubleStepSquare  |
	
	singleStepSquare := aPawn  isWhite
		             ifTrue: [ aPawn square up ]
		             ifFalse: [ aPawn square down ].

	doubleStepSquare := aPawn isWhite
		             ifTrue: [aPawn square up up ]
		             ifFalse: [ aPawn square down down ].
		
		


	^  { singleStepSquare} , { doubleStepSquare } select: [ :s |
		  s notNil and: [ s hasPiece not or: [ s contents color ~= MyPiece color ] ] ]
        

]
