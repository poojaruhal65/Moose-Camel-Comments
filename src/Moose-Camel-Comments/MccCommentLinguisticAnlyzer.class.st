"
I represent goal/intent of the class.

I know responsibilityVerbs that shows  the responsibility of a class. I know the system subjects also.

Subject to have desire is always a class and in Pharo we represent using ""I"".

    Instance Variables
	goal:		<Object>

"
Class {
	#name : #MccCommentLinguisticAnlyzer,
	#superclass : #Object,
	#instVars : [
		'goal'
	],
	#category : #'Moose-Camel-Comments-Model'
}

{ #category : #'as yet unclassified' }
MccCommentLinguisticAnlyzer >> deprecationWords [
	"words for potential warnings of deprecated methods"
	
	^	{'deprecated'.'deprecation'.'deprecate'.'deprecating'} 
]

{ #category : #'as yet unclassified' }
MccCommentLinguisticAnlyzer >> negativeSentiments [
"words that show negative sentiments in the sentence"
 	^	{'abnormal'.'abnormality'.'accident'.'always'.'anomaly'.'aren’t'.'arent'.'atypical'.'bad'.'break'.'bug'.'can’t'.'cant' .'change' .'complication'.'conflict'.'couldn’t' .'couldnt' .'crash' .'defect' .'defective' .'deficient' .'defunct' .'delay' .'deviate' .'diappear' .'didn’t'.'didnt' .'difficulty'.'dilemma' .'disable'.'discontinued' .'doesn’t' .'doesnt' .'don’t' .'dont' .'duplicate' .'empty'.'error'.'every' .'exception' .'exhaust' .'expose' .'fade'.'fail' .'fault' .'faulty' .'flaw'.'forget' .'freeze' .'glitch'.'hadn’t' .'hadnt' .'hasn’t' .'hasnt' .'haven’t' .'havent' .'illegal' .'imperfect' .'inaccurate' .'inadequate' .'inadvertently' .'incapable' .'incompatible'.'incomplete'.'incorrect' .'incorrectly' .'ine↵ective' .'inecient'.'infinite'.'insecure' .'insists' .'instead' .'interrupt' .'invalid' .'irregular' .'irregularity' .'isn’t' .'isnt'.'issue' .'just' .'lag' .'leak' .'long' .'lose' .'lot' .'malfunction'.'mightn’t' .'mightnt' .'miscalculate' .'miscalculation' .'misprint'.'mistake'.'mustn’t'.'mustnt'.'negative'.'never'.'nil'.'no'.'none'.'not'.'null'.'obsolete'.'obstacle'.'oddity'.'only'.'opposite'.'out'.'oversight'.'poor'.'predicament'.'problem'.'reject'.'setback'.'shouldn’t'.'shouldnt'.'skip'.'slow'.'stall'.'stop'.'strange'.'stuck'.'symptom'.'too'.'trouble'.'unable'.'unacceptable'.'uncommon'.'undefined'.'unintended'.'unintentionally'.'unprotected'.'unreachable'.'unresponsive'.'unsatisfactory'.'unsecure'.'unstable'.'untypical'.'unusable'.'unusual'.'vanish'.'void'.'warning'.'wasn’t'.'wasnt'.'weren’t'.'werent'.'won’t'.'wont'.'worry'.'wouldn’t'.'wouldnt'.'wrong'.'wrongly'.'zero'} 
]

{ #category : #'as yet unclassified' }
MccCommentLinguisticAnlyzer >> responsibilityVerbs [
	"a verb that expresses the class’s desire/goal"
	
	^	{'aim' .'anticipate'.'aspire' .'assume' .'attempt' .'believe' .'can' .'demand' .'desire' .'expect' .'expectation' .'goal' .'hope'.'imagine'.'intend'.'intent'.'intention'.'interested'.'like'.'must'.'need'.'objective'.'ought'.'picture'.'plan'.'prefer'.'presume'.'purpose'.'require'.'represent'.'responsibile'.'seek'.'should'.'strive'.'suppose'.'think'.'try'.'want'.'wish'} 
]

{ #category : #'as yet unclassified' }
MccCommentLinguisticAnlyzer >> systemSubjects [
"potential subjects of a sentence"

	^	{'algorithm'.'application'.'array'.'boolean'.'button'.'character'.'class'.'client'.'code'.'column'.'compiler'.'console'.'Transcript'.'data'.'database'.'environment'.'float'.'function'.'instance'.'integer'.'interface'.'it'.'item'.'library'.'loop'.'method'.'message'.'object'.'output'.'package'.'page'.'platform'.'environment'.'process'.'program'.'result'.'row'.'script'.'server'.'set'.'string'.'structure'.'system'.'table'.'thread'.'type'.'value'.'variable'.'view'.'class'.'variable'.'package'.'namespace'.'exception'.'module'.'function'.'bookmark'.'enum'.'UI'.'panel'.'icon'.'box'.'window'.'tooltip'.'notification'.'options'.'shortcut'.'slider'.'color'.'menu'.'dialog'.'taskbar'.'wizard' }
]

{ #category : #'as yet unclassified' }
MccCommentLinguisticAnlyzer >> warningWords [
	"words for potential warnings in the comment"
	
	^	{'warning'.'warn'.'danger'.'dangerous'.'do not'.'don''t'.'shouldn''t'.'should not'.'mustn''t'.'must not'.'cannot'.'can''t'.'impossible'.'bad'.'must only'.'should only'.'can only'.'avoid'.'Note'.'Error'.'Necessary'.'No longer needed'.'Not needed'.'!'.'Please'.'Can only'.'yet to do'.'Should not'.'Be warned'.'Don’t use'.'Do not use'.'Never'.'Cause'.'Need'.'Must not'.'Must never'.'Hack'.'Annoying'.'Bug'.'Corrupt'.'Destroy'.'Mess up'.'Not a good idea'.'Normal users do not need to use /know this'.'Nor should'.'Hack'.'Risk'.'Harm'.'Error'.'Exception'.'Failure'.'Mistake'.'Needs'.'Serious'.'do not use'.'Not functional'.'Testing'.'Doesn’t work'.'Not working'.'Note'} 
]