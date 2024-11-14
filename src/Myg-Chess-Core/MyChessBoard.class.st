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
		'queensPlaced'
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

{ #category : 'as yet unclassified' }
MyChessBoard >> allPositions [ 
    | positions |
    positions := OrderedCollection new.
    
    "Génère toutes les positions de a1 à i9"
    $a asciiValue to: $i asciiValue do: [ :column |
        1 to: 9 do: [ :row |
            positions add: (column asCharacter asString , row asString) ].
    ].
    
    ^ positions

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

{ #category : 'event handling' }
MyChessBoard >> click: aMyChessSquare [ 
	
	state := state clickOn: aMyChessSquare
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
			 columnCount: 9;
			 rowCount: 9;
			 yourself).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ].

	self initializeSquares.
	self placeNineQueens.
]

{ #category : 'initialization' }
MyChessBoard >> initializeFromFENBoard: aFENBoard [

	aFENBoard keysAndValuesDo: [ :k :v |
		v ~= 'empty' ifTrue: [
			| substrings color piece |
			substrings := v substrings.
			color := substrings first.
			piece := substrings second.
			self
				at: k
				put:
					((self class environment at: ('My' , piece capitalized) asSymbol)
						 perform: color asLowercase asSymbol) ] ]
]

{ #category : 'initialization' }
MyChessBoard >> initializePieces [
    | black |
    black := false.
    
    "Création des cases du plateau en alternant les couleurs de a1 à i9"
    $a asciiValue to: $i asciiValue do: [ :column |
        9 to: 1 by: -1 do: [ :file |
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
        black := black not ].
    "Placement des pièces noires sur la rangée 1"
    self at: 'a1' put: MyRook black.
    self at: 'b1' put: MyKnight black.
    self at: 'c1' put: MyBishop black.
    self at: 'd1' put: MyQueen black.
    self at: 'e1' put: MyKing black.
    self at: 'f1' put: MyBishop black.
    self at: 'g1' put: MyKnight black.
    self at: 'h1' put: MyRook black.
    self at: 'i1' put: MyKnight black. "Ajout de la reine supplémentaire sur la 9e colonne"

    "Placement des pions noirs sur la rangée 9"
    $a asciiValue to: $i asciiValue do: [ :column |
        self at: column asCharacter asString , '9' put: MyPawn black ].

    "Placement des pièces blanches sur la rangée 8"
    self at: 'a8' put: MyRook white.
    self at: 'b8' put: MyKnight white.
    self at: 'c8' put: MyBishop white.
    self at: 'd8' put: MyQueen white.
    self at: 'e8' put: MyKing white.
    self at: 'f8' put: MyBishop white.
    self at: 'g8' put: MyKnight white.
    self at: 'h8' put: MyRook white.
    self at: 'i8' put: MyQueen white. "Ajout de la reine supplémentaire sur la 9e colonne"

    "Placement des pions blancs sur la rangée 2"
    $a asciiValue to: $i asciiValue do: [ :column |
        self at: column asCharacter asString , '2' put: MyPawn white ].
]

{ #category : 'initialization' }
MyChessBoard >> initializeSquares [ 
    | black |
    black := false.

    "Boucle pour les 9 colonnes (de a à i) et les 9 lignes (de 1 à 9)"
    $a asciiValue to: $i asciiValue do: [ :column |
        1 to: 9 do: [ :row |
            | squareNotation square |
            squareNotation := (Character value: column) asString , row asString. "Par ex., 'a1', 'b2', etc."
            square := MyChessSquare basicNew
                color: (black ifTrue: [ Color black ] ifFalse: [ Color white ]);
                board: self;
                initialize;
                contents: nil;
                yourself.
            square name: squareNotation.
            grid at: squareNotation put: square.
            black := black not.
            self addChild: square.
        ].
        black := black not.
    ].

]

{ #category : 'testing' }
MyChessBoard >> isSafePosition: coordinate [ 
    | row column |
    row := coordinate second asInteger.
    column := (coordinate first asciiValue - $a asciiValue + 1).

    "Vérifie qu'aucune reine existante ne menace cette position"
    self pieces do: [ :piece |
        piece ifNotNil: [
            (piece isQueen and: [ piece square notNil ]) ifTrue: [
                | posRow posColumn |
                posRow := piece square name second asInteger.
                posColumn := (piece square name first asciiValue - $a asciiValue + 1).

                "Vérifie les conditions de menace séparément"
                "Même rangée"
                (posRow = row) ifTrue: [ ^ false ].
                "Même colonne"
                (posColumn = column) ifTrue: [ ^ false ].
                "Même diagonale"
                ((posRow - row) abs = (posColumn - column) abs) ifTrue: [ ^ false ].
            ].
        ].
    ].
    ^ true "Retourne true si aucune menace n'est détectée"

]

{ #category : 'accessing' }
MyChessBoard >> pieces [
	
	^ children collect: [ :square | square contents ]
]

{ #category : 'as yet unclassified' }
MyChessBoard >> placeNineQueens [
    "Réinitialise le compteur de reines placées et commence le placement"
    queensPlaced := 0.
    self placeQueensOnRow: 1.
]

{ #category : 'as yet unclassified' }
MyChessBoard >> placeQueensOnRow: row [ 
  | usedColumns |
    usedColumns := Set new.
    "Si 9 reines ont été placées, on arrête la récursion"
    queensPlaced = 9 ifTrue: [ ^ self ].

    "Ensemble pour suivre les colonnes déjà occupées"
  

    "Parcours toutes les colonnes de la ligne actuelle (de 1 à 9)"
    1 to: 9 do: [ :column |
        | coordinate square |
        "Forme la coordonnée en minuscules, par ex. 'a1'"
        coordinate := (Character value: ($a asciiValue + column - 1)) asString , row asString.

        "Vérifie si la colonne est déjà utilisée"
        (usedColumns includes: column) ifTrue: [ ^ self ].

        "Récupère la case et vérifie si elle est dans le plateau et qu'elle est sûre"
        square := grid at: coordinate ifAbsent: [ nil ].

        (square notNil and: [ self isSafePosition: coordinate ]) ifTrue: [
            "Place la reine temporairement"
            square contents: (MyQueen new color: Color white).
            queensPlaced := queensPlaced + 1.

            "Ajoute la colonne à l'ensemble des colonnes utilisées"
            usedColumns add: column.

            "Passe à la prochaine ligne récursivement"
            self placeQueensOnRow: row + 1.

            "Condition pour stopper toute la récursion si la solution est trouvée"
            queensPlaced = 9 ifTrue: [ ^ self ].

            "Backtracking : retire la reine si l'essai n'a pas fonctionné"
            square contents: nil.
            queensPlaced := queensPlaced - 1.

            "Retire la colonne de l'ensemble des colonnes utilisées"
            usedColumns remove: column.
        ].
    ].

]

{ #category : 'as yet unclassified' }
MyChessBoard >> queensPlacedOnColumns [
    ^ (self pieces select: [ :piece | piece isKindOf: MyQueen ]) collect: [ :queen |
        queen square name first asUppercase asciiValue - $A asciiValue + 1
    ]

]

{ #category : 'accessing' }
MyChessBoard >> select: aSquare [ 
	
	state select: aSquare
]

{ #category : 'accessing' }
MyChessBoard >> selected: aMyChessSquare [ 
	
	selected := aMyChessSquare
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
