!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testStoreObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:41:39'!
test01NewCartStartsEmpty
	
	self assert: (testStoreObjects createCart) isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:49:15'!
test02CannotAddBookThatNotBelongSite
	|cart|
	cart := testStoreObjects createCart.
	
	self 
		should: [cart addQuantity: 1 ofBook: testStoreObjects bookNotPublished.]
	 	raise: Error
		withExceptionDo: [:anError | 
			self assert: anError messageText equals: cart invalidBookErrorMessage.
			self assert: cart isEmpty. 
			]! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:43:11'!
test03AddingBookThatBelongSiteMakesCartNotEmpty
	|cart|
	cart := testStoreObjects createCart.
	
	cart addQuantity: 1 ofBook: testStoreObjects bookPublished.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:43:47'!
test04CartCanAddAmountOfSameBook
	|cart|
	cart := testStoreObjects createCart.
	
	cart addQuantity: 2 ofBook: testStoreObjects bookPublished.
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:44:15'!
test05CartCanAddPositiveAmountOfSameBook
	|cart|
	cart := testStoreObjects createCart.
	self 
		should: [cart addQuantity: -1 ofBook: testStoreObjects bookPublished.]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cart onlyCanAddPositiveQuantityErrorMessage.
			self assert: cart isEmpty]! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:44:52'!
test06CartCanRememberNumberOfBooksAdded
	|cart |
	cart := testStoreObjects createCart.
	
	cart addQuantity: 2 ofBook: testStoreObjects bookPublished .
	self assert: 2 equals: (cart amountAddedOf: testStoreObjects bookPublished). ! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:45:23'!
test07CartCanCheckIfHasAddedABook
	|cart|
	cart := testStoreObjects createCart.
	
	cart addQuantity: 2 ofBook: testStoreObjects bookPublished.
	self assert: (cart contains: testStoreObjects bookPublished). ! !

!CartTest methodsFor: 'tests' stamp: 'DA 6/9/2023 16:45:51'!
test08CartCanAddIntegerAmountOfBooks
	|cart| 
	cart := testStoreObjects createCart.
	self 
		should: [cart addQuantity: 1.1 ofBook: testStoreObjects bookPublished]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: cart onlyCanAddIntegerQuantityErrorMessage.
			self assert: cart isEmpty]! !


!CartTest methodsFor: 'setUp' stamp: 'DA 6/9/2023 16:41:21'!
setUp
	testStoreObjects := StoreTestObjects new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testStoreObjects debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 18:02:39'!
test01CannotCheckoutAnEmptyCart
	|cart salesBook|
	
	cart := testStoreObjects createCart.
	salesBook := OrderedCollection new.
	
	self 
		should: [Cashier checkout: cart
				charging: testStoreObjects notExpiredCreditCard
				through: self
				on: testStoreObjects today
				registerIn: salesBook.]  
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cashier emptyCartErrorMessage.
			self assert: salesBook isEmpty.
			]
	! !

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 18:02:46'!
test02SuccesfullCheckoutCartWithOneProduct
	|cart salesBook cashier |
	cart := testStoreObjects createCart.
	cart addQuantity: 1 ofBook: testStoreObjects bookPublished.
	salesBook := OrderedCollection new.
	
	cashier := Cashier checkout: cart 
					charging: testStoreObjects notExpiredCreditCard 
					through: self
					on: testStoreObjects today
					registerIn: salesBook.
	
	self assert: cashier checkout = 10.  
	self assert: salesBook size = 1.
	self assert: salesBook first = cashier checkout.! !

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 17:38:39'!
test03SuccesfullCheckoutCartWithProducts
	|cart salesBook cashier |
	cart := testStoreObjects createCart.	
	cart addQuantity: 2 ofBook: testStoreObjects bookPublished.
	cart addQuantity: 1 ofBook: testStoreObjects otherBookPublished.
	
	salesBook := OrderedCollection new.
	
	cashier := Cashier checkout: cart 
						charging: testStoreObjects notExpiredCreditCard 
						through: self
						on: testStoreObjects today
						registerIn: salesBook.
	
	self assert: cashier checkout = 40.  
	self assert: salesBook first = cashier checkout. ! !

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 17:40:16'!
test04CheckoutFailWhenCreditCardIsExpired
	|cart salesBook|
	
	cart := testStoreObjects createCart.
	cart addQuantity: 2 ofBook: testStoreObjects bookPublished.
	salesBook := OrderedCollection new.

	self 
		should: [Cashier checkout: cart 
				charging: testStoreObjects expiredCreditCard 
				through: self
				on: testStoreObjects today
				registerIn: salesBook.]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cashier expiredCreditCardErrorMessage.
			self assert: salesBook isEmpty]! !

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 17:48:01'!
test05CheckoutFailWhenCreditCardWithEmptyBalance 
	
	| cart cashier salesBook |
	cart := testStoreObjects createCart.
	cart add: testStoreObjects bookPublished.
	salesBook := OrderedCollection new.
	debitBehavior := [:anAmount :aCreditCard | self error: Cashier creditCardWithoutBalanceErrorMessage].
	
	cashier := Cashier 
				checkout: cart  
				charging: testStoreObjects notExpiredCreditCard
				through: self 
				on: testStoreObjects today
				registerIn: salesBook.
				
	self should: [cashier checkout]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: Cashier creditCardWithoutBalanceErrorMessage.
			self assert: salesBook isEmpty
			]
	! !

!CashierTest methodsFor: 'tests' stamp: 'DA 6/9/2023 18:02:22'!
test06SucessfullSaleIfEverythingIsOk
	
	| cart cashier salesBook debitedAmount debitedCreditCard total creditCard |
	cart:= testStoreObjects createCart.
	cart add: testStoreObjects bookPublished.
	salesBook := OrderedCollection new.
	creditCard :=  testStoreObjects notExpiredCreditCard.
	
	cashier := Cashier 
				checkout: cart  
				charging: creditCard
				through:  self
				on: testStoreObjects today
				registerIn: salesBook.
	
	debitBehavior := [:anAmount :aCreditCard|
				debitedAmount := anAmount.
				debitedCreditCard := aCreditCard].
	
	total := cashier checkout.
				
	self assert: debitedCreditCard equals: creditCard.
	self assert: debitedAmount = total.
	! !


!CashierTest methodsFor: 'setUp' stamp: 'DA 6/9/2023 17:30:16'!
setUp
	testStoreObjects := StoreTestObjects new. 
	debitBehavior := [:anAmount :aCreditCard].! !


!CashierTest methodsFor: 'merchant processor test' stamp: 'DA 6/9/2023 17:29:48'!
debit: anAmount from: aCreditCard
	^ debitBehavior value: anAmount value: aCreditCard. ! !


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


!Cart methodsFor: 'adding' stamp: 'DA 6/9/2023 15:48:01'!
add: aBook
	self addQuantity: 1 ofBook: aBook. ! !

!Cart methodsFor: 'adding' stamp: 'DA 6/8/2023 18:36:39'!
addQuantity: anAmount ofBook: aBook 
	self assertValidQuantity: anAmount.
	self assertValidBook: aBook. 
	items add: aBook withOccurrences: anAmount.! !


!Cart methodsFor: 'assertions' stamp: 'DA 6/8/2023 19:59:20'!
assertValidBook: aBook
	(catalog includesKey: aBook) ifFalse: [self error: self invalidBookErrorMessage].
	! !

!Cart methodsFor: 'assertions' stamp: 'DA 6/9/2023 15:46:58'!
assertValidQuantity: anAmount
	(anAmount isInteger) ifFalse: [self error: self onlyCanAddIntegerQuantityErrorMessage].
	(anAmount strictlyPositive ) ifFalse: [self error: self onlyCanAddPositiveQuantityErrorMessage].
	! !


!Cart methodsFor: 'initialize' stamp: 'DA 6/8/2023 18:00:45'!
initializeWith: aCatalog 
	catalog := aCatalog.
	items := Bag new. ! !


!Cart methodsFor: 'checkout' stamp: 'DA 6/9/2023 15:43:07'!
total
	^ items sum: [:anItem | catalog at: anItem].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'DA 6/6/2023 20:15:52'!
with: aCatalog
	^self new initializeWith: aCatalog! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialize' stamp: 'DA 6/9/2023 17:36:23'!
initializeCheckout: aCart charging: aCreditCard through: aMerchantProcessor registerIn: aSalesBook 
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'checkout' stamp: 'DA 6/9/2023 17:34:45'!
checkout
	| total |
	total := cart total.
	merchantProcessor debit: total from: creditCard. 
	salesBook add: total.
	^ total
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'DA 6/9/2023 17:35:51'!
checkout: aCart charging: aCreditCard through: aMerchantProcessor on: aDate registerIn: aSalesBook 
	(aCart isEmpty) ifTrue: [self error: self emptyCartErrorMessage].
	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self expiredCreditCardErrorMessage].
	^self new initializeCheckout: aCart charging: aCreditCard through: aMerchantProcessor registerIn: aSalesBook ! !


!Cashier class methodsFor: 'error messages' stamp: 'DA 6/9/2023 17:49:54'!
creditCardFraudErrorMessage
	^ 'Credit card fraud'! !

!Cashier class methodsFor: 'error messages' stamp: 'DA 6/9/2023 17:45:57'!
creditCardWithoutBalanceErrorMessage
	^ 'Credit card has no credit available'! !

!Cashier class methodsFor: 'error messages' stamp: 'DA 6/9/2023 17:34:34'!
emptyCartErrorMessage
	^ 'Cannot checkout an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'DA 6/9/2023 17:34:26'!
expiredCreditCardErrorMessage
	^ 'Invalid credit card'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DA 6/9/2023 16:04:45'!
initializeExpiringOn: aMonthOfYear 
	expiration := aMonthOfYear.! !


!CreditCard methodsFor: 'comparing' stamp: 'DA 6/9/2023 17:01:39'!
isExpiredOn: aDate
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'class initialization' stamp: 'DA 6/9/2023 16:17:32'!
expiringOn: aMonthOfYear
	^self new initializeExpiringOn: aMonthOfYear! !


!classDefinition: #StoreTestObjects category: 'TusLibros'!
Object subclass: #StoreTestObjects
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjects methodsFor: 'credit card generator' stamp: 'DA 6/9/2023 17:01:48'!
expiredCreditCard
	^ CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjects methodsFor: 'credit card generator' stamp: 'DA 6/9/2023 17:02:19'!
notExpiredCreditCard
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjects methodsFor: 'initialize' stamp: 'DA 6/9/2023 16:28:50'!
initialize 
	today := DateAndTime now.! !


!StoreTestObjects methodsFor: 'cart generator' stamp: 'DA 6/9/2023 16:35:22'!
createCart
	^ Cart with: self defaultCatalog ! !


!StoreTestObjects methodsFor: 'catalog generator' stamp: 'DA 6/9/2023 16:48:24'!
defaultCatalog
	^ Dictionary with: self bookPublished -> 10 with: self otherBookPublished ->20.! !


!StoreTestObjects methodsFor: 'date' stamp: 'DA 6/9/2023 16:29:00'!
today
	^ today! !


!StoreTestObjects methodsFor: 'book generator' stamp: 'DA 6/9/2023 16:22:49'!
bookNotPublished
	^'A book that is not published'! !

!StoreTestObjects methodsFor: 'book generator' stamp: 'DA 6/9/2023 16:23:13'!
bookPublished
	^'A book that is published'! !

!StoreTestObjects methodsFor: 'book generator' stamp: 'DA 6/9/2023 16:26:52'!
otherBookPublished
	^'Other book that is published'! !
