!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:12:31'!
bookNotPublished
	^'A book that is not published'! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:03:06'!
bookPublished
	^'A book that is published'! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:22:58'!
test01NewCartStartsEmpty
	|emptyCatalog|
	emptyCatalog := Array new.
	
	self assert: (Cart with: emptyCatalog) isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:30:59'!
test02CannotAddBookThatNotBelongSite
	|cart emptyCatalog|
	emptyCatalog := Array new. 
	cart := Cart with: emptyCatalog.
	
	self 
		should: [cart addQuantity: 1 ofBook: self bookNotPublished.]
	 	raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: cart invalidBookErrorMessage.
			]! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:31:08'!
test03AddingBookThatBelongSiteMakesCartNotEmpty
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	
	cart addQuantity: 1 ofBook: self bookPublished.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:31:14'!
test04CartCanAddAmountOfSameBook
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	
	cart addQuantity: 2 ofBook: self bookPublished.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:34:45'!
test05CartCanAddPositiveAmountOfSameBook
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	self 
		should: [cart addQuantity: -1 ofBook: self bookPublished.]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cart onlyCanAddPositiveQuantityErrorMessage.]! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:40:16'!
test06CartCanRememberNumberOfBooksAdded
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	
	cart addQuantity: 2 ofBook: self bookPublished.
	self assert: 2 equals: (cart amountAddedOf: self bookPublished). ! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/6/2023 20:41:24'!
test07CartCanCheckIfHasAddedABook
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	
	cart addQuantity: 2 ofBook: self bookPublished.
	self assert: (cart contains: self bookPublished ). ! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:30:23'!
add: aBook
	items add: aBook.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:34:19'!
addQuantity: anAmount ofBook: aBook 
	(catalog includes: aBook) ifFalse: [self error: self invalidBookErrorMessage].
	(anAmount < 1) ifTrue: [self error: self onlyCanAddPositiveQuantityErrorMessage].
	anAmount timesRepeat: [self add: aBook].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:39:51'!
amountAddedOf: aBook
	^ items occurrencesOf: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:42:02'!
contains: aBook
	^ items includes: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:18:28'!
isEmpty
	^items isEmpty! !

!Cart methodsFor: 'as yet unclassified' stamp: 'DA 6/6/2023 20:33:41'!
onlyCanAddPositiveQuantityErrorMessage
	^'Cant add zero or negative amount of books'! !


!Cart methodsFor: 'error handling' stamp: 'DA 6/6/2023 20:12:52'!
invalidBookErrorMessage
	^ 'Book not belongs to site'! !


!Cart methodsFor: 'initialize' stamp: 'DA 6/6/2023 20:19:29'!
initializeWith: aCatalog 
	catalog := aCatalog.
	items := OrderedCollection new. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'DA 6/6/2023 20:15:52'!
with: aCatalog
	^self new initializeWith: aCatalog! !
