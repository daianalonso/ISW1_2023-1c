!classDefinition: #HeadingLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #HeadingLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:58:17'!
test01HeadingLoggerOfMarsRoverNotRotatingIsEmpty
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'f'.
	
	self assert: headingLogger logs isEmpty. ! !

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:58:26'!
test02HeadingLoggerRegisterHeadingEast
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'East') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:58:33'!
test03HeadingLoggerRegisterHeadingWest
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'West') equals: headingLogger logs.! !

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:58:41'!
test04HeadingLoggerRegisterHeadingNorth
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'l'.
	
	self assert: (OrderedCollection with: 'North') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:58:51'!
test05HeadingLoggerRegisterHeadingSouth
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'r'.
	
	self assert: (OrderedCollection with: 'South') equals: headingLogger logs. ! !

!HeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:59:08'!
test06HeadingLoggerRegisterMoreThanOneRotation
	|marsRover headingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	headingLogger := HeadingLogger track: marsRover.
	
	marsRover process: 'rl'.
	
	self assert: (OrderedCollection with: 'East' with: 'North') equals: headingLogger logs. ! !


!classDefinition: #HeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #HeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:01:16'!
test01HeadingWindowLoggerDontLogIfEmptyCommand
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow track: marsRover.
	
	marsRover process: ''.
	
	self assert: '' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:30:58'!
test02HeadingWindowLoggerRegisterRotation
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow track: marsRover.
	
	marsRover process: 'r'.
	
	self assert: 'Apuntando al Este' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:01:30'!
test03HeadingWindowLoggerIfProcessMovementShowNothing
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow track: marsRover.
	
	marsRover process: 'f'.
	
	self assert: '' equals: headingWindowLogger headingValue. ! !

!HeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:31:16'!
test04HeadingWindowLoggerShowLastHeading
	|marsRover headingWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingWindowLogger := HeadingWindow track: marsRover.
	
	marsRover process: 'rr'.
	
	self assert: 'Apuntando al Sur' equals: headingWindowLogger headingValue. ! !


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

!PositionHeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:57:03'!
test01PositionHeadingLoggerOfMarsRoverThatDidntMoveIsEmpty
	|marsRover positionHeadingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingLogger := PositionHeadingLogger track: marsRover.
	
	marsRover process: ''.
	
	self assert: positionHeadingLogger logs isEmpty. ! !

!PositionHeadingLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:42:28'!
test02PositionHeadingLoggerOfMarsRoverTrackMovementAndRotation
	|marsRover positionHeadingLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingLogger := PositionHeadingLogger track: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: (OrderedCollection with: 1@2 with: 'East') equals: positionHeadingLogger logs . ! !


!classDefinition: #PositionHeadingWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionHeadingWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:02'!
test01PositionHeadingWindowOfMarsRoverThatDoesntMoveIsEmpty
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: ''.
	
	self assert: (Array with: '' with: '') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:11'!
test02PositionHeadingWindowMovingFowardShowsPositionAndEmptyHeading
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'f'.
	
	self assert: (Array with: '1@2' with: '') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:20'!
test03PositionHeadingWindowMovingFowardAndRotatingShowsPositionAnHeading
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'fr'.
	
	self assert: (Array with: '1@2' with: 'Apuntando al Este') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:27'!
test04PositionHeadingWindowHeadingNorthShowsLastPositionHeadingEast
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'frf'.
	
	self assert: (Array with: '2@2' with: 'Apuntando al Este') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:34'!
test05PositionHeadingWindowHeadingNorthShowsLastPositionHeadingWest
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'flf'.
	
	self assert: (Array with: '0@2' with: 'Apuntando al Oeste') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:41'!
test06PositionHeadingWindowHeadingEastShowsLastPositionHeadingNorth
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'lf'.
	
	self assert: (Array with: '1@2' with: 'Apuntando al Norte') equals: positionHeadingWindow positionHeadingValue. ! !

!PositionHeadingWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:55:48'!
test07PositionHeadingWindowHeadingEastShowsLastPositionHeadingSouth
	|marsRover positionHeadingWindow|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionHeadingWindow := PositionHeadingWindow track: marsRover.
	
	marsRover process: 'lllf'.
	
	self assert: (Array with: '1@0' with: 'Apuntando al Sur') equals: positionHeadingWindow positionHeadingValue. ! !


!classDefinition: #PositionLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:52:49'!
test01PositionLoggerOfMarsRoverThatDidntMoveIsEmpty
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger track: marsRover.
	
	self assert: positionLogger logs isEmpty. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:41:52'!
test02PositionLoggerRegisterMoveNorth
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 0@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 20:41:47'!
test03PositionLoggerRegisterMoveSouth
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 1@0) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:53:14'!
test04PositionLoggerRegisterMoveEast
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'f'.
	
	self assert: (OrderedCollection with: 2@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:53:24'!
test05PositionLoggerRegisterMoveWest
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'b'.
	
	self assert: (OrderedCollection with: 0@1) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:53:33'!
test06PositionLoggerRegisterMoreThanOneMovement
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'ff'.
	
	self assert: (OrderedCollection with: 1@2 with: 1@3) equals: positionLogger logs. ! !

!PositionLoggerTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:53:44'!
test07PositionLoggerOfMarsRoverRotatingDoesntTrackMovements
	|marsRover positionLogger|
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth. 
	
	positionLogger := PositionLogger track: marsRover.
	
	marsRover process: 'r'.
	
	self assert: positionLogger logs isEmpty. ! !


!classDefinition: #PositionWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #PositionWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:52:18'!
test01PositionWindowLoggerDontLogIfEmptyCommand
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow track: marsRover. 
	
	marsRover process: ''.
	self assert: '' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:50:42'!
test02PositionWindowLoggerRegisterMovement
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow track: marsRover. 
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:50:55'!
test03PositionWindowLoggerDoesntRegisterRotation
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow track: marsRover.

	marsRover process: 'r'.
	
	self assert: '' equals: positionWindowLogger positionValue. ! !

!PositionWindowTest methodsFor: 'tests' stamp: 'DA 6/3/2023 19:52:34'!
test04PositionWindowLoggerStoreLastPosition
	|marsRover positionWindowLogger|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionWindowLogger := PositionWindow track: marsRover.

	marsRover process: 'ff'.
	
	self assert: '1@3' equals: positionWindowLogger positionValue. ! !


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


!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 19:44:36'!
headEast
	
	head := MarsRoverHeadingEast for: self.
! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 19:44:45'!
headNorth
	
	head := MarsRoverHeadingNorth for: self.
	! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 19:44:50'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 19:44:54'!
headWest
	
	head := MarsRoverHeadingWest for: self. ! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 20:27:04'!
rotateLeft
	
	head rotateLeft.
	self notifyHeading ! !

!MarsRover methodsFor: 'heading' stamp: 'DA 6/3/2023 20:27:09'!
rotateRight
	
	head rotateRight.
	self notifyHeading ! !


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


!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 20:27:15'!
moveBackward

	head moveBackward.
	self notifyPosition ! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 19:45:06'!
moveEast
	
	position := position + (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 20:27:20'!
moveForward
	
	head moveForward.
	self notifyPosition ! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 19:45:11'!
moveNorth
	
	position := position + (0@1).! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 19:45:15'!
moveSouth
	
	position := position + (0@-1).! !

!MarsRover methodsFor: 'moving' stamp: 'DA 6/3/2023 19:45:19'!
moveWest
	
	position := position + (-1@0).! !


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

!MarsRover methodsFor: 'tracking' stamp: 'DA 6/3/2023 20:26:32'!
notifyHeading
	loggers do: [:aLogger | aLogger notifyHeadingChange].! !

!MarsRover methodsFor: 'tracking' stamp: 'DA 6/3/2023 20:26:43'!
notifyPosition
	loggers do: [:aLogger | aLogger notifyPositionChange].! !


!MarsRover methodsFor: 'accesing' stamp: 'DA 6/3/2023 20:05:19'!
head
	^head! !

!MarsRover methodsFor: 'accesing' stamp: 'DA 6/3/2023 20:05:11'!
position
	^position! !

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


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #HeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #HeadingLogger
	instanceVariableNames: 'logs marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:26:06'!
notifyHeadingChange
	(marsRover head isKindOf: MarsRoverHeadingEast) ifTrue: [logs add: 'East'].
	(marsRover head isKindOf: MarsRoverHeadingSouth) ifTrue: [logs add: 'South'].
	(marsRover head isKindOf: MarsRoverHeadingNorth) ifTrue: [logs add: 'North'].
	(marsRover head isKindOf: MarsRoverHeadingWest) ifTrue: [logs add: 'West'].
! !

!HeadingLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:27:56'!
notifyPositionChange
	
! !


!HeadingLogger methodsFor: 'accessing' stamp: 'DA 6/2/2023 18:38:40'!
logs
	^ logs! !


!HeadingLogger methodsFor: 'initialization' stamp: 'DA 6/3/2023 19:57:57'!
initializeTrack: aMarsRover
	logs := OrderedCollection new.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingLogger class' category: 'MarsRover-WithHeading'!
HeadingLogger class
	instanceVariableNames: ''!

!HeadingLogger class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 19:59:41'!
track: aMarsRover 
	^self new initializeTrack: aMarsRover ! !


!classDefinition: #HeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #HeadingWindow
	instanceVariableNames: 'headingValue marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWindow methodsFor: 'accessing' stamp: 'DA 6/2/2023 19:47:07'!
headingValue
	^headingValue.! !


!HeadingWindow methodsFor: 'initialization' stamp: 'DA 6/3/2023 20:00:51'!
initializeTrack: aMarsRover
	headingValue := ''.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !


!HeadingWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:29:44'!
notifyHeadingChange
	(marsRover head isKindOf: MarsRoverHeadingEast) ifTrue: [headingValue := 'Apuntando al Este'].
	(marsRover head isKindOf: MarsRoverHeadingSouth) ifTrue: [headingValue := 'Apuntando al Sur'].
	(marsRover head isKindOf: MarsRoverHeadingNorth) ifTrue: [headingValue := 'Apuntando al Norte'].
	(marsRover head isKindOf: MarsRoverHeadingWest) ifTrue: [headingValue := 'Apuntando al Oeste'].! !

!HeadingWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:30:08'!
notifyPositionChange
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HeadingWindow class' category: 'MarsRover-WithHeading'!
HeadingWindow class
	instanceVariableNames: ''!

!HeadingWindow class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 20:01:53'!
track: aMarsRover 
	^self new initializeTrack: aMarsRover ! !


!classDefinition: #PositionHeadingLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionHeadingLogger
	instanceVariableNames: 'logs marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:33:54'!
notifyHeadingChange
	(marsRover head isKindOf: MarsRoverHeadingEast) ifTrue: [logs addLast: 'East'].
	(marsRover head isKindOf: MarsRoverHeadingSouth) ifTrue: [logs addLast: 'South'].
	(marsRover head isKindOf: MarsRoverHeadingNorth) ifTrue: [logs addLast: 'North'].
	(marsRover head isKindOf: MarsRoverHeadingWest) ifTrue: [logs addLast: 'West'].! !

!PositionHeadingLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:42:19'!
notifyPositionChange
	logs addLast: marsRover position! !


!PositionHeadingLogger methodsFor: 'accessing' stamp: 'DA 6/2/2023 19:06:57'!
logs
	^logs! !


!PositionHeadingLogger methodsFor: 'initialization' stamp: 'DA 6/3/2023 19:56:50'!
initializeTrack: aMarsRover
	logs := OrderedCollection new.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionHeadingLogger class' category: 'MarsRover-WithHeading'!
PositionHeadingLogger class
	instanceVariableNames: ''!

!PositionHeadingLogger class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 19:57:26'!
track: aMarsRover 
	^self new initializeTrack: aMarsRover ! !


!classDefinition: #PositionHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionHeadingWindow
	instanceVariableNames: 'positionHeadingValue marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionHeadingWindow methodsFor: 'accessing' stamp: 'DA 6/2/2023 20:01:06'!
positionHeadingValue
	^ positionHeadingValue! !


!PositionHeadingWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:36:45'!
notifyHeadingChange
	(marsRover head isKindOf: MarsRoverHeadingEast) ifTrue: [positionHeadingValue at:2 put: 'Apuntando al Este'].
	(marsRover head isKindOf: MarsRoverHeadingSouth) ifTrue: [positionHeadingValue at:2 put: 'Apuntando al Sur'].
	(marsRover head isKindOf: MarsRoverHeadingNorth) ifTrue: [positionHeadingValue at:2 put: 'Apuntando al Norte'].
	(marsRover head isKindOf: MarsRoverHeadingWest) ifTrue: [positionHeadingValue at:2 put: 'Apuntando al Oeste'].! !

!PositionHeadingWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:37:23'!
notifyPositionChange
	positionHeadingValue at:1 put: marsRover position printString. ! !


!PositionHeadingWindow methodsFor: 'initialization' stamp: 'DA 6/3/2023 19:54:40'!
initializeTrack: aMarsRover
	positionHeadingValue := Array with: ''  with:''.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionHeadingWindow class' category: 'MarsRover-WithHeading'!
PositionHeadingWindow class
	instanceVariableNames: ''!

!PositionHeadingWindow class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 19:56:06'!
track: aMarsRover 
	^self new initializeTrack: aMarsRover ! !


!classDefinition: #PositionLogger category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionLogger
	instanceVariableNames: 'logs marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:40:04'!
notifyHeadingChange

! !

!PositionLogger methodsFor: 'update' stamp: 'DA 6/3/2023 20:42:00'!
notifyPositionChange
	logs addLast: marsRover position ! !


!PositionLogger methodsFor: 'accesing' stamp: 'DA 6/2/2023 18:56:09'!
logs
	(logs isEmpty) ifTrue: [^OrderedCollection new].
	^ logs ! !


!PositionLogger methodsFor: 'initialization' stamp: 'DA 6/3/2023 19:51:57'!
initializeTrack: aMarsRover
	logs := OrderedCollection new.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionLogger class' category: 'MarsRover-WithHeading'!
PositionLogger class
	instanceVariableNames: ''!

!PositionLogger class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 19:56:26'!
track: aMarsRover 
	^self new initializeTrack: aMarsRover ! !


!classDefinition: #PositionWindow category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #PositionWindow
	instanceVariableNames: 'positionValue marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!PositionWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:43:09'!
notifyHeadingChange
	! !

!PositionWindow methodsFor: 'update' stamp: 'DA 6/3/2023 20:42:58'!
notifyPositionChange
	positionValue := marsRover position printString! !


!PositionWindow methodsFor: 'accessing' stamp: 'DA 6/2/2023 19:34:44'!
positionValue
	^positionValue! !


!PositionWindow methodsFor: 'initialization' stamp: 'DA 6/3/2023 19:51:10'!
initializeTrack: aMarsRover 
	positionValue := ''.
	marsRover := aMarsRover.
	aMarsRover addLogger: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionWindow class' category: 'MarsRover-WithHeading'!
PositionWindow class
	instanceVariableNames: ''!

!PositionWindow class methodsFor: 'instance creation' stamp: 'DA 6/3/2023 19:48:59'!
track: aMarsRover
	^self new initializeTrack: aMarsRover ! !
