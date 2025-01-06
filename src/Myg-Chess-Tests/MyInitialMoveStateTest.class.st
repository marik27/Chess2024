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
MyInitialMoveStateTest >> testPawnStateAfterDoubleStepMoveForBlackPawn [

    | board pawn initialSquare targetSquare |
    board := MyChessBoard empty.
    initialSquare := board  at: #c7. 
    targetSquare := board  at: #c5. 
    pawn := MyPawn black.
     pawn state: MyInitialMoveState new.
    pawn setPosition: initialSquare.
    
    pawn moveTo: targetSquare.
    
    self assert: (pawn state isKindOf: MyEnPassantState).
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

{ #category : 'tests' }
MyInitialMoveStateTest >> testTargetSquaresLegalInitialMoveState [

    | board pawn legalMoves expectedSquares singleStepSquare doubleStepSquare |

 
    board := MyChessBoard empty.
    board at: #e2 put: (pawn := MyPawn white).

    legalMoves := pawn targetSquaresLegal: true. 

    singleStepSquare := board at: #e3.
    doubleStepSquare := board at: #e4.

    expectedSquares := OrderedCollection new
        add: singleStepSquare;
        add: doubleStepSquare;
        yourself.

    self assert: legalMoves asSet equals: expectedSquares asSet.

    
]

{ #category : 'tests' }
MyInitialMoveStateTest >> testTargetSquaresLegalInitialMoveStateWhenBlocked [

    | board whitePawn blackPawn legalMoves singleStepSquare doubleStepSquare |

    board := MyChessBoard empty.
    whitePawn := MyPawn white.
    board at: #e2 put: whitePawn.
    blackPawn := MyPawn black.
    board at: #e3 put: blackPawn.
    singleStepSquare := board at: #e3.
    doubleStepSquare := board at: #e4.

    legalMoves := whitePawn targetSquaresLegal: true.

    self deny: (legalMoves includes: singleStepSquare).
    self deny: (legalMoves includes: doubleStepSquare).
    self assert: legalMoves asSet isEmpty.
]
