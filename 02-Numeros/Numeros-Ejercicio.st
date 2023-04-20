!classDefinition: #NumeroTest category: 'Numeros-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:01:02'!
addEntero: aInteger
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:00:58'!
addFraccion: aFraction
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:01:07'!
divideEntero: aDividend
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:01:10'!
divideFraccion: aDividend
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:01:15'!
multiplyEntero: aMultiplier
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:01:18'!
multiplyFraccion: aMultiplier
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 01:12:46'!
subtractEntero: aSubtrahend
	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 01:13:30'!
subtractFraccion: aSubtrahend
	self subclassResponsibility ! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numeros-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:29:31'!
* aMultiplier 
	
	^aMultiplier multiplyEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:29:58'!
+ anAdder 
	
	^anAdder addEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 01:15:17'!
- aSubtrahend 
	
	^ aSubtrahend subtractEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:31:42'!
/ aDivisor 
	
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:32:19'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:35:05'!
addEntero: aInteger
	^Entero with: value + aInteger integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:35:44'!
addFraccion: aFraction
	^ aFraction addEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:40:05'!
divideAndSimplify: aDividend
	^Fraccion with: aDividend over: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:38:41'!
divideEntero: aDividend
	|greatestCommonDivisor numerator denominator|
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: self. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := self // greatestCommonDivisor.
	
	^ denominator divideAndSimplify: numerator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:37:07'!
divideFraccion: aDividend
	^ aDividend numerator / (aDividend denominator * self)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:33:43'!
fibonacci
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/20/2023 00:03:26'!
greatestCommonDivisorWith: anEntero 
	^Entero with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:41:37'!
multiplyEntero: aMultiplier
	^Entero with: value * aMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:41:07'!
multiplyFraccion: aMultiplier
	^ aMultiplier multiplyEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:44:12'!
subtractEntero: aSubtrahend
	^ Entero with: aSubtrahend integerValue - value
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 20:43:16'!
subtractFraccion: aSubtrahend
	^ (aSubtrahend numerator - (aSubtrahend denominator * self)) / aSubtrahend denominator ! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'DA 4/20/2023 00:43:00'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger'. ].
	^ (self subclasses detect: [ :aEnteroSubclass | aEnteroSubclass isSubclassOf: aValue]) initializedInstance initalizeWith: aValue.! !


!Entero class methodsFor: 'subclass selectors' stamp: 'DA 4/20/2023 00:09:53'!
isSubclassOf: aValue
	self subclassResponsibility! !


!classDefinition: #EnteroCero category: 'Numeros-Ejercicio'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:14:43'!
* aMultiplier
	^self! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:15:36'!
+ anAdder
	^anAdder! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:25:44'!
- aSubtrahend
	^aSubtrahend negated! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:16:45'!
/ aDivisor
	^self! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:16:55'!
// aDivisor
	^self! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:19:05'!
addEntero: aInteger
	^aInteger ! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:20:21'!
addFraccion: aFraction
	^aFraction ! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:21:29'!
divideAndSimplify: aDividend
	self error: Numero canNotDivideByZeroErrorDescription! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:20:59'!
divideFraccion: aDividend
	self error: Numero canNotDivideByZeroErrorDescription! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:21:10'!
divideInteger: aDividend
	self error: Numero canNotDivideByZeroErrorDescription! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:21:57'!
fibonacci
	^Entero with: 1! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:23:31'!
greatestCommonDivisorWith: anInteger
	^Entero with: (0 gcd: anInteger integerValue)! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:24:37'!
multiplyEntero: aMultiplier
	^self! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:24:05'!
multiplyFraccion: aMultiplier
	^ self! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:26:37'!
subtractEntero: aSubtrahend
	^ aSubtrahend ! !

!EnteroCero methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:26:23'!
subtractFraccion: aSubtrahend
	^ aSubtrahend ! !


!EnteroCero methodsFor: 'value' stamp: 'DA 4/19/2023 23:27:09'!
integerValue	
	^0! !


!EnteroCero methodsFor: 'printing' stamp: 'DA 4/19/2023 23:27:46'!
printOn: aStream
	aStream print: 0! !


!EnteroCero methodsFor: 'testing' stamp: 'DA 4/19/2023 23:28:08'!
isNegative	
	^false! !

!EnteroCero methodsFor: 'testing' stamp: 'DA 4/19/2023 23:28:27'!
isOne	
	^false! !

!EnteroCero methodsFor: 'testing' stamp: 'DA 4/19/2023 23:28:40'!
isZero	
	^true! !


!EnteroCero methodsFor: 'comparing' stamp: 'DA 4/19/2023 23:29:08'!
= anObject
	^(anObject isKindOf: self class) and: [ 0 = anObject integerValue ]! !

!EnteroCero methodsFor: 'comparing' stamp: 'DA 4/19/2023 23:29:18'!
hash
	^0 hash! !


!EnteroCero methodsFor: 'initialization' stamp: 'DA 4/19/2023 23:32:08'!
initialize
	"value := 0"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCero class' category: 'Numeros-Ejercicio'!
EnteroCero class
	instanceVariableNames: ''!

!EnteroCero class methodsFor: 'subclass selectors' stamp: 'DA 4/19/2023 23:33:31'!
isSubclassOf: aValue
	^aValue = 0! !


!classDefinition: #EnteroMayorAUno category: 'Numeros-Ejercicio'!
Entero subclass: #EnteroMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!EnteroMayorAUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:35:05'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.

	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMayorAUno class' category: 'Numeros-Ejercicio'!
EnteroMayorAUno class
	instanceVariableNames: ''!

!EnteroMayorAUno class methodsFor: 'subclass selectors' stamp: 'DA 4/19/2023 23:35:38'!
isSubclassOf: aValue
	^aValue > 1! !


!classDefinition: #EnteroNegativo category: 'Numeros-Ejercicio'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!EnteroNegativo methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:36:37'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroNegativo class' category: 'Numeros-Ejercicio'!
EnteroNegativo class
	instanceVariableNames: ''!

!EnteroNegativo class methodsFor: 'subclass selectors' stamp: 'DA 4/19/2023 23:37:33'!
isSubclassOf: aValue
	^aValue < 0! !


!classDefinition: #EnteroUno category: 'Numeros-Ejercicio'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:38:41'!
* aMultiplier
	^aMultiplier ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:38:16'!
// aDivisor
	^self! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:39:29'!
addEntero: aInteger
	^Entero with: 1 + aInteger integerValue! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:40:35'!
divideAndSimplify: aDividend
	^aDividend ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:46:05'!
divideEntero: aDividend
	^aDividend ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:46:11'!
divideFraccion: aDividend
	^aDividend ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:38:16'!
fibonacci
	^Entero with: 1! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:41:59'!
greatestCommonDivisorWith: anInteger
	^self! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:45:15'!
multiplyEntero: aMultiplier
	^aMultiplier ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:45:20'!
multiplyFraccion: aMultiplier
	^ aMultiplier ! !

!EnteroUno methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:45:43'!
subtractEntero: aSubtrahend
	^ Entero with: aSubtrahend integerValue - 1! !


!EnteroUno methodsFor: 'value' stamp: 'DA 4/19/2023 23:48:07'!
integerValue	
	^1! !


!EnteroUno methodsFor: 'printing' stamp: 'DA 4/19/2023 23:48:17'!
printOn: aStream
	aStream print: 1! !


!EnteroUno methodsFor: 'testing' stamp: 'DA 4/19/2023 23:38:16'!
isNegative	
	^false! !

!EnteroUno methodsFor: 'testing' stamp: 'DA 4/19/2023 23:46:43'!
isOne	
	^true! !

!EnteroUno methodsFor: 'testing' stamp: 'DA 4/19/2023 23:46:38'!
isZero	
	^false! !


!EnteroUno methodsFor: 'comparing' stamp: 'DA 4/19/2023 23:47:08'!
= anObject
	^(anObject isKindOf: self class) and: [ 1 = anObject integerValue ]! !

!EnteroUno methodsFor: 'comparing' stamp: 'DA 4/19/2023 23:47:18'!
hash
	^1 hash! !


!EnteroUno methodsFor: 'initialization' stamp: 'DA 4/19/2023 23:47:27'!
initialize
	"value := 1"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroUno class' category: 'Numeros-Ejercicio'!
EnteroUno class
	instanceVariableNames: ''!

!EnteroUno class methodsFor: 'subclass selectors' stamp: 'DA 4/19/2023 23:47:52'!
isSubclassOf: aValue
	^aValue = 1! !


!classDefinition: #Fraccion category: 'Numeros-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:50:21'!
* aMultiplier 
	
	^ aMultiplier multiplyFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:50:43'!
+ anAdder 
	^ anAdder addFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:51:03'!
- aSubtrahend 
	^ aSubtrahend subtractFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:51:25'!
/ aDivisor 
	
	^aDivisor divideFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:52:20'!
addEntero: anInteger
	^ numerator + (denominator * anInteger) / denominator
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:51:55'!
addFraccion: aFraction	
	| newNumerator newDenominator |	
	newNumerator := (numerator * aFraction denominator) + (denominator * aFraction numerator).
	newDenominator := denominator * aFraction denominator.	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:52:59'!
divideEntero: aDividend
	^ (aDividend * denominator) / numerator
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:52:42'!
divideFraccion: aDividend
	^ (aDividend numerator * denominator) / (aDividend denominator * numerator)
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:53:37'!
multiplyEntero: aMultiplier
	^ aMultiplier * numerator / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:53:18'!
multiplyFraccion: aMultiplier
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:54:39'!
subtractEntero: aMinuend
	^  (aMinuend * denominator) - numerator / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'DA 4/19/2023 23:54:23'!
subtractFraccion: aSubtrahend
	| newNumerator newDenominator |	
	newNumerator := (aSubtrahend numerator * denominator) - (aSubtrahend denominator * numerator).
	newDenominator := aSubtrahend denominator * denominator.	
	^newNumerator / newDenominator! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'instance creation' stamp: 'DA 4/19/2023 23:56:29'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^self new initializeWith: numerator over: denominator
	! !
