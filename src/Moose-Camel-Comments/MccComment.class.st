"
I represent a comment of some code artefact.



//TODO

I use information from MccClasses.

I know  comment, class of the comment.
My aim is to collect maximum information from a comment. 
I can collect potential reference classes from comment.
I am composed of sentences.
I collect actual classes referenced my commentClass and potential classes from comment text.
Once I have both the information, I can compare the inconsistency.

    Instance Variables
	comment:		<Object>
	commentClass:		<Object>
	prefixOfPackage:		<Object>
	referencedClasses:		<Object>
	sentences:		<Object>.
			

Reimplement the following in Pharo to split text in sentences

import re
alphabets= ""([A-Za-z])""
prefixes = ""(Mr|St|Mrs|Ms|Dr)[.]""
suffixes = ""(Inc|Ltd|Jr|Sr|Co)""
starters = ""(Mr|Mrs|Ms|Dr|He\s|She\s|It\s|They\s|Their\s|Our\s|We\s|But\s|However\s|That\s|This\s|Wherever)""
acronyms = ""([A-Z][.][A-Z][.](?:[A-Z][.])?)""
websites = ""[.](com|net|org|io|gov)""

def split_into_sentences(text):
    text = "" "" + text + ""  ""
    text = text.replace(""\n"","" "")
    text = re.sub(prefixes,""\\1<prd>"",text)
    text = re.sub(websites,""<prd>\\1"",text)
    if ""Ph.D"" in text: text = text.replace(""Ph.D."",""Ph<prd>D<prd>"")
    text = re.sub(""\s"" + alphabets + ""[.] "","" \\1<prd> "",text)
    text = re.sub(acronyms+"" ""+starters,""\\1<stop> \\2"",text)
    text = re.sub(alphabets + ""[.]"" + alphabets + ""[.]"" + alphabets + ""[.]"",""\\1<prd>\\2<prd>\\3<prd>"",text)
    text = re.sub(alphabets + ""[.]"" + alphabets + ""[.]"",""\\1<prd>\\2<prd>"",text)
    text = re.sub("" ""+suffixes+""[.] ""+starters,"" \\1<stop> \\2"",text)
    text = re.sub("" ""+suffixes+""[.]"","" \\1<prd>"",text)
    text = re.sub("" "" + alphabets + ""[.]"","" \\1<prd>"",text)
    if ""”"" in text: text = text.replace("".”"",""”."")
    if ""\"""" in text: text = text.replace("".\"""",""\""."")
    if ""!"" in text: text = text.replace(""!\"""",""\""!"")
    if ""?"" in text: text = text.replace(""?\"""",""\""?"")
    text = text.replace(""."","".<stop>"")
    text = text.replace(""?"",""?<stop>"")
    text = text.replace(""!"",""!<stop>"")
    text = text.replace(""<prd>"",""."")
    sentences = text.split(""<stop>"")
    sentences = sentences[:-1]
    sentences = [s.strip() for s in sentences]
    return sentences
"
Class {
	#name : #MccComment,
	#superclass : #Object,
	#instVars : [
		'artefact',
		'sentences',
		'words'
	],
	#category : 'Moose-Camel-Comments-Model - Comment'
}

{ #category : #'instance creation' }
MccComment class >> fromClass: aClass [
	^ self of: aClass
]

{ #category : #testing }
MccComment class >> hasComment: anObject [
	"Return true of a given code artefact has a comment"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #'instance creation' }
MccComment class >> new [
	self error: 'Use one of: instead'
]

{ #category : #'instance creation' }
MccComment class >> of: anObject [
	<return: #MccComment>

	^ (self hasComment: anObject)
		ifTrue: [ self basicNew initialize initializeWith: anObject ]
		ifFalse: [ MccEmptyComment of: anObject ]
]

{ #category : #accessing }
MccComment >> artefact [
	"Return a code artefact whose comment I represent"
	<return: #Object>

	^ artefact
]

{ #category : #accessing }
MccComment >> artefact: anObject [
	self
		assert: [ anObject isNotNil ]
		description: [ 'Code artefact must not be nil' ].

	artefact := anObject
]

{ #category : #converting }
MccComment >> asString [
	"Return a string representation of the comment"
	<return: #String>
	
	^ self subclassResponsibility
]

{ #category : #private }
MccComment >> computeSentences [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>

	^ Array streamContents: [ :aStream | 
		| aCommentString |
		(aCommentString := self asString)
			splitOn: String cr
			indicesDo: [ :start :end |
				| aString |
				aString := aCommentString copyFrom: start to: end.
				aString ifNotEmpty: [
					aStream nextPut: (MccSentence new string: aString interval: (start to: end)) ] ] ]
]

{ #category : #private }
MccComment >> computeWords [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccWord>

	^ (self sentences flatCollect: #words) reject: #isEmpty
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorMccCommentReferencesIn: aComposite inContext: aGTInspector [
	"Override extension from Object to break infinite recursion"
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorReferencesIn: aComposite [
	<gtInspectorPresentationOrder: 2>
	
	^ aComposite fastList
		title: 'References' translated;
		display: [ self references ];
		when: [  self references isNotEmpty ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorSentencesIn: aComposite [
	<gtInspectorPresentationOrder: 3>
	
	^ aComposite fastList
		title: 'Sentences' translated;
		display: [ self sentences ]
]

{ #category : #'gt-inspector-extension' }
MccComment >> gtInspectorTextIn: aComposite [
	<gtInspectorPresentationOrder: 1>

	^ aComposite text
			title: 'Text' translated;
			display: [ self asString ]
]

{ #category : #initialization }
MccComment >> initializeWith: anObject [
	"Initialize this comment with a given code artefact that depends on the comment type
	For example class comment must be initialized with a Class while method comments with a compiled method"

	self artefact: anObject
]

{ #category : #testing }
MccComment >> isEmpty [
	<return: #Boolean>
	
	^ self asString isEmpty
]

{ #category : #printing }
MccComment >> printOn: aStream [
	aStream
		nextPutAll: 'Comment of ';
		nextPut: $(;
		nextPutAll: self artefact asString;
		nextPut: $)
]

{ #category : #references }
MccComment >> references [
	"Return a collection of references from this comment in a default environment"
	<return: #Collection of: #MccReference>

	^ self referencesIn: MccSystemEnvironment default
]

{ #category : #references }
MccComment >> referencesIn: aMccEnvironment [
	"Return a collection of references from this comment within a given environment"
	<return: #Collection of: #MccReference>

	^ self subclassResponsibility
]

{ #category : #accessing }
MccComment >> sentences [
	"Split and return a collection of sentences of this comment"
	<return: #Collection of: #MccSentence>

	^ sentences ifNil: [ sentences := self computeSentences ]
]

{ #category : #accessing }
MccComment >> stopwords [
	"Split and return a collection of stopwords (with possible duplications) in this comment"
	<return: #Collection of: #MccWord>

	^ self words select: #isStopword
]

{ #category : #accessing }
MccComment >> words [
	"Split and return a collection of words in this comment"
	<return: #Collection of: #MccSentence>

	^ words ifNil: [ words := self computeWords ]
]