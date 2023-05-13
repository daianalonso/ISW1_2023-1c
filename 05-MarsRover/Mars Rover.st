!classDefinition: #TestsMarsRover category: 'Mars Rover'!
TestCase subclass: #TestsMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 01:26:42'!
test01SuccessfullLanding
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	self assert: (marsRover hasPosition: 1@1 facing: self north).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 01:26:47'!
test02DoesNotMoveWhenNoCommand
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readACommand: ''.
	
	self assert: (marsRover hasPosition: 1@1 facing: self north).
! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 01:26:37'!
test03IncrementXAfterMovingFowardWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readACommand: $f.
	
	self assert: (marsRover hasPosition: 1@2 facing: self north).
! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 01:26:31'!
test04DecrementYAfterMovingBackwardWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readACommand: $b.
	
	self assert: (marsRover hasPosition: 1@0 facing: self north).
! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:44:20'!
test05FacingWestAfterRotatingLeftWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readACommand: $l.
	
	self assert: (marsRover hasPosition: 1@1 facing: self west).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:44:31'!
test06FacingEastAfterRotatingRightWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readACommand: $r.
	
	self assert: (marsRover hasPosition: 1@1 facing: self east).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:44:42'!
test07IncrementXAfterRotateRightAndMoveFowardWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readCommands: 'rf'.
	
	self assert: (marsRover hasPosition: 2@1 facing: self east).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:44:53'!
test08DecrementYAfterRotateRightTwoTimesAndMoveFowardWhenFacingNorth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readCommands: 'rrf'.
	
	self assert: (marsRover hasPosition: 1@0 facing: self south).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:45:04'!
test09RotateFourTimesLeftDoNotChangeOrientation
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self north.
	
	marsRover readCommands: 'llll'.
	
	self assert: (marsRover hasPosition: 1@1 facing: self north).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:45:17'!
test10MoveBackwardAndFowardLeavesInSamePlace
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self south.
	
	marsRover readCommands: 'bbff'.
	
	self assert: (marsRover hasPosition: 1@1 facing: self south).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:45:28'!
test11IncrementXFacingWestAfterRotatingRightAndMovingBackwardsFromSouth
	|marsRover|
	
	marsRover := MarsRover startOn: 1@1 facing: self south.
	
	marsRover readCommands: 'rb'.
	
	self assert: (marsRover hasPosition: 2@1 facing: self west).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:45:39'!
test12MovingHorizontallyAfterRotating180Degrees
	|marsRover|
	
	marsRover := MarsRover startOn: 2@2 facing: self west.
	
	marsRover readCommands: 'frrb'.
	
	self assert: (marsRover hasPosition: 0@2 facing: self east).! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:45:51'!
test13InvalidCommandNotAllowed
	|marsRover|
	
	marsRover := MarsRover startOn: 2@2 facing: self west.
	
	self 
		should: [ marsRover readACommand: $ñ.] 
		raise: Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MarsRover invalidCommandErrorDescription.
			self assert: (marsRover hasPosition: 2@2  facing: self west).]! !

!TestsMarsRover methodsFor: 'tests' stamp: 'DA 5/13/2023 00:46:00'!
test14OnlyExecutePreviousCommandsBeforeInvalidOne
	|marsRover|
	
	marsRover := MarsRover startOn: 2@2 facing: self west.
	
	self 
		should: [	marsRover readCommands: 'fyb'.]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: MarsRover invalidCommandErrorDescription.
			self assert: (marsRover hasPosition: 1@2 facing: self west).]
			 ! !


!TestsMarsRover methodsFor: 'facings' stamp: 'DA 5/13/2023 00:42:52'!
east
	^MarsRoverFacingEast ! !

!TestsMarsRover methodsFor: 'facings' stamp: 'DA 5/13/2023 00:42:28'!
north
	^MarsRoverFacingNorth! !

!TestsMarsRover methodsFor: 'facings' stamp: 'DA 5/13/2023 00:42:41'!
south
	^MarsRoverFacingSouth! !

!TestsMarsRover methodsFor: 'facings' stamp: 'DA 5/13/2023 00:43:01'!
west
	^MarsRoverFacingWest! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'actualPoint facing'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'instance creation' stamp: 'DA 5/13/2023 00:41:07'!
initializeStartOn: aPoint facing: aFacingType
	actualPoint := aPoint.
	facing := aFacingType for: self.! !


!MarsRover methodsFor: 'comparing' stamp: 'DA 5/12/2023 19:36:43'!
hasPosition: aPoint facing: anOrientation
	^ (self isActualPosition: aPoint)  and: (self isFacingTo: anOrientation)! !

!MarsRover methodsFor: 'comparing' stamp: 'DA 5/12/2023 22:19:00'!
isActualPosition: aPoint 
	^ actualPoint = aPoint! !

!MarsRover methodsFor: 'comparing' stamp: 'DA 5/13/2023 00:39:47'!
isFacingTo: aFacingType
	^ facing isFacing: aFacingType! !


!MarsRover methodsFor: 'sequence reader' stamp: 'DA 5/13/2023 01:25:16'!
readACommand: aCommand 
	(self isFowardCommand: aCommand) ifTrue: [^facing moveFoward].
	(self isBackwardCommand: aCommand) ifTrue: [^facing moveBackward].
	(self isRotateLeftCommand: aCommand) ifTrue: [^facing rotateLeft].
	(self isRotateRightCommand: aCommand) ifTrue: [^facing rotateRight		].
	(self isEmptyCommand: aCommand) ifFalse:[ self error: self class invalidCommandErrorDescription.].
! !

!MarsRover methodsFor: 'sequence reader' stamp: 'DA 5/12/2023 22:18:32'!
readCommands: aCommandSequence
	aCommandSequence do: [:command | self readACommand: command].
! !


!MarsRover methodsFor: 'command comparing' stamp: 'DA 5/13/2023 00:00:30'!
isBackwardCommand: aCommand
	^ aCommand = $b! !

!MarsRover methodsFor: 'command comparing' stamp: 'DA 5/13/2023 01:24:31'!
isEmptyCommand: aCommand
	^aCommand = ''! !

!MarsRover methodsFor: 'command comparing' stamp: 'DA 5/13/2023 00:00:20'!
isFowardCommand: aCommand
	^ aCommand = $f! !

!MarsRover methodsFor: 'command comparing' stamp: 'DA 5/13/2023 00:02:05'!
isRotateLeftCommand: aCommand
	^ aCommand = $l! !

!MarsRover methodsFor: 'command comparing' stamp: 'DA 5/13/2023 00:02:14'!
isRotateRightCommand: aCommand
	^ aCommand = $r! !


!MarsRover methodsFor: 'change facing' stamp: 'DA 5/13/2023 00:28:06'!
headEast
	facing := MarsRoverFacingEast for: self.! !

!MarsRover methodsFor: 'change facing' stamp: 'DA 5/13/2023 00:28:34'!
headNorth
	facing := MarsRoverFacingNorth for: self.! !

!MarsRover methodsFor: 'change facing' stamp: 'DA 5/13/2023 00:28:45'!
headSouth
	facing := MarsRoverFacingSouth for: self.! !

!MarsRover methodsFor: 'change facing' stamp: 'DA 5/13/2023 00:26:15'!
headWest
	facing := MarsRoverFacingWest for: self.! !


!MarsRover methodsFor: 'movements' stamp: 'DA 5/13/2023 00:22:50'!
moveEast
	actualPoint := actualPoint + (1@0)! !

!MarsRover methodsFor: 'movements' stamp: 'DA 5/13/2023 00:21:56'!
moveNorth
	actualPoint := actualPoint + (0@1)! !

!MarsRover methodsFor: 'movements' stamp: 'DA 5/13/2023 00:23:59'!
moveSouth
	actualPoint := actualPoint - (0@1)! !

!MarsRover methodsFor: 'movements' stamp: 'DA 5/13/2023 00:24:45'!
moveWest
	actualPoint := actualPoint - (1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'DA 5/12/2023 18:43:23'!
startOn: aPoint facing: orientation 
	^self new initializeStartOn: aPoint facing: orientation ! !


!MarsRover class methodsFor: 'error description' stamp: 'DA 5/12/2023 23:41:32'!
invalidCommandErrorDescription
	^ 'Comando erroneo'! !


!classDefinition: #MarsRoverFacing category: 'Mars Rover'!
Object subclass: #MarsRoverFacing
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverFacing methodsFor: 'initialize' stamp: 'DA 5/13/2023 00:08:36'!
initializeFor: aMarsRover
	marsRover := aMarsRover ! !


!MarsRoverFacing methodsFor: 'comparing' stamp: 'DA 5/13/2023 00:37:23'!
isFacing: aFacingType
	^self isKindOf: aFacingType ! !


!MarsRoverFacing methodsFor: 'moving' stamp: 'DA 5/13/2023 01:32:18'!
moveBackward
	^ self subclassResponsibility ! !

!MarsRoverFacing methodsFor: 'moving' stamp: 'DA 5/13/2023 01:32:23'!
moveFoward
	^ self subclassResponsibility ! !


!MarsRoverFacing methodsFor: 'rotating' stamp: 'DA 5/13/2023 01:32:31'!
rotateLeft
	^ self subclassResponsibility ! !

!MarsRoverFacing methodsFor: 'rotating' stamp: 'DA 5/13/2023 01:32:35'!
rotateRight
	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverFacing class' category: 'Mars Rover'!
MarsRoverFacing class
	instanceVariableNames: ''!

!MarsRoverFacing class methodsFor: 'instance creation' stamp: 'DA 5/13/2023 00:47:13'!
for: aMarsRover
	^ self new initializeFor: aMarsRover! !


!classDefinition: #MarsRoverFacingEast category: 'Mars Rover'!
MarsRoverFacing subclass: #MarsRoverFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverFacingEast methodsFor: 'moving' stamp: 'DA 5/13/2023 00:53:23'!
moveBackward
	^ marsRover moveWest ! !

!MarsRoverFacingEast methodsFor: 'moving' stamp: 'DA 5/13/2023 00:52:33'!
moveFoward
	^marsRover moveEast ! !


!MarsRoverFacingEast methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:54:34'!
rotateLeft
	^marsRover headNorth ! !

!MarsRoverFacingEast methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:57:32'!
rotateRight
	^marsRover headSouth! !


!classDefinition: #MarsRoverFacingNorth category: 'Mars Rover'!
MarsRoverFacing subclass: #MarsRoverFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverFacingNorth methodsFor: 'moving' stamp: 'DA 5/13/2023 00:53:34'!
moveBackward
	^marsRover moveSouth ! !

!MarsRoverFacingNorth methodsFor: 'moving' stamp: 'DA 5/13/2023 00:52:02'!
moveFoward
	^ marsRover moveNorth! !


!MarsRoverFacingNorth methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:56:12'!
rotateLeft
	^marsRover headWest! !

!MarsRoverFacingNorth methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:57:51'!
rotateRight
	^marsRover headEast ! !


!classDefinition: #MarsRoverFacingSouth category: 'Mars Rover'!
MarsRoverFacing subclass: #MarsRoverFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverFacingSouth methodsFor: 'moving' stamp: 'DA 5/13/2023 00:53:45'!
moveBackward
	^marsRover moveNorth ! !

!MarsRoverFacingSouth methodsFor: 'moving' stamp: 'DA 5/13/2023 00:52:46'!
moveFoward
	^marsRover moveSouth ! !


!MarsRoverFacingSouth methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:56:40'!
rotateLeft
	^marsRover headEast! !

!MarsRoverFacingSouth methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:58:11'!
rotateRight
	^marsRover headWest! !


!classDefinition: #MarsRoverFacingWest category: 'Mars Rover'!
MarsRoverFacing subclass: #MarsRoverFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRoverFacingWest methodsFor: 'moving' stamp: 'DA 5/13/2023 00:53:58'!
moveBackward
	^marsRover moveEast ! !

!MarsRoverFacingWest methodsFor: 'moving' stamp: 'DA 5/13/2023 00:52:57'!
moveFoward
	^marsRover moveWest ! !


!MarsRoverFacingWest methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:57:00'!
rotateLeft
	^marsRover headSouth ! !

!MarsRoverFacingWest methodsFor: 'rotating' stamp: 'DA 5/13/2023 00:58:31'!
rotateRight
	^marsRover headNorth! !
