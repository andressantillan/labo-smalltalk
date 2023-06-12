!classDefinition: #Misil category: 'Labo'!
Object subclass: #Misil
	instanceVariableNames: 'danio reduccionPorKm reduccionDanio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 17:45:24'!
calcularReduccionDanio: velocidadPromedio
	^((velocidadPromedio/reduccionPorKm)*reduccionDanio).! !

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 18:58:33'!
danio
	^danio.! !

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 23:33:09'!
infligir: puntos a: unTanque
	unTanque blindaje: (unTanque blindaje - puntos).! !

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 18:57:01'!
initialize
	self subclassResponsibility.! !


!classDefinition: #Bazooka category: 'Labo'!
Misil subclass: #Bazooka
	instanceVariableNames: 'cantidadCabezasNucleares'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!Bazooka methodsFor: 'as yet unclassified' stamp: 'afs 6/12/2023 16:34:29'!
danio
	^ 2 * cantidadCabezasNucleares  * danio.! !

!Bazooka methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 17:12:34'!
initialize
	danio := 5.
	cantidadCabezasNucleares := 4.
	reduccionDanio := 2.
	reduccionPorKm  := 5.! !


!classDefinition: #CoheteGrosso category: 'Labo'!
Misil subclass: #CoheteGrosso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!CoheteGrosso methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 17:13:25'!
initialize
	danio := 100.
	reduccionDanio  := 3.
	reduccionPorKm  := 5.! !


!classDefinition: #MisilTermico category: 'Labo'!
Misil subclass: #MisilTermico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!MisilTermico methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 23:35:07'!
infligir: puntos a: unTanque
	(unTanque estoyEnMovimiento | unTanque cantidadDeTripulantes  > 3)
		ifTrue:[super infligir: puntos a: unTanque].! !

!MisilTermico methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 17:13:06'!
initialize
	danio := 25.
	reduccionDanio := 0.
	reduccionPorKm := 0.! !


!classDefinition: #Tanque category: 'Labo'!
Object subclass: #Tanque
	instanceVariableNames: 'nombre modelo cantidadDeTripulantes blindaje arsenal velocidadActual velocidadMaxima'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:26:32'!
arsenal
	^arsenal.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/12/2023 00:07:13'!
arsenal: unArsenaldeArmas
	arsenal := unArsenaldeArmas.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/12/2023 17:03:58'!
atacarTanque: otroTanque
	"En el arsenal, siempre se toma el primer misil disponible, y al final del metodo
	se quita"
	
	|unMisil promedioVelocidad danio|
	unMisil := self arsenal ifEmpty: [^ 'Arsenal vacio, no hay misiles.'] ifNotEmpty:[self arsenal first].
	danio := unMisil danio.
	(self estoyEnMovimiento  | otroTanque estoyEnMovimiento ) ifTrue: [
		promedioVelocidad := (self velocidadActual + otroTanque velocidadActual)//2.
		danio := danio - (unMisil calcularReduccionDanio: promedioVelocidad).
	].
	unMisil infligir: danio a: otroTanque.
	self arsenal removeAt: 1.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:12'!
blindaje
	^blindaje.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 20:10:47'!
blindaje: unNumero
	blindaje := unNumero.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:46'!
cantidadDeTripulantes
	^cantidadDeTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:36:37'!
emitoCalor
	^ self estoyEnMovimiento | (cantidadDeTripulantes > 3).! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:26:54'!
estoyEnMovimiento
	^self velocidadActual > 0.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:10:26'!
initialize
	self subclassResponsibility.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:19'!
modelo
	^modelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:49:01'!
modelo: unModelo
	modelo := unModelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:31:03'!
movermeA: unaVelocidad
	unaVelocidad >= 0 ifTrue:[
		unaVelocidad >= velocidadMaxima 
		ifTrue:[self velocidadActual: velocidadMaxima]
		ifFalse:[self velocidadActual: unaVelocidad ].
	].! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:01'!
nombre
	^nombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:48:30'!
nombre: unNombre
	nombre := unNombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:08:17'!
velocidadActual
	^velocidadActual.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:08:49'!
velocidadActual: unaVelocidad
	velocidadActual := unaVelocidad.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:48'!
velocidadMaxima
	^velocidadMaxima.! !


!classDefinition: #TanqueLiviano category: 'Labo'!
Tanque subclass: #TanqueLiviano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueLiviano methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:10:42'!
initialize
	cantidadDeTripulantes := 5.
	blindaje := 100.
	arsenal := OrderedCollection new.
	velocidadMaxima := 70.
	
	velocidadActual := 0.! !


!classDefinition: #TanquePesado category: 'Labo'!
Tanque subclass: #TanquePesado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanquePesado methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:11:00'!
initialize
	cantidadDeTripulantes := 4.
	blindaje := 150.
	arsenal := OrderedCollection new.
	velocidadMaxima := 50.
	
	velocidadActual := 0.! !


!classDefinition: #TanqueRapido category: 'Labo'!
Tanque subclass: #TanqueRapido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueRapido methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:11:12'!
initialize
	cantidadDeTripulantes := 3.
	blindaje := 75.
	arsenal := OrderedCollection new.
	velocidadMaxima := 100.
	
	velocidadActual := 0.! !


!classDefinition: #Unidad category: 'Labo'!
Object subclass: #Unidad
	instanceVariableNames: 'tanques'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:32:15'!
initialize
	tanques := OrderedCollection new.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:31:59'!
tanques
	^tanques.! !
