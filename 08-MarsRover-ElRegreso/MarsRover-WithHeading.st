!classDefinition: #HeadingLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #HeadingLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:26:32'!
test01HeadingLoggerOfMarsRoverNotRotatingIsEmpty
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'f'.
	
	self assert: headingLogger logs isEmpty. ! !

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:27:06'!
test02HeadingLoggerRegisterHeadingEast
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:27:30'!
test03HeadingLoggerRegisterHeadingWest
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: headingLogger logs.! !

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:27:47'!
test04HeadingLoggerRegisterHeadingNorth
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'North') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:28:12'!
test05HeadingLoggerRegisterHeadingSouth
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'South') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:28:34'!
test06HeadingLoggerRegisterMoreThanOneRotation
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger new.
	
	marsRover addLogger: headingLogger.
	
	marsRover process: 'rl'.
	
	self assert: (OrderedCollection with: 'East' with: 'North') equals: headingLogger logs. ! !


!classDefinition: #HeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #HeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:57:18'!
test01HeadingWindowLoggerDontLogIfEmptyCommand
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow new. 
	
	marsRover addLogger: headingWindowLogger.
	marsRover process: ''.
	
	self assert: '' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:57:18'!
test02HeadingWindowLoggerRegisterRotation
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow new. 
	
	marsRover addLogger: headingWindowLogger.
	marsRover process: 'r'.
	
	self assert: 'East' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:57:18'!
test03HeadingWindowLoggerIfProcessMovementShowNothing
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow new. 
	
	marsRover addLogger: headingWindowLogger.
	marsRover process: 'f'.
	
	self assert: '' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:57:18'!
test04HeadingWindowLoggerShowLastHeading
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow new. 
	
	marsRover addLogger: headingWindowLogger.
	marsRover process: 'rr'.
	
	self assert: 'South' equals: headingWindowLogger headingValue. ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #PositionHeadingLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionHeadingLoggerTest
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:29:36'!
test01PositionHeadingLoggerOfMarsRoverThatDidntMoveIsEmpty
	|marsRover positionHeadingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingLogger := PositionHeadingLogger new.
	
	marsRover addLogger: positionHeadingLogger.
	
	marsRover process: ''.
	
	self assert: positionHeadingLogger logs isEmpty. ! !

!PositionHeadingLoggerTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:29:57'!
test02PositionHeadingLoggerOfMarsRoverTrackMovementAndRotation
	|marsRover positionHeadingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingLogger := PositionHeadingLogger new.
	
	marsRover addLogger: positionHeadingLogger.
	
	marsRover process: 'fr'.
	
	self assert: (OrderedCollection with: 1@2 with: 'East') equals: positionHeadingLogger logs . ! !


!classDefinition: #PositionHeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionHeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 20:06:21'!
test01PositionHeadingWindowOfMarsRoverThatDoesntMoveIsEmpty
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow new.
	
	marsRover addLogger: positionHeadingWindow.
	
	marsRover process: ''.
	
	self assert: (Array with: '' with: '') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 20:06:28'!
test02PositionHeadingWindowMovingFowardShowsPositionAndEmptyHeading
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow new.
	
	marsRover addLogger: positionHeadingWindow.
	
	marsRover process: 'f'.
	
	self assert: (Array with: '1@2' with: '') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 20:10:24'!
test03PositionHeadingWindowMovingFowardAndRotatingShowsPositionAnHeading
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow new.
	
	marsRover addLogger: positionHeadingWindow.
	
	marsRover process: 'fr'.
	
	self assert: (Array with: '1@2' with: 'Apuntando al Este') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 20:10:19'!
test04PositionHeadingWindowShowsLastPositionAndRotation
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow new.
	
	marsRover addLogger: positionHeadingWindow.
	
	marsRover process: 'frf'.
	
	self assert: (Array with: '2@2' with: 'Apuntando al Este') equals: positionHeadingWindow positionHeadingValue. ! !


!classDefinition: #PositionLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 18:26:02'!
test01PositionLoggerOfMarsRoverThatDidntMoveIsEmpty
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	self assert: positionLogger logs isEmpty. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:04:05'!
test02PositionLoggerRegisterMoveNorth
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 0@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:04:17'!
test03PositionLoggerRegisterMoveSouth
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 1@0) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:04:30'!
test04PositionLoggerRegisterMoveEast
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 2@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:04:44'!
test05PositionLoggerRegisterMoveWest
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 0@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:28:59'!
test06PositionLoggerRegisterMoreThanOneMovement
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'ff'.
	
	self assert: (OrderedCollection with: 1@2 with: 1@3) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/2/2023 19:29:09'!
test07PositionLoggerOfMarsRoverRotatingDoesntTrackMovements
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger new.
	
	marsRover addLogger: positionLogger.
	
	marsRover process: 'r'.
	
	self assert: positionLogger logs isEmpty. ! !


!classDefinition: #PositionWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:56:42'!
test01PositionWindowLoggerDontLogIfEmptyCommand
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow new. 
	
	marsRover addLogger: positionWindowLogger.
	marsRover process: ''.
	self assert: '' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:56:42'!
test02PositionWindowLoggerRegisterMovement
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow new. 
	
	marsRover addLogger: positionWindowLogger.
	marsRover process: 'f'.
	
	self assert: '1@2' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:56:43'!
test03PositionWindowLoggerDoesntRegisterRotation
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow new. 
	
	marsRover addLogger: positionWindowLogger.
	marsRover process: 'r'.
	
	self assert: '' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:56:42'!
test04PositionWindowLoggerStoreLastPosition
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow new. 
	
	marsRover addLogger: positionWindowLogger.
	marsRover process: 'ff'.
	
	self assert: '1@3' equals: positionWindowLogger positionValue. ! !


!classDefinition: #HeadingLogger category: 'MarsRover-WithHeading'!
Object subclass: #HeadingLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 18:52:16'!
addHeading: aHeading
	logs add: aHeading! !

!HeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:01:24'!
addPosition: aPosition 
	! !

!HeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 18:38:40'!
logs
	^ logs! !


!HeadingLogger methodsFor: 'initialization' stamp: 'DA 6/2/2023 18:52:27'!
initialize
	logs := OrderedCollection new.! !


!classDefinition: #HeadingWindow category: 'MarsRover-WithHeading'!
Object subclass: #HeadingWindow
	instanceVariableNames: 'headingValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:49:40'!
addHeading: aHeading
	headingValue := aHeading ! !

!HeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:52:23'!
addPosition: aPosition 
	headingValue := ''! !

!HeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:47:07'!
headingValue
	^headingValue.! !

!HeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:47:41'!
initialize 
	headingValue := ''! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head loggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'DA 6/2/2023 18:22:17'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	loggers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'DA 6/2/2023 20:20:49'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	loggers do: [:aLogger | 
		(aLogger isKindOf: PositionHeadingWindow) ifTrue: [aLogger addHeading: 'Apuntando al Este']
		ifFalse: [aLogger addHeading: 'East']].! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/2/2023 18:48:38'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	loggers do: [:aLogger | aLogger addHeading: 'North'].
	! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/2/2023 18:49:28'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	loggers do: [:aLogger | aLogger addHeading: 'South'].! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/2/2023 18:47:34'!
headWest
	
	head := MarsRoverHeadingWest for: self. 
	loggers do: [:aLogger | aLogger addHeading: 'West'].! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/2/2023 18:42:31'!
moveEast
	
	position := position + (1@0).
	loggers do: [:aLogger | aLogger addPosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/2/2023 18:31:45'!
moveNorth
	
	position := position + (0@1).
	loggers do: [:aLogger | aLogger addPosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/2/2023 18:34:07'!
moveSouth
	
	position := position + (0@-1).
	loggers do: [:aLogger | aLogger addPosition: position].! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/2/2023 18:43:34'!
moveWest
	
	position := position + (-1@0).
	loggers do: [:aLogger | aLogger addPosition: position].! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'tracking' stamp: 'DA 6/2/2023 18:21:10'!
addLogger: positionLogger 
	loggers add: positionLogger ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #PositionHeadingLogger category: 'MarsRover-WithHeading'!
Object subclass: #PositionHeadingLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:11:27'!
addHeading: aHeading
	logs addLast: aHeading ! !

!PositionHeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:10:58'!
addPosition: aPosition 
	logs addLast: aPosition ! !

!PositionHeadingLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:06:57'!
logs
	^logs! !


!PositionHeadingLogger methodsFor: 'as yet unclassified' stamp: 'DA 6/2/2023 19:07:27'!
initialize
	logs := OrderedCollection new! !


!classDefinition: #PositionHeadingWindow category: 'MarsRover-WithHeading'!
Object subclass: #PositionHeadingWindow
	instanceVariableNames: 'positionHeadingValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 20:08:34'!
addHeading: aHeading
	positionHeadingValue at:2 put: aHeading! !

!PositionHeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 20:05:55'!
addPosition: aPosition 
	positionHeadingValue at:1 put: aPosition printString. ! !

!PositionHeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 20:02:05'!
initialize
	positionHeadingValue := Array with: ''  with:''.! !

!PositionHeadingWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 20:01:06'!
positionHeadingValue
	^ positionHeadingValue! !


!classDefinition: #PositionLogger category: 'MarsRover-WithHeading'!
Object subclass: #PositionLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:03:26'!
addHeading: aHeading

! !

!PositionLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 18:32:18'!
addPosition: aPosition 
	logs addLast: aPosition.! !

!PositionLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 18:28:42'!
initialize
	logs := OrderedCollection new! !

!PositionLogger methodsFor: 'category-name' stamp: 'DA 6/2/2023 18:56:09'!
logs
	(logs isEmpty) ifTrue: [^OrderedCollection new].
	^ logs ! !


!classDefinition: #PositionWindow category: 'MarsRover-WithHeading'!
Object subclass: #PositionWindow
	instanceVariableNames: 'positionValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:41:08'!
addHeading: aHeading
	! !

!PositionWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:39:04'!
addPosition: aPosition 
	positionValue := aPosition printString ! !

!PositionWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:38:53'!
initialize
	positionValue := ''.! !

!PositionWindow methodsFor: 'category-name' stamp: 'DA 6/2/2023 19:34:44'!
positionValue
	^positionValue! !
