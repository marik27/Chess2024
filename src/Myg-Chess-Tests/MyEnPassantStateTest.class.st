Class {
	#name : 'MyEnPassantStateTest',
	#superclass : 'MyPawnStateTest',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyEnPassantStateTest >> testPawnStateAfterSingleStepMoveFromEnPassant [
    "test que le pion passe dans l'état standard après un déplacement simple depuis un etat En Passant."
    
    | board pawn initialSquare middleSquare targetSquare |
    board := MyChessBoard empty.

    initialSquare := board  at: #e2. 
    middleSquare := board  at:#e4.
    targetSquare := board  at:#e5.
    pawn := MyPawn white.
    pawn setPosition: initialSquare.
    self assert: (pawn state isKindOf: MyInitialMoveState ).
    
    pawn moveTo: middleSquare.
    self assert: (pawn state isKindOf: MyEnPassantState).

	pawn moveTo: targetSquare.
   self assert: (pawn state isKindOf: MyStandardMoveState).
]
