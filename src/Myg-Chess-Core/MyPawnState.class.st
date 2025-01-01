Class {
	#name : 'MyPawnState',
	#superclass : 'Object',
	#instVars : [
		'pawn'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawnState >> diagonalPawnCaptures: aPawn [
	
	  self subclassResponsibility.
]

{ #category : 'accessing' }
MyPawnState >> pawn: aPawn [ 
        pawn := aPawn.
    

  
]

{ #category : 'rendering' }
MyPawnState >> targetSquaresLegal: aBoolean [ 
        self subclassResponsibility
    
]
