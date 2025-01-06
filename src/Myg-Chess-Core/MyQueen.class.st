Class {
	#name : 'MyQueen',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'path commands' }
MyQueen >> legalTargetSquares [
    | moves |
    moves := self targetSquaresLegal: true.
    ^ moves
]

{ #category : 'rendering' }
MyQueen >> renderPieceOn: aSquare [

	^ aSquare renderQueen: self
]

{ #category : 'rendering' }
MyQueen >> targetSquaresLegal: aBoolean [ 
    | likeABishop likeARook |
    "Calcule les mouvements valides en combinant les mouvements d'un fou et d'une tour."
    likeABishop := (self upRightDiagonalLegal: aBoolean)
                   , (self upLeftDiagonalLegal: aBoolean)
                   , (self downRightDiagonalLegal: aBoolean)
                   , (self downLeftDiagonalLegal: aBoolean).
    likeARook := (self upFileLegal: aBoolean)
                 , (self downFileLegal: aBoolean)
                 , (self leftFileLegal: aBoolean)
                 , (self rightFileLegal: aBoolean).
    
    ^ likeABishop , likeARook

]
