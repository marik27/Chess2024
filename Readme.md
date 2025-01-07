# PROJET CHESS

## Instructions d’installation:

Pour installer, le projet ouvrer une nouvelle image pharo12, ensuite :
1. ouvrir le playground et executez la commande suivante:
```
Metacello new
    repository: 'github://marik27/Chess2024:main';
    baseline: 'MygChess';
    onConflictUseLoaded;
    load.

```
2. Ensuite, allez dans ***Browse*** -> ***Git Repository Browser*** , ensuite cliquez sur ***Chess2024***, et faite un pull.

3. Et pour executer le projet, allez dans le playground, executer la commande suivante:
```
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```
Une fois la commande executer, vous pouvez interagir avec le plateau.

## Instructions d’usages:

Le ***play*** du plateau, fonctionne avec une certaine latence "KNullSquare", en effet pour effectuer un nouveau déplacement il faut  faire un double click pour qu'une piece bouge.

Quand au pion, il est conseillé de tester manuellement, les différentes implementations du kata associé.



## Kata : Implements 9 queens problems

J'ai travaillé sur la branche `Ouassila` en y ajoutant des changements liés à mon kata
> Dans mon kata, il était question de résoudre le problème des 9 reines dans le jeu d'echecs,
Pourquoi le Backtracking pour le problème des 9 reines ?
Le problème des 9 reines consiste à placer 9 reines sur un échiquier 9×9 de manière à ce qu'aucune ne puisse en attaquer une autre, c'est-à-dire :

    Pas deux reines sur la même ligne.
    Pas deux reines sur la même colonne.
    Pas deux reines sur la même diagonale.

Le backtracking est un choix naturel pour ce problème parce que :

    Exploration Arborescente : Le backtracking explore toutes les configurations possibles de manière systématique.
    Élagage des branches non valides : Dès qu'une configuration ne respecte pas les règles, elle est abandonnée immédiatement.
    Solution Complète : Il garantit de trouver toutes les solutions possibles si elles existent.

2. Principe de l'Algorithme Backtracking

L'algorithme de Backtracking est une approche récursive qui consiste à :

    Placer une reine dans une ligne.
    Vérifier si le placement est sûr (aucune attaque).
    Si le placement est valide : Passer à la ligne suivante et répéter.
    Si le placement échoue : Revenir en arrière (Backtrack) à la ligne précédente et essayer la colonne suivante.
 Étapes du Backtracking :

    Ligne par Ligne : On place les reines une par une, ligne après ligne.
    Vérification des Conflits : Chaque placement vérifie les lignes, colonnes et diagonales.
    Récursion : Une fois qu'une reine est placée correctement, on passe à la ligne suivante.
    Retour Arrière : Si un placement ne permet pas de placer toutes les reines, on revient au placement précédent et on essaie une autre colonne.

3. Implémentation Étape par Étape
3.1 Fonction Principale : solveNQueens:

solveNQueens: size
"Résout le problème des N reines pour un échiquier de taille donnée."

    | board solutions |
    board := Array new: size.
    solutions := OrderedCollection new.

    "Démarre le placement depuis la première ligne"
    self placeQueenOnRow: 1 board: board size: size solutions: solutions.

    "Afficher la première solution trouvée"
    solutions isEmpty ifFalse: [
        self displaySolution: solutions first.
        Transcript show: 'Solution trouvée et affichée.'; cr.
    ] ifTrue: [
        Transcript show: 'Aucune solution trouvée.'; cr.
    ].

Explication :

    On initialise un tableau board pour suivre la position des reines.
    On utilise une liste solutions pour stocker les solutions valides.
    La méthode placeQueenOnRow: est appelée pour commencer à placer les reines à partir de la première ligne.

3.2 Fonction de Placement Récursif : placeQueenOnRow:

placeQueenOnRow: row board: board size: size solutions: solutions
"Place une reine sur une ligne spécifique et passe à la suivante."

    row > size ifTrue: [
        "Toutes les reines sont placées, ajouter une solution valide"
        solutions add: board copy.
        ^self.
    ].

    1 to: size do: [:col |
        (self isSafeAtRow: row column: col board: board) ifTrue: [
            board at: row put: col.
            self placeQueenOnRow: row + 1 board: board size: size solutions: solutions.
            board at: row put: nil.
        ]
    ].

Explication :

    Pour chaque colonne dans la ligne actuelle (1 to: size), on vérifie si le placement est sûr (isSafeAtRow:).
    Si oui, on place la reine et on passe à la ligne suivante.
    Si aucune colonne n'est valide, on revient à la ligne précédente et on essaie une autre colonne.

3.3 Fonction de Validation : isSafeAtRow:column:

isSafeAtRow: row column: col board: board
"Vérifie si une reine peut être placée en toute sécurité."

    1 to: row - 1 do: [:r |
        | c |
        c := board at: r.
        c ifNotNil: [
            (c = col or: [(c - col) abs = (r - row) abs]) ifTrue: [^false].
        ].
    ].
    ^true

Explication :

    On vérifie chaque reine déjà placée.
    On vérifie :
        Même colonne (c = col)
        Même diagonale ((c - col) abs = (r - row) abs)
    Si une condition est remplie, le placement n'est pas sûr.
    
Pourquoi le Backtracking est-il Efficace Ici ?

Exploration Complète : Toutes les configurations possibles sont explorées de manière exhaustive.
Élagage Intelligent : Les configurations invalides sont détectées et abandonnées très tôt, ce qui économise du temps et des ressources.
Résultat Garanti : S'il existe une solution, elle sera trouvée.

Lancement du jeu avec les 9 reines, dans la méthode `initialize` j'ai rajouté
`self initializeWithSize: 9.
self solveNQueens: 9.`
pour lancer le tableau avec N=8 on a juste à changer 9 par 8.



## KATA :  FIX PAWN MOVES

branche: ouassila

Dans ce kata il fallait implementer 3 mouvements de pion:
- Le mouvement initial
- La captures en diagonales
- Et la prise en passant

##### TESTS

Nous avons écrit des tests pour les classes que nous avons implémentés:
Ainsi : `MyPawnTest`, `MyStandardMoveStateTest`, `MyInitialMoveStateTest`, `MyEnPassantStateTest` ont été créées pour tester les fonctionnalités mises en œuvre dans ce kata.

Pour cela, nous avons utilisé Dr.Test pour vérifier la couverture de nos tests. Au final, seules 6 méthodes des classes implémentées sont partiellement testées.

De plus, nous avons utilisé le debugger de pharo pour gérer les bugs qui arrivaient lors de l'executions des tests pour savoir.

=> Mutation tests :
Nous avons testé la qualité des classes de tests selon une perspective de tests mutants :

``` testCases :=  { UUIDPrimitivesTest }.
classesToMutate := { UUID. UUIDGenerator }.

analysis := MTAnalysis new
    testClasses: testCases;
    classesToMutate: classesToMutate.

analysis run.
analysis generalResult mutationScore.
alive := analysis generalResult aliveMutants.

analysis generalResult.
```    

>résultats:
MyEnPassantStateTest : 41 mutants, 37 killed, 4 alive , mutations score :90%.
MyInitialMoveStateTest: 129 mutants, 106 killed, 23 alive , mutations score :82%.
MyStandardMoveStateTest : 318 mutants, 240 killed, 78 alive , mutations score :75%.
MyPawnTest: 359 mutants, 243 killed, 116 alive , mutations score :67%.



##### Designs Decisions:

1. Le mouvement initial:

Initialement, nous avions implémenté les pions de manière à ce qu’ils soient positionnés sur une « file » codée en dur, ce qui causait des décalages si la taille du plateau changeait (Kata 9 Queens Puzzle).

Solution : On a  adopté le **State Pattern** pour permettre une gestion dynamique du comportement des pions sur le plateau. Dans ce cas, le  premier mouvement. Le pion commence dans un état initial: **InitialPawnState**, lui permettant de se déplacer d’une ou deux cases. Une fois déplacé, il passe à l’état **StandardPawnMoveState** où il ne peut effectuer que des mouvements d'une case.

2. La capture en diagonales:

Concernant la capture en diagonale, qui peut être effectuée sur un pion dans son état initial ou standard, nous avons décidé d’implémenter une méthode `diagonalPawnCaptures` directement dans la classe **MyPawn**, cette méthode calcule les cases diagonales pour le pion et	filtre celles qui contiennent une pièce de couleur opposée. Dans le ```targetsquareLegal``` , le mouvement vers la case de la capture est autorisé, et le mouvement est effectuer sur la case du pion capturé.

3. La prise en passant:


Pour la prise en Passant, on  créé un state **enPassantState** Ainsi, si le pion, dans son état initial, effectue un mouvement de 2 cases, il se retrouve dans l’état EnPassant. Après ce mouvement, il retourne à l’état standard.

De plus, on a implemente les pions pour qu'ils soient capable de savoir si il possède des voisins(droite ou gauche), grâce à la méthode `MyPawn << adjacentSquareTo`.

Le pion adverse, qui est dans un état standard, est capable de détecter si ses voisins sont :  des pions, adverses ( couleurs différentes) et dans un état EnPassant, grâce à la méthode  `MyStandardMoveState<< adjacentEnPassantPawnsFor:`,  
La méthode ```MyStandardMoveState<<captureEnPassantTo: aSquare for: aPawn ```
permet de  capturer  le pion dans un état ENPassant.

Les méthodes ```moveTo: aSquare for: aPawn``` : vérifie si le mouvement est une capture En Passant avec isEnPassantMove:Si oui, elles appellent ```captureEnPassantTo:```. Sinon, elles effectuent un déplacement standard avec ``` standardMoveTo:```et ```targetsquareLegal:aPawn```.


## Kata : Remove Nil Checks


Dans le cadre de ce  kata , nous avons refactoré le code pour éliminer les vérifications de valeur à nil, en adoptant des solutions basées sur le polymorphisme.

1. Comment transformer les vérifications de nil en polymorphisme ?

Une classe NullSquare a été introduite en tant qu'implémentation du design pattern Null Object. Elle représente les cases inexistantes ou invalides au lieu de renvoyer nil. Cette classe implemente les mêmes méthodes que MyChessSquare, mais avec un comportement spécifique : elle ne contient aucune pièce et ne permet pas de déplacement valide.

2. Quelle API devrions-nous concevoir ?

Les méthodes comme up, down, right, left sur une case doivent toujours renvoyer une instance valide de MyChessSquare ou de NullSquare. Les cases hors limites ou invalides doivent être gérées par des instances de NullSquare. L'API doit permettre d'accéder facilement aux cases voisines sans risquer de manipuler des valeurs nil.

3. Les tests peuvent-ils aider à réaliser cela avec moins de douleurs ?

Oui, des tests unitaires ont été écrits pour valider les comportements suivants :
Les méthodes comme up, down,left et right ne renvoient jamais nil, mais une instance de NullSquare.
Les déplacements hors limites retournent également une instance de NullSquare.


4. Un problème similaire se produit lorsque les pièces veulent se déplacer en dehors du plateau. Comment le corriger ?
Les cases hors limites sont maintenant remplacées par des instances de NullSquare.
Le roi et les autres pièces utilisent des méthodes qui renvoient toujours des cases valides, évitant ainsi les erreurs dues à des valeurs nil.

Difficultés rencontrées

Problème : Les méthodes directionnelles et les NullSquare

L’une des difficultés majeures était liée à la gestion des cases hors limites. Initialement, les vérifications de nil étaient présentes pour détecter les déplacements invalides, mais leur suppression a engendré des comportements inattendus :

- Avant:
```
MyKing >> basicTargetSquares [

    "The king can move one square on each direction including diagonals"
    ^ {
        square ifNotNil: #right.
        square up ifNotNil: #right.
        square ifNotNil: #up.
        square up ifNotNil: #left.
        square ifNotNil: #left.
        square left ifNotNil: #down.
        square ifNotNil: #down.
        square down ifNotNil: #right
    }
]
```
- Après
```
MyKing >> basicTargetSquares

    "The king can move one square on each direction including diagonals"

    ^ {
        (square right).
        (square up right).
        (square up).
        (square up left).
        (square left).
        (square down left).
        (square down).
        (square down right)
    }



```
- Les méthodes comme up, down, left et right continuaient à renvoyer des nil, même après l’introduction de la classe NullSquare.

- Les pièces, en particulier le roi, tentaient de se déplacer vers des NullSquare sans directive claire, provoquant des exceptions.

* Solution : Utilisation du polymorphisme avec NullSquare

Les méthodes directionnelles ont été réécrites pour renvoyer un objet NullSquare lorsqu'une case est invalide.
exemple:
```
MyChessSquare >> left

      | nextSquare |
    nextSquare := self + (-1 @ 0).
    ^ nextSquare isNullSquare ifTrue: [ NullSquare new ] ifFalse: [ nextSquare ]

```
Au lieu de
```
MyChessSquare >> right

    ^ self + (1@0)

```
