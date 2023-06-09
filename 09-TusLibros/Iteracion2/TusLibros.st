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

!CartTest methodsFor: 'tests' stamp: 'DA 6/8/2023 18:21:40'!
test02CannotAddBookThatNotBelongSite
	|cart emptyCatalog|
	emptyCatalog := Array new. 
	cart := Cart with: emptyCatalog.
	
	self 
		should: [cart addQuantity: 1 ofBook: self bookNotPublished.]
	 	raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: cart invalidBookErrorMessage.
			self assert: cart isEmpty. 
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

!CartTest methodsFor: 'tests' stamp: 'DA 6/8/2023 18:27:10'!
test08CartCanAddIntegerAmountOfBooks
	|cart catalog|
	catalog := Array with: self bookPublished. 
	cart := Cart with: catalog.
	self 
		should: [cart addQuantity: 1.1 ofBook: self bookPublished.]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cart onlyCanAddIntegerQuantityErrorMessage.]! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 19:44:08'!
aValidCreditCard
	^ 'a valid credit card'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 20:22:11'!
anInvalidCreditCard
	^ 'an invalid credit card'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 19:43:32'!
bookPublished
	^ 'a valid book'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 19:43:50'!
otherBookPublished
	^ 'an Other valid book'! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 20:47:11'!
test01CannotCheckoutAnEmptyCart
	"salesBook registrando las ventas, un cajero por cada venta
	asercion de mensaje de error con chequeo de invariante"
	|cart cashier|
	
	cart := Cart with: Array new. 
	cashier := Cashier new.
	
	self 
		should: [cashier checkout: cart withCard: self aValidCreditCard]  
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cashier emptyCartErrorMessage.
			]
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 21:12:25'!
test02SuccesfullCheckoutCartWithOneProduct
	"checkout: cart charging cc on: date registeringOn: salesbook initializer of cashier, mensaje checkout "
	|cart cashier priceList|
	
	priceList := Dictionary new.
	priceList add: self bookPublished -> 10.
	
	cart := Cart with: priceList.
	cart addQuantity: 1 ofBook: self bookPublished.
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart withCard: self aValidCreditCard) = 10.  
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 20:13:17'!
test03SuccesfullCheckoutCartWithProducts
	|cart cashier priceList|
	
	priceList := Dictionary new.
	priceList add: self bookPublished -> 10.
	priceList add: self otherBookPublished -> 20.
	
	cart := Cart with: priceList.
	cart addQuantity: 2 ofBook: self bookPublished.
	cart addQuantity: 1 ofBook: self otherBookPublished.
	
	cashier := Cashier new.
	
	self assert: (cashier checkout: cart withCard: self aValidCreditCard) = 40.  ! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 20:43:39'!
test04CheckoutFailWhenCreditCardIsExpired
	"se le deberia proveer el aniomes al cajero para poder saber si la tarjeta expiró."
	|cart cashier priceList|
	
	priceList := Dictionary new.
	priceList add: self bookPublished -> 10.
	
	cart := Cart with: priceList.
	cart addQuantity: 2 ofBook: self bookPublished.
	
	cashier := Cashier new.
	
	self 
		should: [cashier checkout: cart withCard: self anInvalidCreditCard]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cashier invalidCreditCardErrorMessage.]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 21:05:02'!
test05CheckoutFailWhenCreditCardWithEmptyBalance 
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 21:04:41'!
test06CheckoutFailWhenCreditCardFraud
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'DA 6/8/2023 21:08:02'!
test07SucessfullSaleIfEverythingIsOk
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'items catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'testing' stamp: 'DA 6/6/2023 20:39:51'!
amountAddedOf: aBook
	^ items occurrencesOf: aBook! !

!Cart methodsFor: 'testing' stamp: 'DA 6/6/2023 20:42:02'!
contains: aBook
	^ items includes: aBook! !

!Cart methodsFor: 'testing' stamp: 'DA 6/6/2023 20:18:28'!
isEmpty
	^items isEmpty! !


!Cart methodsFor: 'error messages' stamp: 'DA 6/6/2023 20:12:52'!
invalidBookErrorMessage
	^ 'Book not belongs to site'! !

!Cart methodsFor: 'error messages' stamp: 'DA 6/8/2023 18:24:11'!
onlyCanAddIntegerQuantityErrorMessage
	^'Amount only can be a integer'! !

!Cart methodsFor: 'error messages' stamp: 'DA 6/6/2023 20:33:41'!
onlyCanAddPositiveQuantityErrorMessage
	^'Cant add zero or negative amount of books'! !


!Cart methodsFor: 'adding' stamp: 'DA 6/8/2023 18:36:39'!
addQuantity: anAmount ofBook: aBook 
	self assertValidQuantity: anAmount.
	self assertValidBook: aBook. 
	items add: aBook withOccurrences: anAmount.! !


!Cart methodsFor: 'assertions' stamp: 'DA 6/8/2023 19:59:20'!
assertValidBook: aBook
	(catalog includesKey: aBook) ifFalse: [self error: self invalidBookErrorMessage].
	! !

!Cart methodsFor: 'assertions' stamp: 'DA 6/8/2023 18:36:46'!
assertValidQuantity: anAmount
	(anAmount isKindOf: Integer) ifFalse: [self error: self onlyCanAddIntegerQuantityErrorMessage].
	(anAmount < 1) ifTrue: [self error: self onlyCanAddPositiveQuantityErrorMessage].
	! !


!Cart methodsFor: 'initialize' stamp: 'DA 6/8/2023 18:00:45'!
initializeWith: aCatalog 
	catalog := aCatalog.
	items := Bag new. ! !


!Cart methodsFor: 'accessing' stamp: 'DA 6/8/2023 20:06:27'!
priceList
	^ catalog ! !

!Cart methodsFor: 'accessing' stamp: 'DA 6/8/2023 20:08:52'!
shoppingList
	^items asOrderedCollection ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'DA 6/6/2023 20:15:52'!
with: aCatalog
	^self new initializeWith: aCatalog! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'category-name' stamp: 'DA 6/8/2023 20:23:19'!
checkout: aCart withCard: aCreditCard
	|priceList shoppingList|
	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage].
	(aCreditCard = 'an invalid credit card') ifTrue: [self error: self invalidCreditCardErrorMessage].
	priceList := aCart priceList.
	shoppingList := aCart shoppingList.
	^ shoppingList inject: 0 into: [:total :anItem | total + priceList at: anItem].  
	! !


!Cashier methodsFor: 'error handling' stamp: 'DA 6/8/2023 19:49:18'!
emptyCartErrorMessage
	^ 'Cannot checkout an empty cart'! !

!Cashier methodsFor: 'error handling' stamp: 'DA 6/8/2023 20:20:15'!
invalidCreditCardErrorMessage
	^ 'Invalid credit card'! !
