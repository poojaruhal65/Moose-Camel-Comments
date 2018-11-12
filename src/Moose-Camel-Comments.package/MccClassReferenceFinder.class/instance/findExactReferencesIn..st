searching
findExactReferencesIn: aSentence
	"Find and return exact class references"
	<return: #Collection of: #MccReference>

	^ Array streamContents: [ :aStream | 
		aSentence words do: [ :eachWord |
			self environment
				classNamed: eachWord asSymbol
				ifFound: [ :aClass | aStream nextPut: (MccClassReference new
					interval: eachWord interval;
					artefact: aClass) ]
				ifNone: [  ] ] ]