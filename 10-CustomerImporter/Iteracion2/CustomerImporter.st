!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'DA 6/22/2023 20:32:23'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'DA 6/22/2023 20:34:20'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'assertions' stamp: 'DA 6/25/2023 19:56:42'!
assertAddress: anAddress equals: expectedAddress
	self assert: anAddress streetName equals: expectedAddress streetName.
	self assert: anAddress streetNumber equals: expectedAddress streetNumber.
	self assert: anAddress town equals: expectedAddress town.
	self assert: anAddress zipCode equals: expectedAddress zipCode.
	self assert: anAddress province equals: expectedAddress province.! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/28/2023 22:36:33'!
assertCustomer: aCustomer equals: anotherCustomer
	self assertCustomerData: aCustomer equals: anotherCustomer.
	self assert: aCustomer numberOfAddress equals: anotherCustomer numberOfAddress.

	
	
	
	
	

	! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/26/2023 21:49:24'!
assertCustomerData: aCustomer equals: anotherCustomer
	self assert: aCustomer firstName equals: anotherCustomer firstName.
	self assert: aCustomer lastName equals: anotherCustomer lastName.
	self assert: aCustomer identificationType equals: anotherCustomer identificationType.
	self assert: aCustomer identificationNumber equals: anotherCustomer identificationNumber.

	
	
	
	
	

	! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/26/2023 18:27:07'!
assertJuanPerezIsImportedCorrectly

	|customerJuan |
	
	customerJuan := self selectCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	self assertCustomer: self customerJuan equals: customerJuan.
	
	self assertAddress: self addressAlem equals: (customerJuan addressAt: 'Alem')! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/26/2023 21:49:59'!
assertJuanPerezNotHaveAddress

	|customerJuan |
	
	customerJuan := self selectCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	self assertCustomerData: self customerJuan equals: customerJuan.
	
	self assert: customerJuan numberOfAddress = 0.! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/28/2023 19:53:29'!
assertNumberOfAddressesIsZero
	^ self assert: 0 equals: (session objectsOfType: Address) size! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/28/2023 19:48:32'!
assertNumberOfCustomersIs: customersNumber

	^ self assert: (session selectAllOfType: Customer) size equals: customersNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/26/2023 18:27:17'!
assertPepeSanchezIsImportedCorrectly

	|customerPepe |
	
	customerPepe := self selectCustomerWithIDType: 'D' andIDNumber: '22333444'.
	
	self assertCustomer: customerPepe equals: self customerPepe.
	
	self assertAddress: self addressMaipu equals: (customerPepe addressAt: 'Maipu').
	
	self assertAddress: self addressSanMartin equals: (customerPepe addressAt: 'San Martin').! !

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/26/2023 18:09:48'!
assertRightNumberOfCustomersImported

	^ self assert: (session selectAllOfType: Customer) size equals: 2! !


!ImportTest methodsFor: 'mocking' stamp: 'DA 6/25/2023 20:03:10'!
addressAlem
	|anAddress|
	anAddress := Address new.
	anAddress streetName: 'Alem'.
	anAddress streetNumber: 1122.
	anAddress town: 'CABA'.
	anAddress zipCode: 1001.
	anAddress province: 'CABA'.
	^ anAddress ! !

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/25/2023 20:01:49'!
addressMaipu
	|anAddress|
	anAddress := Address new.
	anAddress streetName: 'Maipu'.
	anAddress streetNumber: 888.
	anAddress town: 'Florida'.
	anAddress zipCode: 1122.
	anAddress province: 'Buenos Aires'.
	^ anAddress ! !

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/25/2023 20:02:59'!
addressSanMartin 
	|anAddress|
	anAddress := Address new.
	anAddress streetName: 'San Martin'.
	anAddress streetNumber: 3322.
	anAddress town: 'Olivos'.
	anAddress zipCode: 1636.
	anAddress province: 'BsAs'.
	^ anAddress ! !

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/26/2023 18:28:01'!
customerJuan
	|aCustomer|
	aCustomer := Customer new.
	aCustomer firstName: 'Juan'.
	aCustomer lastName: 'Perez'.
	aCustomer identificationNumber: '23-25666777-9'.
	aCustomer identificationType: 'C'.
	aCustomer addAddress: self addressAlem.
	^aCustomer! !

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/26/2023 18:28:24'!
customerPepe
	|aCustomer|
	aCustomer := Customer new.
	aCustomer firstName: 'Pepe'.
	aCustomer lastName: 'Sanchez'.
	aCustomer identificationNumber: '22333444'.
	aCustomer identificationType: 'D'.
	aCustomer addAddress: self addressMaipu.
	aCustomer addAddress: self addressSanMartin.
	^aCustomer! !


!ImportTest methodsFor: 'tests' stamp: 'DA 6/26/2023 21:25:14'!
test01CorrectImportOnValidStream
	
	self importCustomers: self validData into: session.

	self assertRightNumberOfCustomersImported.
	
	self assertPepeSanchezIsImportedCorrectly.
	
	self assertJuanPerezIsImportedCorrectly.
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:00:46'!
test02CannotImportEmptyFile

	self should: [
			self importCustomers: self emptyData into: session.
		]
	 	raise:  Error  - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CustomerImporter cannotImportEmptyStreamErrorMessage.
			self assertNumberOfCustomersIs: 0
		]
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:00:54'!
test03AllAddressFieldsMustBeDefined

	self should: [
			self importCustomers: self lessParameterAddressData into: session.
		]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CustomerImporter wrongLineArgumentsNumberErrorMessage.
			self assertPepeSanchezIsImportedCorrectly.
			self assertJuanPerezNotHaveAddress.
			self assertNumberOfCustomersIs: 2
		]
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:01:00'!
test04CannotTakeMoreFieldsInAddressData

	self should: [
			self importCustomers: self moreParameterAddressData into: session.
		]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CustomerImporter wrongLineArgumentsNumberErrorMessage.
			self assertPepeSanchezIsImportedCorrectly.
			self assertJuanPerezNotHaveAddress.
			self assertNumberOfCustomersIs: 2
		]
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:01:08'!
test05AllCustomerFieldsMustBeDefined

	self should: [
			self importCustomers: self lessParameterCustomerData into: session.
		]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CustomerImporter wrongLineArgumentsNumberErrorMessage.
			self assertNumberOfCustomersIs: 0.
			self assertNumberOfAddressesIsZero.
		]
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:01:16'!
test06CannotTakeMoreFieldsInCustomerData

	self should: [
			self importCustomers: self moreParameterCustomerData into: session.
		]
		raise:  Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			anError messageText = CustomerImporter wrongLineArgumentsNumberErrorMessage.
			self assertNumberOfCustomersIs: 0.
			self assertNumberOfAddressesIsZero.
		]
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:03:34'!
test07AddressMustBeAssociatedToCustomer

	self should: [
		self importCustomers: self onlyRecordAddressData into: session.		
	] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [: anError |		
		self assert: anError messageText equals: CustomerImporter addressNotVinculateCustomerErrorMessage.
		self assertNumberOfCustomersIs: 0. 
		self assertNumberOfAddressesIsZero.		
	]! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:03:43'!
test08AddressRecordTypeMustBeA

	self should: [
		self importCustomers: self invalidRecordTypeAddressData into: session.		
	] 
	raise: Error 
	withExceptionDo: [: anError |
		self assert: CustomerImporter notSupportedRecordTypeErrorMessage equals: anError messageText.
		self assertNumberOfCustomersIs: 1. 
		self assertNumberOfAddressesIsZero.
	].
! !

!ImportTest methodsFor: 'tests' stamp: 'DA 6/28/2023 23:03:48'!
test09CustomerRecordTypeMustBeC

	self should: [
		self importCustomers:  self invalidRecordTypeCustomerData into: session.		
	] 
	raise: Error 
	withExceptionDo: [: anError |
		self assert: CustomerImporter notSupportedRecordTypeErrorMessage equals: anError messageText.
		self assertNumberOfCustomersIs: 0. 
		self assertNumberOfAddressesIsZero.
	].
! !


!ImportTest methodsFor: 'customers' stamp: 'DA 6/26/2023 18:35:14'!
importCustomers: aReadStream into: aSession

	(CustomerImporter initializeFor: aReadStream into: aSession) value.

	! !

!ImportTest methodsFor: 'customers' stamp: 'DA 6/26/2023 18:13:42'!
selectCustomerWithIDType: anIDType andIDNumber: anIDNumber 

	^ (session
		select: [:customer | customer identificationType = anIDType and: customer identificationNumber = anIDNumber] ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'DA 6/26/2023 20:33:36'!
emptyData
	^ ReadStream on: ''.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:42:36'!
invalidRecordTypeAddressData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:42:42'!
invalidRecordTypeCustomerData
	^ ReadStream on: 'CC,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:51:23'!
lessParameterAddressData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,CABA'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:56:44'!
lessParameterCustomerData
	^ ReadStream on: 'C,Pepe,Sanchez,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:51:46'!
moreParameterAddressData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA,Argentina'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 22:52:03'!
moreParameterCustomerData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444,M
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/28/2023 23:12:21'!
onlyRecordAddressData
	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'.! !

!ImportTest methodsFor: 'test data' stamp: 'DA 6/26/2023 21:25:14'!
validData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'DA 6/22/2023 20:01:01'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'DA 6/22/2023 20:01:01'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'DA 6/22/2023 20:01:01'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'DA 6/22/2023 20:01:01'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'DA 6/22/2023 20:01:01'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'DA 6/22/2023 20:01:01'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'town' stamp: 'DA 6/22/2023 20:01:01'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'DA 6/22/2023 20:01:01'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'DA 6/22/2023 20:01:01'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'DA 6/22/2023 20:01:00'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'comparison' stamp: 'DA 6/25/2023 19:13:44'!
hasStreetName: aStreetName
	^ streetName = aStreetName ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'DA 6/22/2023 20:01:02'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'DA 6/25/2023 18:53:01'!
addressAt: aStreetName
	^ addresses 
		detect: [ :anAddress | anAddress hasStreetName: aStreetName ]
		ifNone: [ self error: self class invalidStreetNameDescriptionError]! !

!Customer methodsFor: 'addresses' stamp: 'DA 6/22/2023 20:01:02'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'DA 6/25/2023 19:45:56'!
numberOfAddress

	^ addresses size! !


!Customer methodsFor: 'name' stamp: 'DA 6/22/2023 20:01:02'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'DA 6/22/2023 20:01:02'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'DA 6/22/2023 20:01:02'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'DA 6/22/2023 20:01:02'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'DA 6/22/2023 20:01:02'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'DA 6/22/2023 20:01:02'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'DA 6/22/2023 20:01:02'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'DA 6/22/2023 20:01:02'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'DA 6/22/2023 20:01:02'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'error messages' stamp: 'DA 6/25/2023 18:55:44'!
invalidStreetNameDescriptionError
	^ 'Received an invalid streetname'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'DA 6/25/2023 19:29:21'!
initializeFor: aStream into: aSession
	session := aSession.
	readStream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/28/2023 22:49:00'!
assertEmptyStream

	(readStream isEmpty) ifTrue: [^self error: self class cannotImportEmptyStreamErrorMessage]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/28/2023 23:02:08'!
assertValidAddressFormat

	(record size = 6) ifFalse: [^self error: self class wrongLineArgumentsNumberErrorMessage .].
	(newCustomer isNil) ifTrue: [^ self error: self class addressNotVinculateCustomerErrorMessage. ]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/28/2023 22:47:42'!
assertValidCustomerFormat

	(record size = 5) ifFalse: [^self error: self class wrongLineArgumentsNumberErrorMessage]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 20:22:12'!
hasLinesLeft

	line := readStream nextLine. 
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 21:59:37'!
importAddress

	| newAddress|
	self assertValidAddressFormat.
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/28/2023 20:05:43'!
importCustomer

	self assertValidCustomerFormat.
	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identificationType: record fourth.
	newCustomer identificationNumber: record fifth.
	session persist: newCustomer. ! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 21:18:44'!
importRecord

	self isCustomerRecord ifTrue: [^self importCustomer.].
	self isAddressRecord ifTrue: [^self importAddress.].
	self error: self class notSupportedRecordTypeErrorMessage.
! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 21:27:44'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 21:27:13'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 20:14:43'!
readRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/26/2023 20:40:34'!
value
	self assertEmptyStream.
	[ self hasLinesLeft ] whileTrue: [
		self readRecord.
		self importRecord.].

	readStream close
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'DA 6/25/2023 19:33:49'!
initializeFor: aStream into: aSession
	^self new initializeFor: aStream into: aSession! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'DA 6/28/2023 23:02:08'!
addressNotVinculateCustomerErrorMessage
	^'Address not vinculated to any client'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'DA 6/26/2023 20:39:47'!
cannotImportEmptyStreamErrorMessage
	^ 'Cannot import empty data'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'DA 6/26/2023 21:12:36'!
notSupportedRecordTypeErrorMessage
	^'Only support records of type A or C'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'DA 6/26/2023 20:50:09'!
wrongLineArgumentsNumberErrorMessage
	^'Incorrect number of arguments in this line'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'DA 6/22/2023 20:01:03'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'DA 6/22/2023 20:01:03'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'DA 6/22/2023 20:01:03'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'DA 6/22/2023 20:01:03'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'DA 6/22/2023 20:01:03'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'DA 6/22/2023 20:01:03'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'DA 6/22/2023 20:01:03'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'DA 6/22/2023 20:01:03'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'DA 6/22/2023 20:01:03'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'DA 6/22/2023 20:01:03'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'DA 6/22/2023 20:01:03'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'DA 6/22/2023 20:01:03'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'DA 6/22/2023 20:01:03'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
