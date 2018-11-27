Class {
	#name : #MccCommentExamples,
	#superclass : #Object,
	#category : 'Moose-Camel-Comments-Examples-Examples'
}

{ #category : #'examples - comment' }
MccCommentExamples >> classCommentOnClassWithComment [
	<gtExample>
	| aClassComment |
	
	aClassComment := MccClassComment of: MccClassWithComment.

	self assert: (aClassComment isKindOf: MccClassComment).
	self assert: aClassComment commentClass equals: MccClassWithComment.
	self assert: aClassComment asString equals: MccClassWithComment comment.
	
	^ aClassComment
]

{ #category : #'examples - comment' }
MccCommentExamples >> classCommentOnClassWithCommentOfTwoSentences [
	<gtExample>
	| aClassComment |

	aClassComment := MccClassComment of: MccClassWithCommentOfTwoSentences.

	self assert: (aClassComment isKindOf: MccClassComment).
	self assert: aClassComment commentClass equals: MccClassWithCommentOfTwoSentences.
	self assert: aClassComment asString equals: MccClassWithCommentOfTwoSentences comment.
	self assert: aClassComment sentences size equals: 2.
	self assert: aClassComment sentences first asString equals: 'I am a class with a comment'.
	self assert: aClassComment sentences second asString equals: 'It consists of two sentenses'.

	^ aClassComment
]

{ #category : #'examples - comment' }
MccCommentExamples >> classCommentOnClassWithoutComment [
	<gtExample>
	| aClassComment |

	aClassComment := MccClassComment of: MccClassWithoutComment.

	self assert: (aClassComment isKindOf: MccEmptyComment).
	self assert: aClassComment artefact equals: MccClassWithoutComment.
	self assert: aClassComment asString equals: ''.
	self assert: aClassComment references equals: #().
	
	^ aClassComment
]

{ #category : #'examples - comment' }
MccCommentExamples >> methodCommentOnMethodWithComment [
	<gtExample>
	| aMethodComment |
	
	aMethodComment := MccMethodComment of: MccClassWithComment >> #methodWithComment.

	self assert: (aMethodComment isKindOf: MccMethodComment).
	self assert: aMethodComment method equals: MccClassWithComment >> #methodWithComment.
	self assert: aMethodComment asString equals: (MccClassWithComment >> #methodWithComment) comment.
	
	^ aMethodComment
]

{ #category : #'examples - comment' }
MccCommentExamples >> methodCommentOnMethodWithoutComment [
	<gtExample>
	| aMethodComment |

	aMethodComment := MccMethodComment of: MccClassWithoutComment >> #methodWithoutComment.

	self assert: (aMethodComment isKindOf: MccEmptyComment).
	self assert: aMethodComment artefact equals: MccClassWithoutComment >> #methodWithoutComment.
	self assert: aMethodComment asString equals: ''.
	self assert: aMethodComment references equals: #().
	
	^ aMethodComment
]

{ #category : #'examples - comment' }
MccCommentExamples >> textCommentOnNumberDescription [
	<gtExample>
	| aText aTextComment |
	
	aText := 'Number holds the most general methods for dealing with numbers.'.
	
	aTextComment := MccTextComment of: aText.
	self assert: (aTextComment isKindOf: MccTextComment).
	self assert: aTextComment text equals: aText.
	self assert: aTextComment asString equals: aText.

	^ aTextComment
]