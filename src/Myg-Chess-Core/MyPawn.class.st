Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'hasMoved',
		'state'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> diagonalPawnCaptures [

	| leftCapture rightCapture captureSquares |
	"Calcul des cases diagonales pour les captures"
	leftCapture := self isWhite
		               ifTrue: [ square up left ]
		               ifFalse: [ square down left ].

	rightCapture := self isWhite
		                ifTrue: [ square up right ]
		                ifFalse: [ square down right ].

	"Filtrer les cases qui contiennent une pièce de couleur opposée"
	captureSquares := OrderedCollection new.
	
	leftCapture notNil ifTrue: [
		(leftCapture hasPiece and: [ leftCapture contents color ~= color ])
			ifTrue: [ captureSquares add: leftCapture ] ].

	rightCapture notNil ifTrue: [
		(rightCapture hasPiece and: [ rightCapture contents color ~= color ])
			ifTrue: [ captureSquares add: rightCapture ] ].

	^ captureSquares
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'initialization' }
MyPawn >> initialize [ 
    super initialize.
    hasMoved := false.
	state := MyInitialMoveState new.
]

{ #category : 'testing' }
MyPawn >> isFirstMove [ 

"Transcript show: self square file;cr."

  ^ (self isWhite 
			ifTrue: [self square file = $2] 
			ifFalse: [self square file = $7])


]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [ 
    "Déplace le pion sur une nouvelle case et met à jour son état."
   " super moveTo: aSquare.
    aSquare contents: self."
	state moveTo: aSquare for: self.
	
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'initialization' }
MyPawn >> setPosition: aSquare [ 
        square := aSquare.
    
]

{ #category : 'accessing' }
MyPawn >> state [ 
   ^ state
]

{ #category : 'accessing' }
MyPawn >> state: aState [ 
  state := aState
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [ 
        ^ state targetSquaresLegal: self.
]
