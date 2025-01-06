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
MyPawn >> adjacentEnPassantPawns [ 
    "Déléguer au comportement de l'état actuel."
    ^ self state adjacentEnPassantPawnsFor: self.


]

{ #category : 'as yet unclassified' }
MyPawn >> adjacentSquareTo [
  "Récupérer les cases adjacentes gauche et droite et retourne les cases valides (non nil)."

 |leftSquare rightSquare |
  
    leftSquare := self square left.
    rightSquare := self  square right.
   
    ^ { leftSquare. rightSquare } select: [ :each | each notNil ].



]

{ #category : 'as yet unclassified' }
MyPawn >> captureEnPassantTo: aSquare [ 
    self state captureEnPassantTo: aSquare for: self.
]

{ #category : 'as yet unclassified' }
MyPawn >> diagonalPawnCaptures [
	"determine des cases diagonales pour les captures et filtre les cases qui contiennent une pièce de couleur opposée."

	| leftCapture rightCapture captureSquares |
	leftCapture := self isWhite
		               ifTrue: [ square up left ]
		               ifFalse: [ square down left ].

	rightCapture := self isWhite
		                ifTrue: [ square up right ]
		                ifFalse: [ square down right ].

	captureSquares := OrderedCollection new.

	leftCapture ifNotNil: [
		(leftCapture hasPiece and: [ leftCapture contents color ~= color ])
			ifTrue: [ captureSquares add: leftCapture ] ].

	rightCapture ifNotNil: [
		(rightCapture hasPiece and: [ rightCapture contents color ~= color ])
			ifTrue: [ captureSquares add: rightCapture ] ].

	^ captureSquares
]

{ #category : 'accessing' }
MyPawn >> hasMoved [
^hasMoved 
]

{ #category : 'accessing' }
MyPawn >> hasMoved: aMove [
hasMoved:= aMove 
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
MyPawn >> isPawn [
^true
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [ 
"permet de deplace le pion actuel vers la case aSquare"

 | legalMoves |

    legalMoves := self targetSquaresLegal: self.
    (legalMoves includes: aSquare)
        ifTrue: [ state moveTo: aSquare for: self ].

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

  "détermine toutes les cases vers lesquelles le pion actuel peut se déplacer légalement :cas deplacement standard ( selon l'etat du pion) et une capture en diagonale."

	 | standardmove captureDiagonalPawn |
	
	standardmove := state targetSquaresLegal: self.
	
	captureDiagonalPawn := self diagonalPawnCaptures.
	

	^ standardmove, captureDiagonalPawn 
	
]
