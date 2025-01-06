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

{ #category : 'as yet unclassified' }
NullSquare >> isNullSquare [ 
^true
]

{ #category : 'accessing' }
NullSquare >> left [

	^ self
]

{ #category : 'printing' }
NullSquare >> printOn: aStream [ 
       
        aStream nextPutAll: 'Empty square'
]

{ #category : 'accessing' }
NullSquare >> right [  
^ self
]

{ #category : 'accessing' }
NullSquare >> up [

	^ self
]
