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
"determine les mouvement legal que peut faire le pion dans son etat initial"
	| singleStepSquare doubleStepSquare legalMoves |
	legalMoves := OrderedCollection new.
	
	
	singleStepSquare := aPawn isWhite
		                    ifTrue: [ aPawn square up ]
		                    ifFalse: [ aPawn square down ].

	doubleStepSquare := aPawn isWhite
		                    ifTrue: [ aPawn square up up ]
		                    ifFalse: [ aPawn square down down ].

	singleStepSquare ifNotNil: [ 
		singleStepSquare hasPiece ifFalse: [
			legalMoves add: singleStepSquare ] ].

	(aPawn hasMoved not and: [ singleStepSquare notNil ]) ifTrue: [
		((singleStepSquare hasPiece not and: [ doubleStepSquare notNil ])
			 and: [ doubleStepSquare hasPiece not ]) ifTrue: [
			legalMoves add: doubleStepSquare ] ].

	^ legalMoves
]
