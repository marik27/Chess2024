Class {
	#name : 'MyInitialMoveState',
	#superclass : 'MyPawnState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyInitialMoveState >> moveTo: aSquare for: aPawn [ 
    "Déplace le pion sur une nouvelle case et met à jour son état."
    
    | doubleStepSquare |
    
    doubleStepSquare := aPawn isWhite
        ifTrue: [ aPawn square up up ]
        ifFalse: [ aPawn square down down ].
	 aPawn square emptyContents. 
    aPawn square: aSquare. 
    aSquare contents: aPawn. 
    
    (aSquare = doubleStepSquare)
        ifTrue: [ aPawn state: MyEnPassantState new ]
        ifFalse: [ aPawn state: MyStandardMoveState new ].

    "Mise a jour du statut du  deplacement."
    aPawn hasMoved: true. 

	
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
		  s notNil and: [ s hasPiece not or: [ s contents color ~= aPawn color ] ] ]
        

]
