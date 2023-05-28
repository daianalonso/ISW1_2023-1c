!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
ReportTest subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 21:53:14'!
test01AccountWithoutTransactionsPrintBalanceZero
	|account summary | "zero"
	account := ReceptiveAccount new.
	summary := AccountSummary for: account.
	self assert: (OrderedCollection with: 'Balance = 0' )equals: summary report.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 21:53:21'!
test02AccountWithDepositPrintDepositAndBalance
	|account summary expectedReport| "only"
	account := ReceptiveAccount new.
	Deposit register: 50 on: account. 
	summary := AccountSummary for: account.

	expectedReport:=  OrderedCollection with: 'Depósito por 50' with: 'Balance = 50'.
	self assert: expectedReport equals: summary report.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 21:53:29'!
test03AccountWithWithdrawPrintWithdrawAndBalance
	|account summary expectedReport| "only"
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account. 
	summary := AccountSummary for: account.

	expectedReport:=  OrderedCollection with: 'Extracción por 50' with: 'Balance = -50'.
	self assert: expectedReport equals: summary report.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 21:53:36'!
test04ReportOfTwoAccountWithTransferBetweenThemPrintDiferentBalance
	|accountSender accountReceiver reportForReceiver reportForSender summaryReceiver summarySender | "only"
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	
	summarySender := AccountSummary for: accountSender .
	summaryReceiver := AccountSummary for: accountReceiver .
	
	reportForSender :=  OrderedCollection with: 'Salida por transferencia de 50' with: 'Balance = -50'.
	reportForReceiver := OrderedCollection with: 'Entrada por transferencia de 50' with: 'Balance = 50'.
	
	self assert: reportForSender equals: summarySender report.
	self assert: reportForReceiver equals: summaryReceiver report.! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 23:05:36'!
test05ReportOfAnAccountWithDifferentMovementsHasOneLineForOneOfThem
	|accountSender accountReceiver reportForReceiver reportForSender summaryReceiver summarySender | "many"
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Deposit register: 30 on: accountSender .
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	Withdraw register: 10 on: accountSender .
	Transfer transferAmount: 40 from: accountReceiver  to: accountSender .
	Withdraw register: 15 on: accountSender.
	
	summarySender := AccountSummary for: accountSender .
	summaryReceiver := AccountSummary for: accountReceiver .
	
	reportForSender :=  OrderedCollection new. " with: 'Salida por transferencia de 50' with: 'Balance = -50'."
	reportForSender add: 'Depósito por 30'.
	reportForSender add: 'Salida por transferencia de 50'.
	reportForSender add: 'Extracción por 10'.
	reportForSender add: 'Entrada por transferencia de 40'.
	reportForSender add: 'Extracción por 15'.
	reportForSender add: 'Balance = -5'.
	reportForReceiver := OrderedCollection with: 'Entrada por transferencia de 50' with: 'Salida por transferencia de 40' with: 'Balance = 10'.
	
	self assert: reportForSender equals: summarySender report.
	self assert: reportForReceiver equals: summaryReceiver report.! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
ReportTest subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'jul 5/28/2023 15:41:14'!
test01TransferReportOfAccountWithoutTransactionsReturnZero
	| account transferReport |
	account := ReceptiveAccount new.
	transferReport := TransferNetSummary for: account. 
	
	self assert: 0 equals: transferReport report.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'jul 5/28/2023 15:46:57'!
test02TransferNetReportsOnReceptiveAccountWithTransferRegisterValue
	| accountSender accountReceiver transferReportSender transferReportReceiver |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	
	transferReportSender := TransferNetSummary for: accountSender . 
	transferReportReceiver := TransferNetSummary for: accountReceiver . 
	
	self assert: 50 equals: transferReportReceiver report.
	self assert: -50 equals: transferReportSender report.! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'jul 5/28/2023 16:00:14'!
test03TransferNetReportsOnReceptiveAccountNotReportDeposit
	| account transferReport|
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	
	transferReport := TransferNetSummary for: account.
	
	self assert: 0 equals: transferReport report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'jul 5/28/2023 16:01:53'!
test04TransferNetReportsOnReceptiveAccountNotReportWithdraw
	| account transferReport|
	
	account := ReceptiveAccount new.
	
	Withdraw register: 50 on: account.
	
	transferReport := TransferNetSummary for: account.
	
	self assert: 0 equals: transferReport report.
	! !

!TransferNetTest methodsFor: 'as yet unclassified' stamp: 'jul 5/28/2023 16:05:50'!
test05TransferReportOfAccountWithManyTransferencesReturnSumOfAll
	| accountSender accountReceiver transferReportSender transferReportReceiver |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	Transfer transferAmount: 50 from: accountReceiver to: accountSender .
	
	transferReportSender := TransferNetSummary for: accountSender . 
	transferReportReceiver := TransferNetSummary for: accountReceiver . 
	
	self assert: 0 equals: transferReportReceiver report.
	self assert: 0 equals: transferReportSender report.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 16:02:52'!
test01TransferAffectBalance
	| accountSender accountReceiver |
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	Transfer transferAmount: 10 from: accountSender to: accountReceiver .
	
	self assert: (accountSender balance) equals: -10.
	self assert: (accountReceiver balance) equals: 10.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 16:19:13'!
test02TransferRegisterTransaction
	| accountSender accountReceiver transfer|
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	transfer := Transfer transferAmount: 10 from: accountSender to: accountReceiver .
	
	self assert: (transfer isDepositedTo: accountReceiver).
	self assert: (transfer isWithdrawFrom: accountSender).
	self deny: ( transfer isDepositedTo: accountSender ).
	self deny: ( transfer isWithdrawFrom: accountReceiver ).
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 16:28:10'!
test03TransferInSameAccountRaiseErro
	| accountSender  transfer|
	accountSender := ReceptiveAccount new. 
	
	self
		should: [transfer := Transfer transferAmount: 10 from: accountSender to: accountSender .]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: Transfer transferErrorSameAccount.
			self assert: (accountSender balance) equals: 0.
			self assert: (accountSender transactions isEmpty) .
			].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 17:08:28'!
test04AnAccountNavigatesThrowTransfers
	| accountSender accountReceiver transfer aDeposit aWithdraw  |
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	transfer := Transfer transferAmount: 10 from: accountSender to: accountReceiver.
	
	aDeposit := transfer deposit.
	aWithdraw := transfer withdraw. 
	
	self assert: (aDeposit isRegistered: transfer). 
	self assert: ( aWithdraw isRegistered: transfer ).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 18:30:29'!
test05TransferMustBePositive
	| accountSender accountReceiver  |
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	self 
	should: [ Transfer transferAmount: -10 from: accountSender to: accountReceiver. ]
	raise: Error
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: Transfer cannotTransferNegativeValue.
		self assert: (accountSender balance) equals: 0.
		self assert: (accountReceiver balance) equals: 0.
		]! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !



!Account methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 19:05:29'!
imprimirDepositos: report 
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'jul 5/26/2023 20:15:47'!
imprimirDepositos: report 
	transactions do: [ :transaction |
			(transaction isKindOf: Deposit)  ifTrue: [  transaction addLine: report ].
			(transaction isKindOf: Withdraw) ifTrue: [ transaction addLine: report].
			(transaction isKindOf: DepositTransfer ) ifTrue: [ transaction addLine: report].
			(transaction isKindOf: WithdrawTransfer ) ifTrue: [ transaction addLine: report].
		]! !


!ReceptiveAccount methodsFor: 'report' stamp: 'jul 5/28/2023 16:25:47'!
transferNet
	| totalTransfer |
	totalTransfer := 0.
	
	transactions do: [  :aTransaction |
		( aTransaction isKindOf: DepositTransfer  ) ifTrue: [ totalTransfer := totalTransfer + (aTransaction value).].
	
		( aTransaction isKindOf: WithdrawTransfer  ) ifTrue: [totalTransfer := totalTransfer - (aTransaction value)  .].		
		].

	^totalTransfer.! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:58:14'!
register: aValue on: account in: aTransfer

	| transaction |
	
	transaction := self for: aValue with: aTransfer.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #RegularTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #RegularTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
RegularTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'jul 5/26/2023 19:08:55'!
addLine: report 
	report add: 'Depósito por ', value printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
RegularTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'jul 5/26/2023 19:19:50'!
addLine: report 
	report add: 'Extracción por ', value printString.! !

!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #DepositTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #DepositTransfer
	instanceVariableNames: 'value realizedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'initialization' stamp: 'jul 5/26/2023 16:44:33'!
initializeFor: aValue

	value := aValue ! !

!DepositTransfer methodsFor: 'initialization' stamp: 'jul 5/26/2023 16:53:20'!
initializeFor: aValue with: aTransfer
	realizedTransfer := aTransfer.
	value := aValue ! !


!DepositTransfer methodsFor: 'value' stamp: 'jul 5/26/2023 16:44:33'!
value

	^ value! !


!DepositTransfer methodsFor: 'balance' stamp: 'jul 5/26/2023 16:44:33'!
affectBalance: aBalance

	^aBalance + value ! !


!DepositTransfer methodsFor: 'report' stamp: 'jul 5/26/2023 21:09:46'!
addLine: report 
	report add: 'Entrada por transferencia de ', value printString.! !


!DepositTransfer methodsFor: 'test' stamp: 'jul 5/26/2023 16:49:09'!
isRegistered: transfer 
	^realizedTransfer = transfer. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositTransfer class' category: 'Portfolio-Solucion'!
DepositTransfer class
	instanceVariableNames: ''!

!DepositTransfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:44:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!DepositTransfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:52:07'!
for: aValue with: aTransfer

	^ self new initializeFor: aValue with: aTransfer.! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #WithdrawTransfer
	instanceVariableNames: 'value realizedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'initialization' stamp: 'jul 5/26/2023 16:44:56'!
initializeFor: aValue

	value := aValue ! !

!WithdrawTransfer methodsFor: 'initialization' stamp: 'jul 5/26/2023 16:53:54'!
initializeFor: aValue with: aTransfer
	realizedTransfer := aTransfer.
	value := aValue ! !


!WithdrawTransfer methodsFor: 'value' stamp: 'jul 5/26/2023 16:44:56'!
value

	^ value! !


!WithdrawTransfer methodsFor: 'balance' stamp: 'jul 5/26/2023 16:44:56'!
affectBalance: aBalance

	^aBalance - value! !


!WithdrawTransfer methodsFor: 'test' stamp: 'jul 5/26/2023 16:49:35'!
isRegistered: transfer 
	^realizedTransfer = transfer. ! !


!WithdrawTransfer methodsFor: 'report' stamp: 'jul 5/26/2023 21:05:27'!
addLine: report 
	report add: 'Salida por transferencia de ', value printString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawTransfer class' category: 'Portfolio-Solucion'!
WithdrawTransfer class
	instanceVariableNames: ''!

!WithdrawTransfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:44:56'!
for: aValue

	^ self new initializeFor: aValue ! !

!WithdrawTransfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:53:38'!
for: aValue with: aTransfer

	^ self new initializeFor: aValue with: aTransfer.! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'jul 5/26/2023 18:41:36'!
initializeFor: anAccount
	account := anAccount! !


!AccountSummary methodsFor: 'category-name' stamp: 'jul 5/26/2023 19:14:18'!
report
	|report|
	report := OrderedCollection new.
	account imprimirDepositos: report.
	report add: 'Balance = ', account balance printString.
	^ report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 18:40:31'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount ! !


!classDefinition: #TransferNetSummary category: 'Portfolio-Solucion'!
Report subclass: #TransferNetSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetSummary methodsFor: 'initialize' stamp: 'jul 5/28/2023 15:42:09'!
initializeFor: anAccount 
	account := anAccount.! !


!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/28/2023 15:52:03'!
report
	
	^account transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetSummary class' category: 'Portfolio-Solucion'!
TransferNetSummary class
	instanceVariableNames: ''!

!TransferNetSummary class methodsFor: 'instance creation' stamp: 'jul 5/28/2023 15:41:52'!
for: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'instance creation' stamp: 'jul 5/26/2023 18:29:51'!
initializeTransferAmount: aValue from: anAccountSender to: anAccountReceiver
	(anAccountSender = anAccountReceiver ) ifTrue: [ self error: self class transferErrorSameAccount].
	( aValue < 0 ) ifTrue: [ self error: self class cannotTransferNegativeValue ].
	deposit := DepositTransfer register: aValue on: anAccountReceiver in: self.
	withdraw := WithdrawTransfer register: aValue on: anAccountSender in: self.! !


!Transfer methodsFor: 'test' stamp: 'jul 5/26/2023 16:15:22'!
isDepositedTo: anAccountReceiver 
	^anAccountReceiver hasRegistered: deposit. ! !

!Transfer methodsFor: 'test' stamp: 'jul 5/26/2023 16:16:06'!
isWithdrawFrom: accountSender 
	^accountSender hasRegistered: withdraw.! !


!Transfer methodsFor: 'inspecting' stamp: 'jul 5/26/2023 16:40:48'!
deposit
	^deposit! !

!Transfer methodsFor: 'inspecting' stamp: 'jul 5/26/2023 16:41:01'!
withdraw
	^withdraw! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 18:30:45'!
cannotTransferNegativeValue
	^'value transfer must be positive'! !

!Transfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 15:57:02'!
transferAmount: aValue from: accountSender to: accountReceiver
	^self new initializeTransferAmount: aValue from: accountSender to: accountReceiver! !

!Transfer class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 16:27:00'!
transferErrorSameAccount
	^'no se puede'! !
