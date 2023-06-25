!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'DA 6/25/2023 19:33:07'!
inputData
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

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

!ImportTest methodsFor: 'assertions' stamp: 'DA 6/25/2023 18:44:19'!
assertCustomer: aCustomer equals: anotherCustomer
	self assert: aCustomer firstName equals: anotherCustomer firstName.
	self assert: aCustomer lastName equals: anotherCustomer lastName.
	self assert: aCustomer identificationType equals: anotherCustomer identificationType.
	self assert: aCustomer identificationNumber equals: anotherCustomer identificationNumber.

	
	
	
	
	

	! !


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

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/25/2023 19:55:31'!
customerJuan
	|aCustomer|
	aCustomer := Customer new.
	aCustomer firstName: 'Juan'.
	aCustomer lastName: 'Perez'.
	aCustomer identificationNumber: '23-25666777-9'.
	aCustomer identificationType: 'C'.
	^aCustomer! !

!ImportTest methodsFor: 'mocking' stamp: 'DA 6/25/2023 19:55:38'!
customerPepe
	|aCustomer|
	aCustomer := Customer new.
	aCustomer firstName: 'Pepe'.
	aCustomer lastName: 'Sanchez'.
	aCustomer identificationNumber: '22333444'.
	aCustomer identificationType: 'D'.
	^aCustomer! !


!ImportTest methodsFor: 'tests' stamp: 'DA 6/25/2023 20:03:23'!
test01Import
	
	|customerPepe customerJuan addressMaipu addressSanMartin addressAlem |
	(CustomerImporter initializeFor: self inputData into: session) value.

	self assert: (session selectAllOfType: Customer) size equals: 2.

	customerPepe := (session
		select: [:customer | customer identificationType = 'D'] ofType: Customer) anyOne.
	self assertCustomer: customerPepe equals: self customerPepe.
	
	self assert: customerPepe numberOfAddress = 2.
	
	addressMaipu := customerPepe addressAt: 'Maipu'.
	self assertAddress: self addressMaipu equals: addressMaipu.
	
	addressSanMartin := customerPepe addressAt: 'San Martin'.
	self assertAddress: self addressSanMartin equals: addressSanMartin.
	
	customerJuan := (session 
		select: [:customer | customer identificationType = 'C'] ofType: Customer) anyOne.
	self assertCustomer: self customerJuan equals: customerJuan.
	
	self assert: customerJuan numberOfAddress = 1.
	
	addressAlem := customerJuan addressAt: 'Alem'.
	self assertAddress: self addressAlem equals: addressAlem.
	! !


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
	instanceVariableNames: 'session readStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'DA 6/25/2023 19:29:21'!
initializeFor: aStream into: aSession
	session := aSession.
	readStream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'DA 6/25/2023 19:34:37'!
value
	| inputStream  newCustomer line |
	inputStream := readStream.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.].

		line := inputStream nextLine. ].

	inputStream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'DA 6/25/2023 19:33:49'!
initializeFor: aStream into: aSession
	^self new initializeFor: aStream into: aSession! !


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
