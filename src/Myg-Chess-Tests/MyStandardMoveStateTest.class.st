Class {
	#name : 'MyStandardMoveStateTest',
	#superclass : 'MyPawnStateTest',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyStandardMoveStateTest >> testCaptureEnPassant [ 
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
    | board pawn opponentPawn Square1 leftSquare captureSquare normalCaptureSquare pawn2 expectedSquares|


    board := MyChessBoard empty.
    Square1:= board at: #e5.
    leftSquare := board  at: #d5. 
    captureSquare := board at: #d6. 

    pawn := MyPawn white.
    pawn state: MyStandardMoveState new.
    pawn setPosition: Square1.

    opponentPawn := MyPawn black .
    opponentPawn state: MyEnPassantState new.
    opponentPawn setPosition: leftSquare.
    leftSquare contents: opponentPawn.

    pawn captureEnPassantTo: captureSquare.

    self assert: leftSquare contents isNil.
    self assert: pawn square equals: captureSquare.
    self assert: captureSquare contents equals: pawn.

	    Transcript show: 'Capture En Passant réussie. Pion blanc en ', captureSquare printString; cr.

    "Repositionner le pion pour tester une capture normale."
	 normalCaptureSquare:= board at: #e7 put: (pawn2:= MyPawn black).
	   normalCaptureSquare contents: pawn2.
	self assert: normalCaptureSquare contents equals: pawn2.
	 Transcript show: 'Pion noir positionné pour une capture normale en ', normalCaptureSquare printString; cr.
	
    pawn diagonalPawnCaptures.
	expectedSquares := OrderedCollection new.
	expectedSquares add: (normalCaptureSquare).  
	self assert: (pawn diagonalPawnCaptures) asSet equals: expectedSquares asSet.
	    Transcript show: 'Captures diagonales possibles : ', (pawn diagonalPawnCaptures printString); cr.
	
	pawn moveTo: normalCaptureSquare.
	self assert: normalCaptureSquare contents equals: pawn. 
 	self assert: captureSquare emptyContents . 
   
    Transcript show: 'Capture normale réussie. Pion blanc déplacé en ', normalCaptureSquare printString; cr.

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
