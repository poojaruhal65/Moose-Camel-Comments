"
Array streamContents: [ :aStream |
	| result string |
	
	string := 'ha

object := Object new.

asdadasdasd

object printString.
object.

asfafasfj' copyReplaceAll: String cr with: String cr, '.'.


	result := (MccSmalltalkInCommentParser new sea) parse: string.
	
	[ result isNotEmpty and: [ string isNotEmpty ] ] whileTrue: [
		aStream nextPut: (result first as: String).
		aStream nextPut: (result second).
		string := result third as: String.
		result := (MccSmalltalkInCommentParser new sea) parse: string.
	] ]
"
Class {
	#name : #MccSmalltalkInCommentParser,
	#superclass : #PP2PluggableNode,
	#classVars : [
		'assignments'
	],
	#category : #'Moose-Camel-Comments-Parser'
}

{ #category : #accessing }
MccSmalltalkInCommentParser class >> assignments [

	^ assignments
]

{ #category : #accessing }
MccSmalltalkInCommentParser class >> assignments: someAssignments [ 

	assignments := someAssignments 
]

{ #category : #parsing }
MccSmalltalkInCommentParser class >> parse: aString [
	| aStringToSplit theNodes adaptedString |

	assignments := OrderedCollection new.
	aString
		ifEmpty: [ ^ #() ].
		
		adaptedString := aString copyReplaceAll: '[[[' with: '   '.
		adaptedString := adaptedString copyReplaceAll: ']]]' with: '   '. 
		adaptedString := adaptedString copyReplaceAll: '```Smalltalk' with: '            '.
		adaptedString := adaptedString copyReplaceAll: '```' with: '   '.

	aStringToSplit := ({ Character cr . Character lf } includes: aString last)
		ifTrue: [ aString ]
		ifFalse: [
			aString, String cr ].	
		
	"if comment includes gtoolkit syntax"	
	"((aStringToSplit includesSubstring: '[[[') and: [ aStringToSplit includesSubstring:']]]' ])
		ifTrue: [ theNodes := Array streamContents: [ :aStream |
		aStringToSplit
			splitOn: '(\[\[\[|\]\]\])' asRegex
			indicesDo: [ :aStart :anEnd |
				| tokenToParse |
				
				tokenToParse := MccSmalltalkSnippetToken
					on: aString
					start: (aStart min: aString size) stop: (anEnd min: aString size).
								[ aStream nextPut: tokenToParse parse ]
					on: Error
					do: [ aStream nextPut: tokenToParse asTextToken ] ] ].].
	 
	""if comment includes markdown like code syntax""
	((aStringToSplit includesSubstring: '```') and: [aStringToSplit includesSubstring: '```Smalltalk'])
		ifTrue: [ theNodes := Array streamContents: [ :aStream |

		aStringToSplit
			splitOn: '(```Smalltalk)|(```)' asRegex
			indicesDo: [ :aStart :anEnd |
				| tokenToParse |
				
				tokenToParse := MccSmalltalkSnippetToken
					on: aString
					start: (aStart min: aString size) stop: (anEnd min: aString size).
								[ aStream nextPut: tokenToParse parse ]
					on: Error
					do: [ aStream nextPut: tokenToParse asTextToken ] ] ].]."
		
	"if comment doesn't include any special syntax"
	theNodes isNil ifTrue: [  
	theNodes := Array streamContents: [ :aStream |
		aStringToSplit
			splitOn: ('(\',String cr,'|\', String lf, ')[\s|\-]*(\',String cr,'|\', String lf, ')') asRegex
			indicesDo: [ :aStart :anEnd |
				| tokenToParse |
				
				"initial value"
				tokenToParse := MccSmalltalkSnippetToken
					on: adaptedString 
					start: (aStart min: aString size) stop: (anEnd min: aString size).
								[ aStream nextPut: tokenToParse parse ]
					on: Error
					do: [ aStream nextPut: tokenToParse asTextToken ] ] ] ].
		
	^ (theNodes size = 1)
		ifTrue: [ theNodes first ]
		ifFalse: [ (MccSmalltalkCompositeToken on: aString start: 1 stop: aString size) children: (theNodes) ]
]

{ #category : #visiting }
MccSmalltalkInCommentParser >> accept: aPP2ParserVisitor [
	^ self
]

{ #category : #accessing }
MccSmalltalkInCommentParser >> assignments [ 

	^ assignments
]

{ #category : #accessing }
MccSmalltalkInCommentParser >> assignments: someAssignments [ 

	assignments := someAssignments 
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> initialize [
	super initialize.

	self isNullable: true
]

{ #category : #'parsing - adaptable' }
MccSmalltalkInCommentParser >> parseOn: aPP2Context [
	^ strategy parseOn: aPP2Context
]

{ #category : #initialization }
MccSmalltalkInCommentParser >> resetStrategy [

	strategy := MccSmalltalkInCommentStrategy on: self.
	strategy visitor: MccSmalltalkInCommentVisitor new.
	strategy visitor assignments: assignments.
	strategy assignments: assignments.

]
