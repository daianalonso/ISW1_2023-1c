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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 19:17:30'!
findSentencesWithFirst: letters at: anStack
	| element |
	
	"  "
	( anStack isEmpty ) ifTrue: OOStack new.
	
	element := anStack top.
	
	(element findString: letters startingAt: 1) 
		ifTrue: [ ^( self findSentencesWithFirst: letters at: anStack pop ) push: element ]	
		
	"tests
	stack vacio de devuelve 0
	stack con 10 elementos de los cuales 2 coinciden devuelve 2
	pusheo el prefijo en stack vacio y devuelvo 1
	pusho 10 veces y devuelvo 10
	sentencefinder... es case sensitive"! !
