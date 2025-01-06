Class {
	#name : 'MyStandardMoveStateTest',
	#superclass : 'MyPawnStateTest',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyStandardMoveStateTest >> testBlackPawnSingleStepDown [
" test deplacement d'un pion noir ( vers le bas ) en etat  standard"
    | board blackPawn initialSquare legalSquare legalMoves |


    board := MyChessBoard empty.
    initialSquare := board at: #e7.
    legalSquare   := board at: #e6.

    blackPawn := MyPawn black.
    blackPawn setPosition: initialSquare.
    initialSquare contents: blackPawn.

    self assert: initialSquare contents equals: blackPawn.
    legalMoves := blackPawn targetSquaresLegal: blackPawn.
    self assert: (legalMoves includes: legalSquare).


    board at: #e6 put: (MyPawn white).
    legalMoves := blackPawn targetSquaresLegal: blackPawn.
    self deny: (legalMoves includes: legalSquare).



]

{ #category : 'tests' }
MyStandardMoveStateTest >> testCaptureEnPassantBlackPawn [
    | board blackPawn whitePawn blackPawnSquare adjacentSquare captureSquare |


    board := MyChessBoard empty.
    blackPawnSquare := board at: #e4.  
    adjacentSquare := board at: #d4.
    captureSquare := board at: #d3.

    blackPawn := MyPawn black.
    blackPawn state: MyStandardMoveState new.
    blackPawn setPosition: blackPawnSquare.
    blackPawnSquare contents: blackPawn.

    whitePawn := MyPawn white.
    whitePawn state: MyEnPassantState new.
    whitePawn setPosition: adjacentSquare.
    adjacentSquare contents: whitePawn.


    Transcript show: 'Pion noir en ', blackPawnSquare printString, ' / Pion blanc (En Passant) en ', adjacentSquare printString; cr.


    blackPawn captureEnPassantTo: captureSquare.

    self assert: adjacentSquare contents isNil.        
    self assert: blackPawn square equals: captureSquare. 
    self assert: captureSquare contents equals: blackPawn.

    Transcript show: 'Capture en passant réussie : Pion noir déplacé à ', captureSquare printString; cr.

]

{ #category : 'tests' }
MyStandardMoveStateTest >> testCaptureEnPassantwhitePawn [ 
    | board pawn opponentPawn Square leftSquare captureSquare |


    board := MyChessBoard empty.
    Square:= board at: #e5.
    leftSquare := board  at: #d5. 
    captureSquare := board at: #d6. 

    pawn := MyPawn white.
    pawn state: MyStandardMoveState new.
    pawn setPosition: Square.

    opponentPawn := MyPawn black .
    opponentPawn state: MyEnPassantState new.
    opponentPawn setPosition: leftSquare.
    leftSquare contents: opponentPawn.
	    Transcript show: 'Capture réussie : Pion déplacé à ', captureSquare printString; cr.
    pawn captureEnPassantTo: captureSquare.

    self assert: leftSquare contents isNil.
    self assert: pawn square equals: captureSquare.
    self assert: captureSquare contents equals: pawn.

]

{ #category : 'tests' }
MyStandardMoveStateTest >> testCaptureNormalAfterEnPassant [
    | board whitePawn blackPawnEnPassant blackPawnNormal e5 EnPassantSquare EnPassantCaptureSquare captureStandardSquare |

    board := MyChessBoard empty.
    e5 := board at: #e5.  
    EnPassantSquare := board at: #d5. 
    EnPassantCaptureSquare := board at: #d6.  
    captureStandardSquare := board at: #e7.  

    whitePawn := MyPawn white.
    whitePawn state: MyStandardMoveState new.
    whitePawn setPosition: e5.       
    e5 contents: whitePawn.         

  
    blackPawnEnPassant := MyPawn black.
    blackPawnEnPassant state: MyEnPassantState new.
    blackPawnEnPassant setPosition: EnPassantSquare.
    EnPassantSquare contents: blackPawnEnPassant.

    
    self assert: e5 contents equals: whitePawn.
    self assert: EnPassantSquare contents equals: blackPawnEnPassant.

    "capture En Passant"
    whitePawn moveTo: EnPassantCaptureSquare.  

    self assert: e5 contents isNil.                  
    self assert: EnPassantSquare contents isNil.                  
    self assert: EnPassantCaptureSquare contents equals: whitePawn.     

    Transcript cr; show: 'En Passant réussi : pion blanc en d6.'; cr.

    " la capture enDiagonale"
    blackPawnNormal := MyPawn black.
    blackPawnNormal state: MyStandardMoveState new.
    blackPawnNormal setPosition: captureStandardSquare.
    captureStandardSquare contents: blackPawnNormal.

    self assert: captureStandardSquare contents equals: blackPawnNormal.

    Transcript cr; show: 'Pion noir placé pour capture normale en e7.'; cr.

    whitePawn moveTo: captureStandardSquare.  

    self assert: EnPassantCaptureSquare contents isNil.                 
    self assert: captureStandardSquare contents equals: whitePawn.     

    Transcript cr; show: 'Capture normale réussie : pion blanc en e7.'; cr.

]

{ #category : 'tests' }
MyStandardMoveStateTest >> testMoveToWithCaptureEnPassant [ 
"vérifier que la capture a été effectuée correctement:
   - la case de l'adversaire doit être vide
   - le pion doit être sur la case cible."

    | board pawn opponentPawn initialSquare opponentSquare enPassantTarget |

 	  board := MyChessBoard empty.
    initialSquare := board at: #e5. "e5"
    opponentSquare := board at: #d5. "d5"
    enPassantTarget := board at: #d6. "d6"


    pawn := MyPawn white.
    pawn state: MyStandardMoveState new.
    pawn setPosition: initialSquare.

    opponentPawn := MyPawn black.
    opponentPawn state: MyEnPassantState new.
    opponentPawn setPosition: opponentSquare.
    opponentSquare contents: opponentPawn.

    pawn moveTo: enPassantTarget.


    self assert: opponentSquare contents isNil. 
    self assert: enPassantTarget contents equals: pawn. 


]

{ #category : 'tests' }
MyStandardMoveStateTest >> testPawnStateAfterSingleStepMoveStandard [
    "test que le pion reste dans l'état standard après un déplacement simple."
    
    | board pawn initialSquare middleSquare targetSquare |
    board := MyChessBoard empty.

    initialSquare := board  at: #e2. 
    middleSquare := board  at:#e3.
    targetSquare := board  at:#e4.
    pawn := MyPawn white.
    pawn setPosition: initialSquare.
    self assert: (pawn state isKindOf: MyInitialMoveState ).
    
    pawn moveTo: middleSquare.
    self assert: (pawn state isKindOf: MyStandardMoveState).

	pawn moveTo: targetSquare.
   self assert: (pawn state isKindOf: MyStandardMoveState).
]
