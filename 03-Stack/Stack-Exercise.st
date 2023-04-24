!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 20:35:13'!
test01NoSentenceFoundReturnEmpty
	| finder sentencesStack sentencesFounded |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'It is me, mario'.
	
	finder := SentenceFinderByPrefix with: 'Wint' on: sentencesStack.
	
	sentencesFounded := finder find.
	
	self assert: sentencesFounded isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 20:31:58'!
test02PrefixShouldNotEmpty
	| sentencesStack  |
	sentencesStack := OOStack new.
		
	self should: [SentenceFinderByPrefix with: '' on: sentencesStack] raise: Error withExceptionDo:  [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix emptyPrefixErrorDescription  ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 20:32:50'!
test03PrefixShouldNotIncludeSpaces
	| sentencesStack  |
	sentencesStack := OOStack new.
		
	self should: [SentenceFinderByPrefix with: 'Wint ' on: sentencesStack] raise: Error withExceptionDo:  [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix spaceInPrefixErrorDescription ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:36:33'!
test04EmptyStackReturnsEmpty
	| finder sentencesStack sentencesFounded |
	sentencesStack := OOStack new.
	
	
	finder := SentenceFinderByPrefix with: 'Wint' on: sentencesStack.
	
	sentencesFounded := finder find.
	
	self assert: sentencesStack isEmpty.
	self assert: sentencesFounded isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:36:43'!
test05StackIsPreserved
	| finder sentencesStack  |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'Algoritmo1'.
	sentencesStack push: 'Algoritmo2'.
	sentencesStack push: 'Algoritmo3'.
	sentencesStack push: 'Algoritmo4'.
	
	finder := SentenceFinderByPrefix with: 'Wint' on: sentencesStack.
	
	finder find.
	
	self assert: sentencesStack pop equals: 'Algoritmo4'.
	self assert: sentencesStack pop equals: 'Algoritmo3'.
	self assert: sentencesStack pop equals: 'Algoritmo2'.
	self assert: sentencesStack pop equals: 'Algoritmo1'.
	self assert: sentencesStack isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:43:09'!
test06PrefixMatchReturnsNotEmpty
	| finder sentencesStack  sentencesFound |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'Algoritmo1'.
	sentencesStack push: 'Algoritmo2'.
	sentencesStack push: 'Algoritmo3'.
	sentencesStack push: 'Algoritmo4'.
	
	finder := SentenceFinderByPrefix with: 'Algo' on: sentencesStack.
	
	sentencesFound := finder find.
	
	self assert: sentencesFound size = 4.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:43:28'!
test07NoPrefixMatchReturnsEmpty
	| finder sentencesStack  sentencesFound |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'Algoritmo1'.
	sentencesStack push: 'Algoritmo2'.
	sentencesStack push: 'Algoritmo3'.
	sentencesStack push: 'Algoritmo4'.
	
	finder := SentenceFinderByPrefix with: 'Orga' on: sentencesStack.
	
	sentencesFound := finder find.
	
	self assert: sentencesFound isEmpty 
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:37:14'!
test08FindIsCaseSensitive
	| finder sentencesStack  sentencesFound |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'Algoritmo1'.
	sentencesStack push: 'algoritmo2'.
	sentencesStack push: 'Algoritmo3'.
	sentencesStack push: 'algoritmo4'.
	
	finder := SentenceFinderByPrefix with: 'Algo' on: sentencesStack.
	
	sentencesFound := finder find.
	
	self assert: sentencesFound size = 2.
! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'jflo 4/23/2023 22:44:35'!
test09FindSentencesIncludesInOriginalStack
	| finder sentencesStack  sentencesFound |
	sentencesStack := OOStack new.
	
	sentencesStack push: 'Sistemas'.
	sentencesStack push: 'Algoritmo2'.
	sentencesStack push: 'Orga2'.
	sentencesStack push: 'Algoritmos3'.
	
	finder := SentenceFinderByPrefix with: 'Algo' on: sentencesStack.
	
	sentencesFound := finder find.
	
	self assert: sentencesFound size = 2.
	self assert: 'Algoritmos3' equals: (sentencesFound at: 1) .
	self assert: 'Algoritmo2' equals: (sentencesFound at: 2) .
! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'current'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:40:00'!
initialize
	current := OOStackEmptyElement new! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:40:44'!
isEmpty
	^current size isZero! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:47:10'!
pop
	|topElement|
	topElement := current top.
	current := current pop.
	^topElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:49:35'!
push: anElement
	current := OOStackWithElement put: anElement over: current ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:42:03'!
size
	^current size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:49:58'!
top
	^current top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'previous element size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:09:56'!
pop
 	self subclassResponsibility ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:11:26'!
size
 	self subclassResponsibility ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:11:17'!
top
 	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:12:15'!
pop 
	self error: OOStack stackEmptyErrorDescription ! !

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:11:55'!
size
	^0! !

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:12:23'!
top 
	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackWithElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackWithElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:46:15'!
pop
	^previous! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:46:15'!
put: anElement over: anotherElement
	element := anElement.
	previous := anotherElement ! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:46:15'!
size 
	^1 + previous size! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:24:47'!
top
	^element ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackWithElement class' category: 'Stack-Exercise'!
OOStackWithElement class
	instanceVariableNames: ''!

!OOStackWithElement class methodsFor: 'as yet unclassified' stamp: 'DA 4/21/2023 20:56:28'!
put: anElement over: anotherElement
	^self new put: anElement over: anotherElement ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'prefix stack auxiliaryStack foundSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'DA 4/23/2023 19:46:58'!
addIfStackTopBeginsWithPrefix
	|aSentence|
	aSentence :=stack pop.
	auxiliaryStack push: aSentence.
	(aSentence beginsWith: prefix) ifTrue: [foundSentences add: aSentence].! !

!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'DA 4/23/2023 18:41:33'!
findAllSentencesByPrefixIntoStack
	stack size timesRepeat:  [self addIfStackTopBeginsWithPrefix]! !

!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'DA 4/23/2023 19:47:41'!
restoreOriginalStack
	auxiliaryStack size timesRepeat: [stack push: auxiliaryStack pop].! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'DA 4/23/2023 18:50:50'!
find
	foundSentences := OrderedCollection new.
	self findAllSentencesByPrefixIntoStack.
	self restoreOriginalStack.
	^foundSentences! !


!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'DA 4/23/2023 18:55:59'!
initialize: aStack finding: aPrefix
	prefix:= aPrefix. 
	stack := aStack.
	auxiliaryStack :=OOStack new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'DA 4/23/2023 18:55:47'!
with: aPrefix on: aStack
	self assertNotEmpty: aPrefix.
	self assertWithNoSpaces: aPrefix.
	^self new initialize: aStack finding: aPrefix! !


!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'DA 4/23/2023 18:57:44'!
assertNotEmpty: aPrefix
	(aPrefix  isEmpty) ifTrue: [self error: self emptyPrefixErrorDescription].! !

!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'DA 4/23/2023 19:45:25'!
assertWithNoSpaces: aPrefix
	(aPrefix includesSubString: ' ') ifTrue: [self error: self spaceInPrefixErrorDescription]. ! !


!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'DA 4/23/2023 19:01:18'!
emptyPrefixErrorDescription
	^ 'El prefijo es vacío'! !

!SentenceFinderByPrefix class methodsFor: 'error messages' stamp: 'DA 4/23/2023 19:00:51'!
spaceInPrefixErrorDescription
	^ 'El prefijo contiene espacios'! !
