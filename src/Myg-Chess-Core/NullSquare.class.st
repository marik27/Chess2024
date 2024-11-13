Class {
	#name : 'NullSquare',
	#superclass : 'BlElement',
	#instVars : [
		'color'
	],
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
NullSquare >> hasPiece [

	^ false
]

{ #category : 'initialization' }
NullSquare >> initialize [ 

color:= Color transparent 
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
