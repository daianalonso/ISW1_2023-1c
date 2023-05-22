!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/17/2023 18:34:29'!
test01BalanceOfPortfolioWithoutAccountsIsZero
	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 18:48:07'!
test02AddingOneAccountTakeTheirBalance
	|account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	self assert: (account balance) equals: ((Portfolio with: account) balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 19:11:41'!
test03AddingMoreThanOneAccountTakeSumOfTheirBalance

	| anAccount otherAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	otherAccount := ReceptiveAccount new.
	Deposit register: 200 on: otherAccount.
		
	self assert: (anAccount balance + otherAccount balance) equals: ((Portfolio with: anAccount) add: otherAccount) balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 18:52:00'!
test04AddingEmptyPortfolioHaveBalanceCero

	|portfolio|
	
	portfolio := Portfolio new.

	self assert: 0 equals: ((Portfolio with: portfolio)balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 19:04:40'!
test05AddingPortfolioWithAccountHaveBalanceOfThatAccount

	|portfolio account|
	
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio := Portfolio with: (Portfolio with: account).
	
	self assert: (account balance) equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 16:50:21'!
test06PortfolioWithoutAccountsHasNoRegisteredTransactions
	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 18:52:50'!
test07PortfolioHasRegisteredTheirAccountTransactions
	|account transaction|
	account := ReceptiveAccount new.
	transaction := Deposit for: 100.
	
	account register: transaction.
	
	self assert: ((Portfolio with: account) hasRegistered: transaction). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 19:12:07'!
test08PortfolioCanLookTheirTransactionsRecursively
	|portfolio simpleAccount portfolioAccount depositTransaction withdrawTransaction|
	
	simpleAccount := ReceptiveAccount new.
	depositTransaction := Deposit for: 100.
	simpleAccount register: depositTransaction.
	
	portfolioAccount := ReceptiveAccount new.
	withdrawTransaction:= Withdraw for: 50.
	portfolioAccount register: withdrawTransaction. 
	
	portfolio := (Portfolio with: simpleAccount) add: (Portfolio with: portfolioAccount).
	
	self assert: 2 equals: (portfolio transactions size).
	self assert: (portfolio hasRegistered: depositTransaction).
	self assert: (portfolio hasRegistered: withdrawTransaction). ! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 18:56:32'!
test09PortfolioCantAddAccountIfWasAddedBefore
	|account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
	should: [ portfolio add: account ]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: Portfolio cantAddErrorDescription equals: anError messageText.
		self assert: 1 equals: portfolio accountsSize.
		self assert: (portfolio hasAccount: account)]! !

!PortfolioTest methodsFor: 'tests' stamp: 'DA 5/21/2023 21:18:47'!
test10PortfolioCantAddPorfolioIfSharesSomeAccount
	|account portfolio childPortfolio otherPortfolio |
	account := ReceptiveAccount new.
	
	childPortfolio := Portfolio with: account.
	portfolio := Portfolio with: childPortfolio.
	otherPortfolio := Portfolio with: account.
	
	self 
	should: [childPortfolio add: otherPortfolio]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: Portfolio cantAddErrorDescription equals: anError messageText.
		self assert: 1 equals: childPortfolio accountsSize.
		self deny: (childPortfolio hasAccount: otherPortfolio).
		self assert: (childPortfolio hasAccount: account)]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #Account category: 'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'DA 5/19/2023 20:21:29'!
hasAccount: aReceptiveAccount
	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'DA 5/19/2023 20:21:50'!
hasRegistered: aAccountTransaction
	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'DA 5/19/2023 20:23:06'!
transactions
	self subclassResponsibility ! !


!Account methodsFor: 'adding' stamp: 'DA 5/19/2023 20:54:29'!
registerParent: aPortfolio
	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'DA 5/19/2023 20:21:15'!
balance
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'DA 5/19/2023 20:27:05'!
balance
	^ accounts inject: 0 into:[:acum :account | acum + account balance]. ! !


!Portfolio methodsFor: 'adding' stamp: 'DA 5/21/2023 18:30:11'!
add: anAccount 
	self assertCantAdd: anAccount.
	accounts add: anAccount.
	anAccount registerParent: self. ! !

!Portfolio methodsFor: 'adding' stamp: 'DA 5/19/2023 20:55:28'!
registerParent: anAccountParent
	parents add: anAccountParent ! !


!Portfolio methodsFor: 'initialize' stamp: 'DA 5/19/2023 20:34:07'!
initialize
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'DA 5/19/2023 20:28:41'!
transactions
	|transactions|
	transactions := OrderedCollection new.
	accounts do: [:account | transactions add: (account transactions)].
	^transactions 
! !


!Portfolio methodsFor: 'testing' stamp: 'DA 5/17/2023 18:44:50'!
accountsSize
	^ accounts size! !

!Portfolio methodsFor: 'testing' stamp: 'DA 5/21/2023 18:22:41'!
hasAccount: aAccount
	^ (accounts includes: aAccount) or:
	(accounts anySatisfy: [:account | account hasAccount: aAccount]).! !

!Portfolio methodsFor: 'testing' stamp: 'DA 5/19/2023 20:27:38'!
hasRegistered: aTransaction
	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ].! !


!Portfolio methodsFor: 'assertions' stamp: 'DA 5/21/2023 19:26:03'!
assertCantAdd: anAccount 
	parents do: [:aParent | aParent assertCantAdd: anAccount].
	((self = anAccount) or: [self hasAccount: anAccount])  ifTrue: [^self error: Portfolio cantAddErrorDescription].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'DA 5/21/2023 17:03:28'!
cantAddErrorDescription
 	^ 'Error al agregar la cuenta al portfolio: ya incluye alguna de sus cuentas'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'DA 5/21/2023 19:03:08'!
with: anAccount
	^ self new add: anAccount! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'DA 5/21/2023 18:27:19'!
initialize
	parents := OrderedCollection new.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'DA 5/17/2023 18:39:42'!
balance
	^transactions inject: 0 into:[:acum :aTransaction | aTransaction affectTransaction: acum].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'DA 5/21/2023 18:39:12'!
hasAccount: anAccount
	^false ! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding' stamp: 'DA 5/21/2023 19:34:16'!
registerParent: aParent
	parents add: aParent.
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'DA 5/17/2023 18:35:25'!
affectTransaction: aTransaction
 	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'DA 5/17/2023 18:35:25'!
affectTransaction: actualBalance
	^ actualBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'DA 5/17/2023 18:35:25'!
affectTransaction: actualBalance
	^ actualBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
