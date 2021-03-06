"
I use the whole smalltalk system as an environment.
Using me is expensive
"
Class {
	#name : #MccSystemEnvironment,
	#superclass : #MccEnvironment,
	#category : 'Moose-Camel-Comments-Model - Environment'
}

{ #category : #'instance creation' }
MccSystemEnvironment class >> default [
	^ self new
]

{ #category : #navigation }
MccSystemEnvironment >> allClasses [
	"Return all classes in this environment"
	<return: #Collection of: #Class>

	^ Smalltalk image allClasses
]
