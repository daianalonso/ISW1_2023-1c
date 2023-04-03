!classDefinition: #I category: 'PeanoCloning'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'PeanoCloning'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:00:37'!
next
	^II.! !

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:59:30'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:16:15'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:13:50'!
+ aNaturalNumber
	^aNaturalNumber next.! !

!I class methodsFor: 'arithmetic operations' stamp: 'DA 3/27/2023 21:54:42'!
- aNaturalNumber
	^aNaturalNumber previous! !

!I class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:42:39'!
/ aNaturalNumber
	aNaturalNumber = self ifTrue: [^self.]. ! !


!classDefinition: #II category: 'PeanoCloning'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'PeanoCloning'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:17:37'!
* aNaturalNumber
	^ self previous * aNaturalNumber + aNaturalNumber! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:27:09'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!II class methodsFor: 'arithmetic operations' stamp: 'JFGO 3/25/2023 19:58:08'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!II class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:43:59'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	^ (self - aNaturalNumber / aNaturalNumber) next.! !


!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/26/2023 11:19:10'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:25:46'!
previous
	^previous.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:36:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 20:54:19'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'DA 4/3/2023 16:08:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'PeanoCloning'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'PeanoCloning'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:33'!
* aNaturalNumber
	^ self previous * aNaturalNumber + aNaturalNumber! !

!III class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:33'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!III class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:33'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!III class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:33'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	^ (self - aNaturalNumber / aNaturalNumber) next.! !


!III class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:33'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:33'!
previous
	^previous.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:33'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!III class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:33'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'DA 4/3/2023 16:08:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'PeanoCloning'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:40'!
* aNaturalNumber
	^ self previous * aNaturalNumber + aNaturalNumber! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:40'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:40'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:40'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	^ (self - aNaturalNumber / aNaturalNumber) next.! !


!IIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:40'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:40'!
previous
	^previous.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:40'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:40'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'DA 4/3/2023 16:08:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'PeanoCloning'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PeanoCloning'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'PeanoCloning'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:50'!
* aNaturalNumber
	^ self previous * aNaturalNumber + aNaturalNumber! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:50'!
+ aNaturalNumber
	^self previous + aNaturalNumber next.! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 02:31:50'!
- aNaturalNumber
	^aNaturalNumber subtractFrom: self.! !

!IIIII class methodsFor: 'arithmetic operations' stamp: 'DA 3/30/2023 20:18:56'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^self].
	^ (self - aNaturalNumber / aNaturalNumber) next.! !


!IIIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:51'!
next
	next ifNil: [
		next := self cloneNamed: self name, 'I'. 
		next previous: self.		
		].
	
	^next.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:51'!
previous
	^previous.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:51'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!IIIII class methodsFor: 'private auxiliary operations' stamp: 'DA 3/30/2023 02:31:51'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous - self previous.! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'DA 4/3/2023 16:08:44'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!