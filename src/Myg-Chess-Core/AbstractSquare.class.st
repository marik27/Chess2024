Class {
	#name : 'AbstractSquare',
	#superclass : 'BlElement',
	#instVars : [
		'color'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
AbstractSquare >> down [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
AbstractSquare >> hasPiece [

	^ self subclassResponsibility
]

{ #category : 'initialization' }
AbstractSquare >> initialize [ 

super initialize 
]

{ #category : 'as yet unclassified' }
AbstractSquare >> left [ 

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
AbstractSquare >> right [

	^ self subclassResponsibility
]

{ #category : 'as yet unclassified' }
AbstractSquare >> up [
	^ self subclassResponsibility
]
