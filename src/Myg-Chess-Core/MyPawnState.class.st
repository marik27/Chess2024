Class {
	#name : 'MyPawnState',
	#superclass : 'Object',
	#instVars : [
		'pawn'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawnState >> pawn: aPawn [ 
        pawn := aPawn.
    

  
]

{ #category : 'rendering' }
MyPawnState >> targetSquaresLegal: aBoolean [ 
        self subclassResponsibility
    
]
