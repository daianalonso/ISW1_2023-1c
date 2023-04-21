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


!classDefinition: #NodoStack category: 'Stack-Exercise'!
Object subclass: #NodoStack
	instanceVariableNames: 'next element'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NodoStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 19:18:02'!
element
	^element! !

!NodoStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 19:21:42'!
newElement: anElement next: nodo
	next := nodo.
	element := anElement ! !

!NodoStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 19:18:37'!
next
	^next! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'pila estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/20/2023 21:23:45'!
initialize
	pila := OrderedCollection new ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/20/2023 21:29:22'!
isEmpty
	^pila isEmpty! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 14:57:54'!
pop
	(pila isEmpty) 
		ifTrue: [ ^ self error: self class stackEmptyErrorDescription ]
		ifFalse: [^ pila removeFirst ].! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/20/2023 21:51:38'!
push: anElement
	^pila addFirst: anElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/20/2023 21:33:45'!
size
	^pila size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'jflo 4/21/2023 14:58:10'!
top
	(pila isEmpty ) 
		ifTrue: [ ^self error: self class stackEmptyErrorDescription ] 
		ifFalse: [ ^pila at:1 ] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !



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
