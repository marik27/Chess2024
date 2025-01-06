Class {
	#name : 'MyInitialMoveStateTest',
	#superclass : 'MyPawnStateTest',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyInitialMoveStateTest >> testInitialPawnState [ 
	"Vérifie que le pion est initialement dans l'état MyInitialMoveState."

	| pawn |
	pawn := MyPawn new.
	self assert: (pawn state isKindOf: MyInitialMoveState).
]

{ #category : 'tests' }
MyInitialMoveStateTest >> testPawnStateAfterDoubleStepMoveInitial [ 
    "test que le pion passe dans l'état en passant après un double pas."
    
    | board pawn initialSquare targetSquare |
    board := MyChessBoard empty.
    initialSquare := board  at: #e2. 
    targetSquare := board  at:#e4. 
    pawn := MyPawn white.
    pawn setPosition: initialSquare.
    
    pawn moveTo: targetSquare.
    
    self assert: (pawn state isKindOf: MyEnPassantState).

]

{ #category : 'tests' }
MyInitialMoveStateTest >> testPawnStateAfterSingleStepMoveInitial [ 
    "Test que le pion passe dans l'état standard après un déplacement simple."
    
    | board pawn initialSquare targetSquare |

    board := MyChessBoard empty.
    initialSquare := board  at: #e2. 
    targetSquare := board  at:#e3. 
    pawn := MyPawn white.
    pawn setPosition: initialSquare.
    
    pawn moveTo: targetSquare.
    
    self assert: (pawn state isKindOf: MyStandardMoveState).
]
