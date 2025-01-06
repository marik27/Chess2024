"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMygChessCore',
	#superclass : 'PackageManifest',
	#category : 'Myg-Chess-Core-Manifest',
	#package : 'Myg-Chess-Core',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMygChessCore class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#MyChessBoard #solveNQueensFromRow:boardSize:currentSolution:solutions: #false)) #'2025-01-04T19:31:44.172+01:00') )
]
