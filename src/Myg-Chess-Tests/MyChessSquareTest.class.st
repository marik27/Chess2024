Class {
	#name : 'MyChessSquareTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyChessSquareTest >> testDown [
| board square testSquare |
board := MyChessGame freshGame board. 
	square := board at: 'e2'.
	
testSquare := square down.
self assert: testSquare name equals:'e1'.
]
