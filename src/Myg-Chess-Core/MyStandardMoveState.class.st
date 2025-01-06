Class {
	#name : 'MyStandardMoveState',
	#superclass : 'MyPawnState',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyStandardMoveState >> adjacentEnPassantPawnsFor: aPawn [ 
 "identifier les pions adverses en état En Passant qui se trouvent dans les cases adjacentes à un pion donné"

    | adjacentSquares adjacentPawns enPassantPawns |

    adjacentSquares := aPawn adjacentSquareTo.
    Transcript show: 'Cases adjacentes: ', adjacentSquares printString; cr.
    adjacentPawns := adjacentSquares collect: [ :square | square contents ].
     adjacentPawns := adjacentPawns select: [ :piece | 
        piece notNil and: [ piece isPawn and: [ piece color ~= aPawn color ] ] ].
    Transcript show: 'Pions adverses détectés: ', adjacentPawns printString; cr.

    enPassantPawns := adjacentPawns select: [ :adjacentPawn | adjacentPawn state class= MyEnPassantState ].
    Transcript show: 'Pions en état En Passant: ', enPassantPawns printString; cr.
 "visitor design pattern"
    ^ enPassantPawns.
]

{ #category : 'as yet unclassified' }
MyStandardMoveState >> captureEnPassantTo: aSquare for: aPawn [ 
" Récupére les pions adjacents en état En Passant, trouver le pion En Passant correspondant à la case cible, retir le pion adverse de sa case et deplace le pion vers la case cible."

    | adjacentEnPassantPawns capturedPawn |

    adjacentEnPassantPawns := self adjacentEnPassantPawnsFor: aPawn.
    Transcript show: 'Pions capturables en passant: ', adjacentEnPassantPawns printString; cr.

    
    capturedPawn := adjacentEnPassantPawns detect: [ :adjacentPawn |
        (aPawn isWhite and: [ adjacentPawn square up = aSquare ]) or:
        (aPawn  isWhite not and: [ adjacentPawn square down = aSquare ])
    ] ifNone: [ nil ].

    Transcript show: 'Case cible: ', aSquare printString; cr.

    capturedPawn ifNotNil: [
        Transcript show: 'Pion capturé: ', capturedPawn printString; cr.

        capturedPawn square emptyContents.
        aPawn square emptyContents.
        aPawn square: aSquare.
        aSquare contents: aPawn.

        Transcript show: 'Capture En Passant réussie. Pion blanc déplacé en ', aSquare printString; cr.
    ] ifNil: [
        Transcript show: 'Aucune capture En Passant possible sur la case ', aSquare printString; cr.
    ].


]

{ #category : 'testing' }
MyStandardMoveState >> isEnPassantMove: aSquare for: aPawn [ 
"vérifie si le mouvement vers la case aSquare  correspond à une capture En Passant pour le pion  (aPawn)."

    ^ aPawn adjacentEnPassantPawns anySatisfy: [ :enPassantPawn |
        (aPawn isWhite and: [ enPassantPawn square up = aSquare ]) or:
        (aPawn isWhite not and: [ enPassantPawn square down = aSquare ])
    ].
]

{ #category : 'as yet unclassified' }
MyStandardMoveState >> moveTo: aSquare for: aPawn [ 
" Deplace le pion aPawn vers une case aSquare en, selon qu'il soit dans cas En Passant ou dans un deplacement standard"

    | isEnPassantMove |

    "Vérifier si le mouvement est une capture En Passant."
    isEnPassantMove := self isEnPassantMove: aSquare for: aPawn.

    isEnPassantMove
        ifTrue: [ 
            "Effectuer la capture En Passant."
            self captureEnPassantTo: aSquare for: aPawn.
        ]
        ifFalse: [ 
            "Effectuer un mouvement standard."
            self standardMoveTo: aSquare for: aPawn.
        ].


]

{ #category : 'as yet unclassified' }
MyStandardMoveState >> standardMoveTo: aSquare for: aPawn [ 
"Deplace le pion aPawn vers une case aSquare. "

    aPawn square emptyContents. 
    aPawn square: aSquare. 
    aSquare contents: aPawn. 
    Transcript show: 'Mouvement standard effectué vers ', aSquare printString; cr.
]

{ #category : 'rendering' }
MyStandardMoveState >> targetSquaresLegal: aPawn [
	"détermine toutes les cases vers lesquelles aPawn peut se déplacer légalement :cas deplacement standard ( une case ou deplacement enPassant."

	| legalMoves singleStepSquare enPassantSquares |
	legalMoves := OrderedCollection new.

	singleStepSquare := aPawn isWhite
		                    ifTrue: [ aPawn square up ]
		                    ifFalse: [ aPawn square down ].

	singleStepSquare ifNotNil: [
		singleStepSquare hasPiece ifFalse: [
			legalMoves add: singleStepSquare ] ].

	enPassantSquares := aPawn adjacentEnPassantPawns collect: [
		                    :enPassantPawn |
		                    aPawn isWhite
			                    ifTrue: [ enPassantPawn square up ]
			                    ifFalse: [ enPassantPawn square down ] ].
	legalMoves addAll: enPassantSquares.

	Transcript
		show: 'Cases légales: ' , legalMoves printString;
		cr.

	^ legalMoves
]
