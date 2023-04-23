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
