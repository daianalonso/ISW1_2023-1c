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

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:54:37'!
test01AccountWithoutTransactionsPrintBalanceZero
	|account summary | 
	account := ReceptiveAccount new.
	summary := AccountSummary for: account.
	self assert: 'Balance = 0'equals: summary report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:54:47'!
test02AccountWithDepositPrintDepositAndBalance
	|account summary expectedReport|
	account := ReceptiveAccount new.
	Deposit register: 50 on: account. 
	summary := AccountSummary for: account.

	expectedReport:=  'Depósito por 50' , String  newLineString , 'Balance = 50'.
	self assert: expectedReport equals: summary report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:54:52'!
test03AccountWithWithdrawPrintWithdrawAndBalance
	|account summary expectedReport|
	account := ReceptiveAccount new.
	Withdraw register: 50 on: account. 
	summary := AccountSummary for: account.

	expectedReport:= 'Extracción por 50' , String  newLineString ,  'Balance = -50'.
	self assert: expectedReport equals: summary report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:54:57'!
test04ReportOfTwoAccountWithTransferBetweenThemPrintDiferentBalance
	|accountSender accountReceiver reportForReceiver reportForSender summaryReceiver summarySender |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	
	summarySender := AccountSummary for: accountSender .
	summaryReceiver := AccountSummary for: accountReceiver .
	
	reportForSender :=  'Salida por transferencia de 50' , String  newLineString ,  'Balance = -50'.
	reportForReceiver := 'Entrada por transferencia de 50' , String  newLineString ,  'Balance = 50'.
	
	self assert: reportForSender equals: summarySender report.
	self assert: reportForReceiver equals: summaryReceiver report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:55:03'!
test05ReportOfAnAccountWithDifferentMovementsHasOneLineForOneOfThem
	|accountSender accountReceiver reportForReceiver reportForSender summaryReceiver summarySender |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Deposit register: 30 on: accountSender .
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	Withdraw register: 10 on: accountSender .
	Transfer transferAmount: 40 from: accountReceiver  to: accountSender .
	Withdraw register: 15 on: accountSender.
	
	summarySender := AccountSummary for: accountSender .
	summaryReceiver := AccountSummary for: accountReceiver .
	
	reportForSender :=  'Depósito por 30', String  newLineString , 
		'Salida por transferencia de 50' , String  newLineString , 
		'Extracción por 10' , String  newLineString , 
		'Entrada por transferencia de 40' , String  newLineString , 
		'Extracción por 15' , String  newLineString , 
		'Balance = -5'.
	
	reportForReceiver := 'Entrada por transferencia de 50' , String  newLineString ,  'Salida por transferencia de 40' , String  newLineString ,  'Balance = 10'.
	
	self assert: reportForSender equals: summarySender report.
	self assert: reportForReceiver equals: summaryReceiver report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:55:09'!
test06AccountSummaryOfPortfolioWithoutTransactionsPrintBalanceZero
	|account summary | 
	account := Portfolio new.
	summary := AccountSummary for: account.
	self assert: 'Balance = 0'equals: summary report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 18:45:21'!
test07AccountSummaryInPortfolioWithReceptiveAccountRegisterTransactions
	| portfolio recepAccount  expectedReport | 
	recepAccount := ReceptiveAccount new. 
	Deposit register: 10 on: recepAccount .
	Withdraw register: 5 on: recepAccount .
	
	portfolio := Portfolio with: recepAccount .
	
	expectedReport := 'Depósito por 10' , String newLineString , 'Extracción por 5' , String newLineString , 'Balance = 5'.
	
	self assert: expectedReport equals: (AccountSummary for: portfolio) report.! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 18:56:40'!
test08AccountSummaryInPortfolioWithReceptiveAccountRegisterTransferTransactions
	| portfolioA portfolioB recepAccountSender recepAccountReceiver portfolioAReport portfolioBReport | 
	recepAccountSender := ReceptiveAccount new. 
	recepAccountReceiver := ReceptiveAccount new. 
	
	portfolioA := Portfolio with: recepAccountSender .
	portfolioB := Portfolio with: recepAccountReceiver .
	
	Transfer transferAmount: 50 from: recepAccountSender to: recepAccountReceiver .
	
	portfolioAReport := 'Salida por transferencia de 50' , String newLineString , 'Balance = -50'.
	portfolioBReport := 'Entrada por transferencia de 50' , String newLineString , 'Balance = 50'.
	
	self assert: portfolioAReport equals: (AccountSummary for: portfolioA ) report. 
	self assert: portfolioBReport equals: (AccountSummary for: portfolioB ) report. ! !

!AccountSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:03:08'!
test09AccountSummaryInPortfoliosRecognizeNestedAccounts
	| portfolio recepAccount portfolioReport | 
	recepAccount := ReceptiveAccount new. 
	Deposit register: 10 on: recepAccount .	

	portfolio := Portfolio with: (Portfolio with: recepAccount ).
	
	portfolioReport := 'Depósito por 10' , String newLineString , 'Balance = 10'.

	self assert: portfolioReport equals: (AccountSummary for: portfolio ) report. ! !


!classDefinition: #PortfolioSummaryTest category: 'Portfolio-Solucion'!
ReportTest subclass: #PortfolioSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 23:16:20'!
test01PortfolioReportOfEmptyPortfolioPrintTheirName
	| portfolio |
	portfolio := Portfolio named: 'Portfolio de la familia'.
	
	self assert: 'Portfolio de la familia' equals: (PortfolioSummary for: portfolio ) report. ! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 23:16:20'!
test02PortfolioReportPrintNameOfAccount
	| portfolio otherPortfolio account reportFamily|
	
	account := ReceptiveAccount named: 'Cuenta Mia'.
	
	portfolio := Portfolio named: 'Portfolio de la familia' with: account .
	
	otherPortfolio := Portfolio named: 'Portfolio de hijos'.
	
	portfolio add: otherPortfolio.
	
	reportFamily := 'Portfolio de la familia' , String newLineString ,	 String tab , 'Cuenta Mia', String newLineString , String tab, 'Portfolio de hijos'.
	
	self assert: reportFamily equals: (PortfolioSummary for: portfolio ) report. ! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 23:16:20'!
test03PortfolioReportPrintNestedPortfolios
	| portfolio otherPortfolio account reportFamily|
	
	account := ReceptiveAccount named: 'Cuenta Mia'.
	
	portfolio := Portfolio named: 'Portfolio de la familia' with: account .
	
	otherPortfolio := Portfolio named: 'Portfolio de hijos' with: (ReceptiveAccount named: 'Cuenta de Juan' ) with: (ReceptiveAccount named: 'Cuenta de Angeles' ).
	
	portfolio add: otherPortfolio.
	
	reportFamily := 'Portfolio de la familia' , String newLineString ,	 String tab , 'Cuenta Mia', String newLineString , String tab, 'Portfolio de hijos', String newLineString , 
		String tab , String tab, 'Cuenta de Juan' , String newLineString ,
		String tab , String tab, 'Cuenta de Angeles' .
	
	self assert: reportFamily equals: (PortfolioSummary for: portfolio ) report. ! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'jul 5/31/2023 23:45:26'!
test04PortfolioReportNotAllowedForReceptiveAccount
	self should: [ PortfolioSummary for: (ReceptiveAccount named: 'Cuenta Mia')]
		raise: Error
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: PortfolioSummary onlyPortfoliosAvailableErrorMessage ]
		! !

!PortfolioSummaryTest methodsFor: 'test' stamp: 'jul 6/1/2023 00:36:23'!
test05PortfolioReportPrintsTransactions
	| reportExpected portfolioFamilia portfolioHijos accountMia accountJuan accountAngeles externalAccount|
	
	accountMia := ReceptiveAccount named: 'Cuenta Mia'.
	Deposit register: 10 on: accountMia .
	Withdraw register: 20 on: accountMia .
	
	accountJuan := ReceptiveAccount named: 'Cuenta de Juan'.
	Deposit register: 30 on: accountJuan .
	Withdraw register: 20 on: accountJuan .
	
	accountAngeles := ReceptiveAccount named: 'Cuenta de Angeles'.
	externalAccount := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from:accountAngeles to: externalAccount .
	
	portfolioHijos := Portfolio named: 'Portfolio de hijos' with: accountJuan with: accountAngeles .
	portfolioFamilia := 	Portfolio named: 'Portfolio de la familia' with: accountMia with: portfolioHijos .
	
	reportExpected := 'Portfolio de la familia' , String newLineString , 
		String tab , 'Cuenta Mia' , String newLineString , 
			String tab , String tab, 'Depósito por 10' , String newLineString ,
			String tab , String tab, 'Extracción por 20' , String newLineString ,
			"String tab , String tab, 'Balance = -10' , String newLineString ,"
		String tab , 'Portfolio de hijos' , String newLineString ,
			String tab , String tab , 'Cuenta de Juan' , String newLineString , 
				String tab ,String tab , String tab, 'Depósito por 30' , String newLineString ,
				String tab ,String tab , String tab, 'Extracción por 20' , String newLineString ,
				"String tab ,String tab , String tab, 'Balance = 10' , String newLineString ,"
			String tab , String tab , 'Cuenta de Angeles' , String newLineString , 
					String tab ,String tab , String tab, 'Salida por extracción de 50'." , String newLineString ."
					"String tab ,String tab , String tab, 'Balance = -50' , String newLineString "
 	"		String tab , String tab , 'Balance = -40' , String newLineString ,"
		"String tab , 'Balance = -50'."

	self assert: reportExpected equals: (PortfolioSummary for: portfolioFamilia) report.! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
ReportTest subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/28/2023 15:41:14'!
test01TransferReportOfAccountWithoutTransactionsReturnZero
	| account transferReport |
	account := ReceptiveAccount new.
	transferReport := TransferNetSummary for: account. 
	
	self assert: 0 equals: transferReport report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/28/2023 15:46:57'!
test02TransferNetReportsOnReceptiveAccountWithTransferRegisterValue
	| accountSender accountReceiver transferReportSender transferReportReceiver |
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.
	
	Transfer transferAmount: 50 from: accountSender to: accountReceiver .
	
	transferReportSender := TransferNetSummary for: accountSender . 
	transferReportReceiver := TransferNetSummary for: accountReceiver . 
	
	self assert: 50 equals: transferReportReceiver report.
	self assert: -50 equals: transferReportSender report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/28/2023 16:00:14'!
test03TransferNetReportsOnReceptiveAccountNotReportDeposit
	| account transferReport|
	
	account := ReceptiveAccount new.
	
	Deposit register: 50 on: account.
	
	transferReport := TransferNetSummary for: account.
	
	self assert: 0 equals: transferReport report.
	! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/28/2023 16:01:53'!
test04TransferNetReportsOnReceptiveAccountNotReportWithdraw
	| account transferReport|
	
	account := ReceptiveAccount new.
	
	Withdraw register: 50 on: account.
	
	transferReport := TransferNetSummary for: account.
	
	self assert: 0 equals: transferReport report.
	! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/28/2023 16:05:50'!
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

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:06:27'!
test06TransferNetReportOnPortfolioWithoutTransactionsReturnZero
	| portfolio  |
	portfolio := Portfolio new. 
	self assert: 0 equals: (TransferNetSummary for: portfolio )report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:23:09'!
test07TransferNetReportOnPortfolioWithTransferReportWithdraw
	| portfolio  recepAccountSender recepAccountReceiver  |
	recepAccountSender := ReceptiveAccount new. 
	recepAccountReceiver := ReceptiveAccount new. 
	
	portfolio := Portfolio with: recepAccountSender .
	
	Transfer transferAmount: 20 from: recepAccountSender to: recepAccountReceiver .
	
	self assert: -20 equals: (TransferNetSummary for: portfolio )report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:23:02'!
test08TransferNetReportOnPortfolioWithTransferReportDeposit
	| portfolio  recepAccount otherRecepAccount  |
	otherRecepAccount := ReceptiveAccount new. 
	recepAccount := ReceptiveAccount new. 
	
	portfolio := Portfolio with: recepAccount .
	
	Transfer transferAmount: 20 from:  otherRecepAccount to: recepAccount .
	
	self assert: 20 equals: (TransferNetSummary for: portfolio )report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:29:16'!
test09TransferNetReportOnPortfolioNotRegisterRegularTransactions
	| portfolio  recepAccount  |
	recepAccount := ReceptiveAccount new. 
	
	Deposit register: 10 on: recepAccount .
	Withdraw register: 15 on: recepAccount .
	
	portfolio := Portfolio with: recepAccount.
	
	
	self assert: 0 equals: ( TransferNetSummary for: portfolio )report.! !

!TransferNetTest methodsFor: 'test' stamp: 'jul 5/31/2023 19:32:04'!
test10TransferNetReportOfNestedPorfolioRegisterInsideTranference
	| portfolio  accountSender accountReceiver  |
	accountSender := ReceptiveAccount new.
	accountReceiver  := ReceptiveAccount new. 
	
	Transfer transferAmount: 10 from: accountSender to: accountReceiver .
	
	portfolio := Portfolio with: (Portfolio with: accountSender ).
	
	
	self assert: -10 equals: ( TransferNetSummary for: portfolio )report.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'jul 5/26/2023 16:02:52'!
test01TransferAffectBalance
	| accountSender accountReceiver |
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	Transfer transferAmount: 10 from: accountSender to: accountReceiver .
	
	self assert: (accountSender balance) equals: -10.
	self assert: (accountReceiver balance) equals: 10.! !

!TransferTest methodsFor: 'test' stamp: 'jul 5/26/2023 16:19:13'!
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

!TransferTest methodsFor: 'test' stamp: 'jul 5/31/2023 23:31:59'!
test03TransferInSameAccountRaiseError
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

!TransferTest methodsFor: 'test' stamp: 'jul 5/26/2023 17:08:28'!
test04AnAccountNavigatesThrowTransfers
	| accountSender accountReceiver transfer aDeposit aWithdraw  |
	accountSender := ReceptiveAccount new. 
	accountReceiver := ReceptiveAccount new. 
	
	transfer := Transfer transferAmount: 10 from: accountSender to: accountReceiver.
	
	aDeposit := transfer deposit.
	aWithdraw := transfer withdraw. 
	
	self assert: (aDeposit isRegistered: transfer). 
	self assert: ( aWithdraw isRegistered: transfer ).! !

!TransferTest methodsFor: 'test' stamp: 'jul 5/26/2023 18:30:29'!
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


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents portfolioName'
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

!Portfolio methodsFor: 'initialization' stamp: 'jul 5/31/2023 19:50:23'!
initializeNamed: aName 
	portfolioName := aName.! !

!Portfolio methodsFor: 'initialization' stamp: 'jul 5/31/2023 20:02:28'!
initializeNamed: aName with: anAccount 
	portfolioName := aName.
	accounts add: anAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'jul 5/31/2023 23:08:03'!
initializeNamed: aName with: aReceptiveAccount with: anotherReceptiveAccount 
	portfolioName := aName.
	accounts add: aReceptiveAccount .
	accounts add: anotherReceptiveAccount.! !


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


!Portfolio methodsFor: 'report' stamp: 'jul 5/30/2023 20:07:40'!
generateAccountReport: aReport with: reportTemplate 
	
	^ accounts inject: reportTemplate into: [ :template :anAccount |
		anAccount generateReport: aReport with: template.
	]! !

!Portfolio methodsFor: 'report' stamp: 'jul 5/30/2023 20:02:51'!
generateReport: aReport with: reportTemplate
	^ aReport reportPortfolio: self with: reportTemplate.! !

!Portfolio methodsFor: 'report' stamp: 'jul 5/31/2023 19:50:40'!
portfolioName
	^portfolioName! !

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


!Portfolio class methodsFor: 'instance creation' stamp: 'jul 5/31/2023 19:39:04'!
named: aName 
	^self new initializeNamed: aName ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jul 5/31/2023 19:56:30'!
named: aName with: anAccount
	^self new initializeNamed: aName with: anAccount! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jul 5/31/2023 23:06:33'!
named: aName with: aReceptiveAccount with: anotherReceptiveAccount 
	^self new initializeNamed: aName with: aReceptiveAccount with: anotherReceptiveAccount ! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions receptiveAccountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jul 5/31/2023 20:12:06'!
initializeNamed: aName 
	receptiveAccountName := aName.! !


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


!ReceptiveAccount methodsFor: 'report' stamp: 'jul 5/30/2023 18:49:56'!
generateReport: aReport with: reportTemplate
	^aReport reportReceptiveAccount: self with: reportTemplate! !

!ReceptiveAccount methodsFor: 'report' stamp: 'jul 5/30/2023 19:48:22'!
generateTransactionsReport: aReport with: reportTemplate
	^transactions inject: reportTemplate into: [ :template :transaction | transaction report: aReport with: template ]! !

!ReceptiveAccount methodsFor: 'report' stamp: 'jul 5/31/2023 20:13:50'!
receptiveAccountName
	^receptiveAccountName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'jul 5/31/2023 19:54:52'!
named: aName
	^self new initializeNamed: aName! !


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


!AccountTransaction methodsFor: 'report' stamp: 'jul 5/31/2023 23:12:21'!
report: aReport with: reportTemplate
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

!AccountTransaction class methodsFor: 'instance creation' stamp: 'jul 5/30/2023 18:33:14'!
register: aValue on: account in: aTransfer

	| transaction |
	
	transaction := self for: aTransfer.
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

!Deposit methodsFor: 'report' stamp: 'jul 5/30/2023 19:21:20'!
report: aReport with: reportTemplate
	^aReport reportDeposit: self with: reportTemplate.! !

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


!Withdraw methodsFor: 'report' stamp: 'jul 5/30/2023 19:21:37'!
report: aReport with: reportTemplate
	^aReport reportWithdraw: self with: reportTemplate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferTransaction category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferTransaction
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTransaction methodsFor: 'test' stamp: 'jul 5/30/2023 18:19:17'!
isRegistered: aTransfer 
	^transfer = aTransfer. ! !


!TransferTransaction methodsFor: 'value' stamp: 'jul 5/30/2023 19:35:53'!
value
	^transfer value! !


!TransferTransaction methodsFor: 'initialization' stamp: 'jul 5/30/2023 18:28:41'!
intializeFor: aTransfer
	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferTransaction class' category: 'Portfolio-Solucion'!
TransferTransaction class
	instanceVariableNames: ''!

!TransferTransaction class methodsFor: 'as yet unclassified' stamp: 'jul 5/30/2023 18:28:22'!
for: aTransfer
	^self new intializeFor: aTransfer.! !


!classDefinition: #DepositTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #DepositTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositTransfer methodsFor: 'balance' stamp: 'jul 5/30/2023 18:30:29'!
affectBalance: aBalance

	^aBalance + (transfer value)! !


!DepositTransfer methodsFor: 'report' stamp: 'jul 5/30/2023 19:04:50'!
addLine: report 
	report add: 'Entrada por transferencia de ', transfer value printString.! !

!DepositTransfer methodsFor: 'report' stamp: 'jul 5/30/2023 19:21:48'!
report: aReport with: reportTemplate
	^aReport reportDepositTransfer: self with: reportTemplate.! !


!classDefinition: #WithdrawTransfer category: 'Portfolio-Solucion'!
TransferTransaction subclass: #WithdrawTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawTransfer methodsFor: 'balance' stamp: 'jul 5/30/2023 18:30:20'!
affectBalance: aBalance

	^aBalance - (transfer value)! !


!WithdrawTransfer methodsFor: 'report' stamp: 'jul 5/30/2023 19:04:44'!
addLine: report 
	report add: 'Salida por transferencia de ', transfer value printString.! !

!WithdrawTransfer methodsFor: 'report' stamp: 'jul 5/30/2023 19:22:05'!
report: aReport with: reportTemplate
	^aReport reportWithdrawTransfer: self with: reportTemplate.! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:17:38'!
report
	self subclassResponsibility ! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:17:19'!
reportDeposit: aDeposit with: reportTemplate
	self subclassResponsibility! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:25:14'!
reportDepositTransfer: aDepositTransfer with: reportTemplate
	self subclassResponsibility ! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:25:29'!
reportPortfolio: aPortfolio with: reportTemplate 
	self subclassResponsibility ! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:25:44'!
reportReceptiveAccount: anAccount with: aReportTemplate
	self subclassResponsibility ! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:25:59'!
reportWithdraw: aWithdraw with: reportTemplate
	self subclassResponsibility ! !

!Report methodsFor: 'report' stamp: 'jul 5/31/2023 23:26:21'!
reportWithdrawTransfer: aWithdrawTransfer with: reportTemplate
	self subclassResponsibility ! !


!Report methodsFor: 'initialize' stamp: 'jul 5/31/2023 23:42:24'!
initializeFor: anAccount 
	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'jul 5/31/2023 23:42:04'!
initializeFor: anAccount 
	account := anAccount.! !


!AccountSummary methodsFor: 'report' stamp: 'jul 5/31/2023 23:29:19'!
report
	^ (account generateReport: self with: ''), 'Balance = ', (account balance printString).! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:51:53'!
reportDeposit: aDeposit with: reportTemplate
	^reportTemplate , 'Depósito por ', aDeposit value printString, String newLineString ! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:52:16'!
reportDepositTransfer: aDepositTransfer with: reportTemplate
	^reportTemplate , 'Entrada por transferencia de ', aDepositTransfer value printString , String newLineString .! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 20:03:32'!
reportPortfolio: aPortfolio with: reportTemplate 
	^aPortfolio generateAccountReport: self with: reportTemplate .! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:00:23'!
reportReceptiveAccount: anAccount with: aReportTemplate
	^anAccount generateTransactionsReport: self with: aReportTemplate.! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:52:38'!
reportWithdraw: aWithdraw with: reportTemplate
	^reportTemplate , 'Extracción por ', aWithdraw value printString, String newLineString ! !

!AccountSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:52:59'!
reportWithdrawTransfer: aWithdrawTransfer with: reportTemplate
	^reportTemplate , 'Salida por transferencia de ', aWithdrawTransfer value printString , String newLineString .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'jul 5/26/2023 18:40:31'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount ! !


!classDefinition: #PortfolioSummary category: 'Portfolio-Solucion'!
Report subclass: #PortfolioSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioSummary methodsFor: 'report' stamp: 'jul 5/31/2023 23:19:24'!
report
	|res|
	res := account generateReport: self with: (Array with: '' with: 0). 
	^res at: 1.! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:04:46'!
reportDeposit: aDeposit with: reportTemplate
	^self addLineOn: reportTemplate with:  [ 'Depósito por ' , aDeposit value asString ].! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:08:51'!
reportDepositTransfer: aDepositTransfer with: reportTemplate
	^self addLineOn: reportTemplate with:  [ 'Entrada por transferencia de' , aDepositTransfer value asString ].! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:34:08'!
reportPortfolio: aPortfolio with: reportTemplate 
	
	^self addLineOn: reportTemplate with: [ aPortfolio portfolioName ] ;
	addLinesOn: reportTemplate with: [ aPortfolio generateAccountReport: self with: reportTemplate ].";
	addBalanceOn: reportTemplate with: aPortfolio ."
! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:34:16'!
reportReceptiveAccount: aReceptiveAccount with: reportTemplate 
	^self addLineOn: reportTemplate with: [ aReceptiveAccount receptiveAccountName ] ;
	addLinesOn: reportTemplate with: [ aReceptiveAccount generateTransactionsReport: self with: reportTemplate ].";
	addBalanceOn: reportTemplate with: aReceptiveAccount ."
! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:05:59'!
reportWithdraw: aWithdraw with: reportTemplate
	^self addLineOn: reportTemplate with:  [ 'Extracción por ' , aWithdraw value asString ].! !

!PortfolioSummary methodsFor: 'report' stamp: 'jul 6/1/2023 00:22:21'!
reportWithdrawTransfer: aWithdrawTransfer with: reportTemplate
	^self addLineOn: reportTemplate with:  [ 'Salida por extracción de ' , aWithdrawTransfer value asString ].! !


!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 6/1/2023 00:53:28'!
addBalanceOn: reportTemplate with: anAccount
	|reportFormat prefix |
	reportFormat := reportTemplate at:1.
	self incrementLevel: reportTemplate .
	prefix := self generatePrefixFor: reportTemplate.
	reportFormat := reportFormat , prefix , 'Balance = ', anAccount balance asString . 
	self decrementLevel: reportTemplate .
	^reportTemplate at:1 put: reportFormat. 
! !

!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 5/31/2023 21:01:47'!
addLineOn: reportTemplate with: aBlock
	|reportFormat prefix |
	reportFormat := reportTemplate at:1.
	prefix := self generatePrefixFor: reportTemplate.
	reportFormat := reportFormat , prefix , aBlock value. 
	reportTemplate at:1 put: reportFormat.
	^reportTemplate .! !

!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 6/1/2023 00:52:19'!
addLinesOn: reportTemplate with: aBlock
	self incrementLevel: reportTemplate.
	aBlock value.
	self decrementLevel: reportTemplate.
	^reportTemplate ! !

!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 6/1/2023 00:48:55'!
decrementLevel: reportTemplate
	|level|
	level := reportTemplate at: 2.
	reportTemplate at:2 put: level - 1.
	^reportTemplate .! !

!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 6/1/2023 00:45:36'!
generatePrefixFor: reportTemplate
	|level res |
	level := reportTemplate at:2.
	(level = 0) ifTrue: [ ^'' ].
	res := ''.
	level timesRepeat: [ res := res , String tab ].
	^String newLineString , res. ! !

!PortfolioSummary methodsFor: 'report - private' stamp: 'jul 6/1/2023 00:47:34'!
incrementLevel: reportTemplate
	|level|
	level := reportTemplate at:2.
	reportTemplate at:2 put: level +1.
	^reportTemplate ! !


!PortfolioSummary methodsFor: 'initialize' stamp: 'jul 5/31/2023 23:44:53'!
initializeFor: anAccount 
	(anAccount isKindOf: ReceptiveAccount ) ifTrue: [ self error: self class onlyPortfoliosAvailableErrorMessage ].
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioSummary class' category: 'Portfolio-Solucion'!
PortfolioSummary class
	instanceVariableNames: ''!

!PortfolioSummary class methodsFor: 'instance creation' stamp: 'jul 5/31/2023 23:42:47'!
for: aPortfolio 
	^self new initializeFor: aPortfolio ! !


!PortfolioSummary class methodsFor: 'as yet unclassified' stamp: 'jul 5/31/2023 23:44:53'!
onlyPortfoliosAvailableErrorMessage
	^'Only Portfolios Available'! !


!classDefinition: #TransferNetSummary category: 'Portfolio-Solucion'!
Report subclass: #TransferNetSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetSummary methodsFor: 'initialize' stamp: 'jul 5/31/2023 23:42:04'!
initializeFor: anAccount 
	account := anAccount.! !

!TransferNetSummary methodsFor: 'initialize' stamp: 'jul 5/31/2023 19:07:41'!
reportPortfolio: aPortfolio with: reportTemplate 
	^aPortfolio generateAccountReport: self with: reportTemplate 
	! !


!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:38:40'!
report
	^account generateReport: self with: 0.! !

!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:44:52'!
reportDeposit: aDeposit with: aBalance
	^aBalance! !

!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:43:33'!
reportDepositTransfer: aDepositTransfer with: aBalance
	^aBalance + aDepositTransfer value! !

!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:42:18'!
reportReceptiveAccount: anAccount with: aReportTemplate
	^anAccount generateTransactionsReport: self with: aReportTemplate.! !

!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:44:33'!
reportWithdraw: aWithdraw with: aBalance
	^aBalance! !

!TransferNetSummary methodsFor: 'report' stamp: 'jul 5/30/2023 19:44:13'!
reportWithdrawTransfer: aWithdrawTransfer with: aBalance
	^aBalance - aWithdrawTransfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetSummary class' category: 'Portfolio-Solucion'!
TransferNetSummary class
	instanceVariableNames: ''!

!TransferNetSummary class methodsFor: 'instance creation' stamp: 'jul 5/28/2023 15:41:52'!
for: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'deposit withdraw transferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'instance creation' stamp: 'jul 5/30/2023 18:13:14'!
initializeTransferAmount: aValue from: anAccountSender to: anAccountReceiver
	(anAccountSender = anAccountReceiver ) ifTrue: [ self error: self class transferErrorSameAccount].
	( aValue < 0 ) ifTrue: [ self error: self class cannotTransferNegativeValue ].
	transferValue := aValue.
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

!Transfer methodsFor: 'inspecting' stamp: 'jul 5/30/2023 18:12:01'!
value
	^transferValue ! !

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
