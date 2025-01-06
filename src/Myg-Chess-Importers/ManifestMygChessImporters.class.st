"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestMygChessImporters',
	#superclass : 'PackageManifest',
	#category : 'Myg-Chess-Importers-Manifest',
	#package : 'Myg-Chess-Importers',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestMygChessImporters class >> ruleSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'Myg-Chess-Importers')) #'2025-01-06T01:15:05.391+01:00') )
]
