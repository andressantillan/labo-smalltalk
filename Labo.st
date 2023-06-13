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

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/12/2023 23:48:33'!
infligir: puntos a: unTanque
	|cantidadTripulantesMueren|
	cantidadTripulantesMueren := puntos // 50.
	cantidadTripulantesMueren > 0 ifTrue:[unTanque quitarTripulantes: cantidadTripulantesMueren].
	unTanque blindaje: (unTanque blindaje - puntos).! !

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 18:57:01'!
initialize
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Misil class' category: 'Labo'!
Misil class
	instanceVariableNames: 'quitarTripulante'!


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
	instanceVariableNames: 'nombre modelo cantidadTripulantes blindaje arsenal velocidadActual'
	classVariableNames: 'CantidadMaximaTripulantes VelocidadMaxima'
	poolDictionaries: ''
	category: 'Labo'!

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:26:32'!
arsenal
	^arsenal.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/12/2023 00:07:13'!
arsenal: unArsenaldeArmas
	arsenal := unArsenaldeArmas.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 00:14:18'!
atacarTanque: otroTanque
	"En el arsenal, siempre se toma el primer misil disponible, y al final del metodo
	se quita"
	
	|unMisil promedioVelocidad danio|
	self puedoDisparar ifTrue:[
		unMisil := self arsenal ifEmpty: [^ 'Arsenal vacio, no hay misiles.'] ifNotEmpty:[self arsenal first].
		danio := unMisil danio.
		(self estoyEnMovimiento  | otroTanque estoyEnMovimiento ) ifTrue: [
			promedioVelocidad := (self velocidadActual + otroTanque velocidadActual)//2.
			danio := danio - (unMisil calcularReduccionDanio: promedioVelocidad).
		].
		unMisil infligir: danio a: otroTanque.
		self arsenal removeAt: 1.	
	] 
	ifFalse:[ ^'No puedo disparar'].
	! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:12'!
blindaje
	^blindaje.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 20:10:47'!
blindaje: unNumero
	blindaje := unNumero.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:56:47'!
cantidadMaximaTripulantes
	^CantidadMaximaTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:48:10'!
cantidadTripulantes
	^cantidadTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:13:37'!
cantidadTripulantes: cantidad
	cantidadTripulantes := cantidad.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:42:46'!
emitoCalor
	^ self estoyEnMovimiento | (cantidadTripulantes > 3).! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:26:54'!
estoyEnMovimiento
	^self velocidadActual > 0.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:42:46'!
estoyFueraDeCombate
	^cantidadTripulantes == 0.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:10:26'!
initialize
	self subclassResponsibility.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:19'!
modelo
	^modelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:49:01'!
modelo: unModelo
	modelo := unModelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:11:55'!
movermeA: unaVelocidad
	self velocidadActual: unaVelocidad.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:01'!
nombre
	^nombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:48:30'!
nombre: unNombre
	nombre := unNombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:42:46'!
puedoDisparar
	^cantidadTripulantes >= 3 & self estoyEnMovimiento.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:10:49'!
quitarTripulantes: cantidad
	cantidad >= self cantidadTripulantes 
	ifTrue: [^self cantidadTripulantes: 0].
	self cantidadTripulantes: (self cantidadTripulantes - cantidad).! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:08:17'!
velocidadActual
	^velocidadActual.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:12:45'!
velocidadActual: unaVelocidad
	unaVelocidad >= 0 ifTrue:[
		unaVelocidad >= VelocidadMaxima 
		ifTrue:[ velocidadActual:= VelocidadMaxima]
		ifFalse:[ velocidadActual:= unaVelocidad ].
	].! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:39:32'!
velocidadMaxima
	^VelocidadMaxima.! !


!classDefinition: #TanqueLiviano category: 'Labo'!
Tanque subclass: #TanqueLiviano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueLiviano methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:54:37'!
initialize	
	CantidadMaximaTripulantes := 5.
	
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 100.
	arsenal := OrderedCollection new.
	VelocidadMaxima := 70.
	
	velocidadActual := 0.! !


!classDefinition: #TanquePesado category: 'Labo'!
Tanque subclass: #TanquePesado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanquePesado methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:55:10'!
initialize	
	CantidadMaximaTripulantes := 4.
	
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 150.
	arsenal := OrderedCollection new.
	VelocidadMaxima := 50.
	
	velocidadActual := 0.! !


!classDefinition: #TanqueRapido category: 'Labo'!
Tanque subclass: #TanqueRapido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueRapido methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:55:43'!
initialize	
	CantidadMaximaTripulantes := 3.
	
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 75.
	arsenal := OrderedCollection new.
	VelocidadMaxima := 100.
	
	velocidadActual := 0.! !


!classDefinition: #Unidad category: 'Labo'!
Object subclass: #Unidad
	instanceVariableNames: 'nombre tanques'
	classVariableNames: 'CantidadTanques'
	poolDictionaries: ''
	category: 'Labo'!

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:16:18'!
initialize
	tanques := OrderedCollection new.
	CantidadTanques := 5.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 00:24:03'!
nombre
	^nombre.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 00:24:25'!
nombre: unNombre
	nombre := unNombre.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:31:59'!
tanques
	^tanques.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 00:22:28'!
tanques: unaColecciondeTanques
	unaColecciondeTanques size > CantidadTanques 
	ifTrue:[^'Solo se permiten', CantidadTanques asString ,' tanques.'].
	tanques := unaColecciondeTanques.! !
