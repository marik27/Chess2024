Class {
	#name : 'MyChessBoard',
	#superclass : 'BlElement',
	#instVars : [
		'squareMatrix',
		'grid',
		'selected',
		'state',
		'whiteColor',
		'blackColor',
		'game',
		'size',
		'queenPositions'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'instance creation' }
MyChessBoard class >> empty [

	^ super new
]

{ #category : 'instance creation' }
MyChessBoard class >> fromFENBoard: aFENBoard [

	^ super new
		  initializeFromFENBoard: aFENBoard;
		  yourself
]

{ #category : 'instance creation' }
MyChessBoard class >> new [

	self error: 'Please use the other constructors'
]

{ #category : 'accessing' }
MyChessBoard >> at: coordinate [

	^ grid at: coordinate ifAbsent: nil
]

{ #category : 'accessing' }
MyChessBoard >> at: aString ifAbsent: aFullBlockClosure [

	^ grid at: aString ifAbsent: aFullBlockClosure
]

{ #category : 'accessing' }
MyChessBoard >> at: coordinate put: aPiece [

	| square |
	square := grid at: coordinate.
	square contents: aPiece.
	aPiece square: square
]

{ #category : 'accessing' }
MyChessBoard >> blackColor [

	^ blackColor
]

{ #category : 'accessing' }
MyChessBoard >> blackColor: anObject [

	blackColor := anObject
]

{ #category : 'as yet unclassified' }
MyChessBoard >> clearBoard [ [
    grid keysDo: [ :key |
        | square |
        square := grid at: key.
        square contents: nil.
    ].
    selected := nil.
    state := MyUnselectedState board: self.
]
]

{ #category : 'event handling' }
MyChessBoard >> click: aMyChessSquare [ 
	
	state := state clickOn: aMyChessSquare
]

{ #category : 'as yet unclassified' }
MyChessBoard >> displaySolution: solution [
    "Affiche une solution valide de N reines sur le plateau en utilisant at:put:"

    1 to: solution size do: [:row |
        | col coordinate |
        col := solution at: row.
        coordinate := (Character value: ($a asciiValue + col - 1)) asString , row asString.

        (grid includesKey: coordinate) ifTrue: [
            self at: coordinate put: (MyQueen white).
        ] ifFalse: [
            Transcript show: 'Erreur : Case ', coordinate, ' introuvable dans grid'; cr.
        ].
    ].
]

{ #category : 'accessing' }
MyChessBoard >> game [

	^ game
]

{ #category : 'accessing' }
MyChessBoard >> game: aGame [

	game := aGame
]

{ #category : 'highlighting' }
MyChessBoard >> highLightTargets: squares [

	squares do: [ :sq | sq ifNotNil: #highlightTarget ]
]

{ #category : 'initialization' }
MyChessBoard >> initialize [

	super initialize.
	self blackColor: Color blue.
	self whiteColor: Color orange.

	state := MyUnselectedState board: self.
	grid := Dictionary new.

	self background: (BlBackground paint: Color veryVeryLightGray).
	self layout: (BlGridLayout vertical
			 cellSpacing: 5;
			 columnCount: 8;
			 rowCount: 8;
			 yourself).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ].
	
	self initializeWithSize: 9.
	self solveNQueens: 9.
	"self initializeSquares."

]

{ #category : 'initialization' }
MyChessBoard >> initializeFromFENBoard: aFENBoard [ 
    "Place les pièces dynamiquement sur un échiquier pour le puzzle des N reines."

    aFENBoard keysAndValuesDo: [ :k :v |
        v ~= 'empty' ifTrue: [
            | substrings color piece square |
            substrings := v substrings.
            color := substrings first.
            piece := substrings second.
            
            (grid includesKey: k) ifTrue: [
                square := grid at: k.
                ((piece = 'Q') and: [ color = 'white' or: [ color = 'black' ] ]) ifTrue: [
                    square contents: (color = 'white'
                        ifTrue: [ MyQueen white ]
                        ifFalse: [ MyQueen black ]).
                    square contents square: square.
                    square contents board: self.
                ] ifFalse: [
                    Transcript show: '❌ Seules les reines noires et blanches sont placées dans ce mode.'; cr.
                ].
            ] ifFalse: [
                Transcript show: '❌ Position ', k, ' en dehors des limites de l''échiquier'; cr.
            ].
        ]
    ].

]

{ #category : 'initialization' }
MyChessBoard >> initializeNQueensBoardWithSize: size [
    self initializeWithSize: size.
    self clearBoard.
    self solveNQueens: size.
]

{ #category : 'initialization' }
MyChessBoard >> initializePieces [
| black |
	black := false.
	$a asciiValue to: $h asciiValue do: [ :column |
		8 to: 1 by: -1 do: [ :file |
			| squareNotation square |
			squareNotation := column asCharacter asString , file asString.
			square := black
				          ifTrue: [
					          black := false.
					          MyChessSquare basicNew
						          color: Color black;
						          board: self;
						          initialize;
						          yourself ]
				          ifFalse: [
					          black := true.
					          MyChessSquare basicNew
						          color: Color white;
						          board: self;
						          initialize;
						          yourself ].
			square name: squareNotation.
			grid at: squareNotation put: square.
			self addChild: square ].
		black := black not ].

	self at: 'a1' put: MyRook white.
	self at: 'b1' put: MyKnight white.
	self at: 'c1' put: MyBishop white.
	self at: 'd1' put: MyQueen white.
	self at: 'e1' put: MyKing white.
	self at: 'f1' put: MyBishop white.
	self at: 'g1' put: MyKnight white.
	self at: 'h1' put: MyRook white.

	$a asciiValue to: $h asciiValue do: [ :column |
		self at: column asCharacter asString , '2' put: MyPawn white ].

	self at: 'a8' put: MyRook black.
	self at: 'b8' put: MyKnight black.
	self at: 'c8' put: MyBishop black.
	self at: 'd8' put: MyQueen black.
	self at: 'e8' put: MyKing black.
	self at: 'f8' put: MyBishop black.
	self at: 'g8' put: MyKnight black.
	self at: 'h8' put: MyRook black.

	$a asciiValue to: $h asciiValue do: [ :column |
		self at: column asCharacter asString , '7' put: MyPawn black ]
]

{ #category : 'initialization' }
MyChessBoard >> initializePiecesWithSize: size [

    | columnRange firstRow secondRow penultimateRow lastRow square position piece |

    "Définir dynamiquement les lignes importantes"
    columnRange := ($a asciiValue) to: ($a asciiValue + size - 1).
    firstRow := 1.
    secondRow := 2.
    penultimateRow := size - 1.
    lastRow := size.

    "✅ Placement des pièces blanches (1ère ligne)"
     columnRange withIndexDo: [ :columnAscii :index |
        position := (columnAscii asCharacter asString), firstRow asString.
        square := grid at: position ifAbsent: [
            self error: 'Position ', position, ' introuvable dans grid.'
        ].
        piece := (index caseOf: {
            [1] -> [ MyRook white ].
            [2] -> [ MyKnight white ].
            [3] -> [ MyBishop white ].
          [(size // 2)] -> [ MyKing white ].
            [(size // 2) + 1] -> [ MyKing white ].
           	[(size // 2) + 2] -> [ MyBishop white ].
            [(size - 2)] -> [ MyKnight white ].
            [(size - 1)] -> [ MyRook white ].
				[size] -> [ MyRook white ].
        } otherwise: [ nil ]).
        square contents: piece.
        piece ifNotNil: [ piece square: square ].
    ].

    "✅ Placement des pions blancs (2ème ligne)"
    columnRange do: [ :columnAscii |
        position := (columnAscii asCharacter asString), secondRow asString.
        square := grid at: position ifAbsent: [
            self error: 'Position ', position, ' introuvable dans grid.'
        ].
        piece := MyPawn white.
        square contents: piece.
        piece ifNotNil: [ piece square: square ].
    ].

    "✅ Placement des pions noirs (avant-dernière ligne)"
    columnRange do: [ :columnAscii |
        position := (columnAscii asCharacter asString), penultimateRow asString.
        square := grid at: position ifAbsent: [
            self error: 'Position ', position, ' introuvable dans grid.'
        ].
        piece := MyPawn black.
        square contents: piece.
        piece ifNotNil: [ piece square: square ].
    ].

    "✅ Placement des pièces noires (dernière ligne)"
    columnRange withIndexDo: [ :columnAscii :index |
        position := (columnAscii asCharacter asString), lastRow asString.
        square := grid at: position ifAbsent: [
            self error: 'Position ', position, ' introuvable dans grid.'
        ].
        piece := (index caseOf: {
            [1] -> [ MyRook black ].
            [2] -> [ MyKnight black ].
            [3] -> [ MyBishop black ].
          [(size // 2)] -> [ MyKing black ].
            [(size // 2) + 1] -> [ MyKing black ].
           	[(size // 2) + 2] -> [ MyBishop black ].
            [(size - 2)] -> [ MyKnight black ].
            [(size - 1)] -> [ MyRook black ].
				[size] -> [ MyRook black ].
        } otherwise: [ nil ]).
        square contents: piece.
        piece ifNotNil: [ piece square: square ].
    ].

]

{ #category : 'initialization' }
MyChessBoard >> initializeSquares [

	| black |
	black := false.
	$a asciiValue to: $h asciiValue do: [ :column |
		8 to: 1 by: -1 do: [ :file |
			| squareNotation square |
			squareNotation := column asCharacter asString , file asString.
			square := black
				          ifTrue: [
					          black := false.
					          MyChessSquare basicNew
						          color: Color black;
						          board: self;
						          initialize;
						          contents: nil;
						          yourself ]
				          ifFalse: [
					          black := true.
					          MyChessSquare basicNew
						          color: Color white;
						          board: self;
						          initialize;
						          contents: nil;
						          yourself ].
			square name: squareNotation.
			grid at: squareNotation put: square.
			self addChild: square ].
		black := black not ]
]

{ #category : 'initialization' }
MyChessBoard >> initializeSquaresWithSize: size [
    "Initialise un plateau de taille donnée avec une alternance correcte des couleurs"

   | black |
    black := false.

    ($a asciiValue) to: ($a asciiValue + size - 1) do: [:column |
        size to: 1 by: -1 do: [:row |
            | squareNotation square expectedColor |

            "Créer la notation de la case (ex: 'a1', 'b2', ...)"
            squareNotation := column asCharacter asString , row asString.

            "Alterner la couleur basée sur la somme des indices de ligne et colonne"
            expectedColor := ((column - $a asciiValue + row) odd
                ifTrue: [ Color black ]
                ifFalse: [ Color white ]).

            "Créer la case avec la couleur calculée"
            square := MyChessSquare basicNew
                        color: expectedColor;
                        board: self;
                        initialize;
                        contents: nil;
                        yourself.

            "Assigner le nom et ajouter au tableau"
            square name: squareNotation.
            
            "Vérifier si la case est valide avant de l'ajouter"
            grid at: squareNotation put: square.
            (square isKindOf: MyChessSquare) ifTrue: [
                self addChild: square.
            ] ifFalse: [
                self error: 'Erreur lors de l’ajout de la case ', squareNotation.
            ].
        ].
        black := black not.
    ].

]

{ #category : 'initialization' }
MyChessBoard >> initializeWithSize: size [
   super initialize.

	super initialize.

	self blackColor: Color blue.
	self whiteColor: Color orange.

	state := MyUnselectedState board: self.
	grid := Dictionary new.

	self background: (BlBackground paint: Color veryVeryLightGray).
	self layout: (BlGridLayout vertical
			 cellSpacing: 5;
			 columnCount: size;
			 rowCount: size;
			 yourself).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ].
	
    self initializeSquaresWithSize: size.
    self initializePiecesWithSize: size.
]

{ #category : 'testing' }
MyChessBoard >> isSafeAtRow: row column: col [
    "Vérifie si une reine peut être placée en toute sécurité sur une case donnée."
    1 to: row - 1 do: [:r |
        | c |
        c := queenPositions at: r ifAbsent: [ nil ].
        c ifNotNil: [
            (c = col or: [(c - col) abs = (r - row) abs]) ifTrue: [ ^false ].
        ].
    ].
    ^true
]

{ #category : 'testing' }
MyChessBoard >> isSafeAtRow: row column: col board: board [ 
    "Vérifie si une reine peut être placée en toute sécurité."
    1 to: row - 1 do: [:r |
        | c |
        c := board at: r.
        c ifNotNil: [
            (c = col or: [(c - col) abs = (r - row) abs]) ifTrue: [^false]
        ].
    ].
    ^true

]

{ #category : 'accessing' }
MyChessBoard >> pieces [
	
	^ children collect: [ :square | square contents ]
]

{ #category : 'as yet unclassified' }
MyChessBoard >> placeQueenOnRow: row board: board size: size solutions: solutions [
    row > size ifTrue: [
        solutions add: board copy.
        ^self
    ].
    1 to: size do: [:col |
        (self isSafeAtRow: row column: col board: board) ifTrue: [
            board at: row put: col.
            self placeQueenOnRow: row + 1 board: board size: size solutions: solutions.
            board at: row put: nil.
        ]
    ].
]

{ #category : 'accessing' }
MyChessBoard >> select: aSquare [ 
	
	state select: aSquare
]

{ #category : 'accessing' }
MyChessBoard >> selected: aMyChessSquare [ 
	
	selected := aMyChessSquare
]

{ #category : 'as yet unclassified' }
MyChessBoard >> solveNQueens: size [ 
    "Résout le problème des N reines pour un échiquier de taille donnée et affiche une solution valide."

    | board solutions |
    board := Array new: size.
    solutions := OrderedCollection new.
    queenPositions := OrderedCollection new. "Initialisation des positions des reines"

    self placeQueenOnRow: 1 board: board size: size solutions: solutions.
    
    "Afficher la première solution trouvée"
    solutions isEmpty ifFalse: [
        self displaySolution: solutions first.
        Transcript show: '✅ Solution trouvée et affichée.'; cr.
        "Remplir queenPositions avec les coordonnées finales"
        1 to: size do: [:row |
            | col coordinate |
            col := solutions first at: row.
            coordinate := (Character value: ($a asciiValue + col - 1)) asString , row asString.
            queenPositions add: coordinate.
        ].
    ] ifTrue: [
        Transcript show: '❌ Aucune solution trouvée pour les N reines.'; cr.
    ].

]

{ #category : 'highlighting' }
MyChessBoard >> unhighLightTargets: squares [

	squares do: [ :sq | sq ifNotNil: #unhighlightTarget ]
]

{ #category : 'selection' }
MyChessBoard >> unselectSelected [
	
	selected ifNil: [ ^ self ].
	selected doUnselect
]

{ #category : 'accessing' }
MyChessBoard >> whiteColor [

	^ whiteColor
]

{ #category : 'accessing' }
MyChessBoard >> whiteColor: anObject [

	whiteColor := anObject
]
