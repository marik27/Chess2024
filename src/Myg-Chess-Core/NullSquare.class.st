Class {
	#name : 'NullSquare',
	#superclass : 'AbstractSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
NullSquare >> color [

	^ color 
]

{ #category : 'accessing' }
NullSquare >> color: aColor [

 color:=aColor
]

{ #category : 'accessing' }
NullSquare >> contents [

	^ nil
]

{ #category : 'accessing' }
NullSquare >> down [

	^ self
]

{ #category : 'accessing' }
NullSquare >> hasPiece [

	^ false
]

{ #category : 'initialization' }
NullSquare >> initialize [
	super initialize.
	color := Color transparent
]

{ #category : 'accessing' }
NullSquare >> left [

	^ self
]

{ #category : 'printing' }
NullSquare >> printOn: aStream [ 
       
        aStream nextPutAll: 'Empty square'
]

{ #category : 'as yet unclassified' }
NullSquare >> renderBishop: aPiece [

	^ nil
]

{ #category : 'as yet unclassified' }
NullSquare >> renderKing: aPiece [

	^ nil
]

{ #category : 'as yet unclassified' }
NullSquare >> renderKnight: aPiece [

	^ nil
]

{ #category : 'as yet unclassified' }
NullSquare >> renderPawn: aPiece [

	^ nil
]

{ #category : 'as yet unclassified' }
NullSquare >> renderQueen: aPiece [

	^ nil
]

{ #category : 'as yet unclassified' }
NullSquare >> renderRook: aPiece [

	^ nil
]

{ #category : 'accessing' }
NullSquare >> right [  
^ self
]

{ #category : 'accessing' }
NullSquare >> up [

	^ self
]
