!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:20:22'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	
	customerBook := CustomerBook new.
	self
		assertIfExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'] 
		isLowerThan: 50 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:21:05'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	self 
		assertIfExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney.] 
		isLowerThan:  100 * millisecond.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:47:27'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	self 
		executing: [customerBook addCustomerNamed: ''.]
		shouldRaise: Error
		asserting:  [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:54:38'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		executing: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		shouldRaise: NotFound 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 18:38:27'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	self 
		assertIf: customerBook
		countActiveCustomersIs: 0
		countSuspendedCustomersIs: 1.	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 18:42:49'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self 
		assertIf: customerBook 
	 	countActiveCustomersIs: 0
	 	countSuspendedCustomersIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:54:51'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self
		executing: [customerBook suspendCustomerNamed: 'George Harrison'.]
		shouldRaise: CantSuspend 
		asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'DA 4/12/2023 17:54:55'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	self 
		executing: [customerBook suspendCustomerNamed: johnLennon.]
	 	shouldRaise: CantSuspend 
	 	asserting: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'DA 4/12/2023 18:37:11'!
assertIf:customerBook countActiveCustomersIs: aNumberOfActiveCustomers countSuspendedCustomersIs: aNumberOfSuspendedCustomers  
	
	self assert: aNumberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers + aNumberOfSuspendedCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'DA 4/12/2023 17:21:15'!
assertIfExecutionTimeOf: aBlockToMeasure isLowerThan: anAmountOfMilliseconds
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < anAmountOfMilliseconds ! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'DA 4/12/2023 17:47:08'!
executing: aBlockThatShouldFail shouldRaise: exception asserting: aVerificationBlock
	[aBlockThatShouldFail value. 
		self fail.]
	on: exception
	do: aVerificationBlock ! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'DA 4/12/2023 19:57:06'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'DA 4/12/2023 19:20:14'!
removeCustomerNamed: aName 
 
	self 
		removeIf: active
		containsCustomer: aName
		ifFoundDo: [^ aName].
	
	self 
		removeIf: suspended
		containsCustomer: aName
		ifFoundDo: [^ aName].
	  
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'DA 4/12/2023 19:21:25'!
removeIf: aCollectionCategory containsCustomer: customerName ifFoundDo: aBlockToExecute
 	
	(aCollectionCategory includes: customerName) 			ifTrue: [
				aCollectionCategory remove: customerName.
				^ aBlockToExecute value.
			] ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
