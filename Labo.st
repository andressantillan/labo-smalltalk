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

!Misil methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 17:12:03'!
infligir: puntos a: unTanque
	|cantidadTripulantesMueren|
	cantidadTripulantesMueren := puntos // 50.
	cantidadTripulantesMueren > 0 ifTrue:[unTanque quitarTripulantes: cantidadTripulantesMueren].
	unTanque disminuirBlindaje: (unTanque blindaje - puntos).! !

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

!Bazooka methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:35:52'!
bazookaConCabezasNucleares: cantidad
	|bazooka|
	bazooka := Bazooka new.
	^bazooka cantidadCabezasNucleares: cantidad.! !

!Bazooka methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:26:57'!
cantidadCabezasNucleares
	^cantidadCabezasNucleares.! !

!Bazooka methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:27:39'!
cantidadCabezasNucleares: unNumero
	cantidadCabezasNucleares := unNumero.! !

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

!MisilTermico methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 15:33:20'!
danio
	^self class danio. ! !

!MisilTermico methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 23:35:07'!
infligir: puntos a: unTanque
	(unTanque estoyEnMovimiento | unTanque cantidadDeTripulantes  > 3)
		ifTrue:[super infligir: puntos a: unTanque].! !

!MisilTermico methodsFor: 'as yet unclassified' stamp: 'afs 6/11/2023 17:13:06'!
initialize
	danio := 25.
	reduccionDanio := 0.
	reduccionPorKm := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MisilTermico class' category: 'Labo'!
MisilTermico class
	instanceVariableNames: 'danio'!

!MisilTermico class methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:15:10'!
danio
	danio ifNil:[ danio := 25].
	^danio.! !

!MisilTermico class methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 15:31:06'!
initialize
	danio := 25.! !


!classDefinition: #Tanque category: 'Labo'!
Object subclass: #Tanque
	instanceVariableNames: 'nombre modelo cantidadTripulantes blindaje arsenal velocidadActual'
	classVariableNames: 'CantidadMaximaTripulantes CantidadMisiles VelocidadMaxima'
	poolDictionaries: ''
	category: 'Labo'!

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:26:32'!
arsenal
	^arsenal.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 22:57:01'!
arsenal: unArsenaldeArmas
	unArsenaldeArmas size > CantidadMisiles 
	ifTrue: [^'Solo se admite un arsenal de ', self cantidadMisiles asString,' misiles.' ].
	arsenal := unArsenaldeArmas.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 17:08:58'!
atacarTanque: otroTanque
	"En el arsenal, siempre se toma el primer misil disponible, y al final del metodo
	se quita"
	
	|unMisil danio|
	self puedoDisparar ifTrue:[
		unMisil := self arsenal ifEmpty: [^ 'Arsenal vacio, no hay misiles.'] ifNotEmpty:[self arsenal first].
		danio := unMisil danio - self reduccionDanio: unMisil contra: otroTanque.
		unMisil infligir: danio a: otroTanque.
		self arsenal removeAt: 1.	
	] 
	ifFalse:[ ^'No puedo disparar'].
	! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:25:50'!
atacarUnidad: unaUnidad
	|tanquesVivos|
	tanquesVivos := unaUnidad tanques select:[:t | t estoyFueraDeCombate not].
	tanquesVivos ifEmpty:[^'La unidad no tiene tanques vivos'].
	self atacarTanque: tanquesVivos first.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:12'!
blindaje
	^blindaje.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 20:10:47'!
blindaje: unNumero
	blindaje := unNumero.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:46'!
cantidadDeTripulantes
	^cantidadDeTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:56:47'!
cantidadMaximaTripulantes
	^CantidadMaximaTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 22:50:16'!
cantidadMisiles
	^CantidadMisiles.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:48:10'!
cantidadTripulantes
	^cantidadTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:13:37'!
cantidadTripulantes: cantidad
	cantidadTripulantes := cantidad.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 17:10:57'!
disminuirBlindaje: puntos
	^self blindaje: puntos.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 16:42:46'!
emitoCalor
	^ self estoyEnMovimiento | (cantidadTripulantes > 3).! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/10/2023 19:26:54'!
estoyEnMovimiento
	^self velocidadActual > 0.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 15:49:51'!
estoyFueraDeCombate
	^ (blindaje == 0)|(cantidadTripulantes == 0).! !

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

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 17:07:37'!
reduccionDanio: unMisil contra: unTanque
	|promedioVelocidad reduccionDanio|
	reduccionDanio := 0.
	(self estoyEnMovimiento  | unTanque estoyEnMovimiento ) ifTrue: [
		promedioVelocidad := (self velocidadActual + unTanque velocidadActual)//2.
		reduccionDanio := unMisil calcularReduccionDanio: promedioVelocidad
	].
	^reduccionDanio.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 18:40:34'!
tengoMunicion
	^self arsenal size > 0.! !

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


!classDefinition: #TanqueBlindajeEM category: 'Labo'!
Tanque subclass: #TanqueBlindajeEM
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueBlindajeEM methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 17:14:55'!
disminuirBlindaje: puntos
	super disminuirBlindaje: (puntos * 0.8).! !

!TanqueBlindajeEM methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 16:53:05'!
initialize
	CantidadMaximaTripulantes := 5.
	CantidadMisiles := 15.
	VelocidadMaxima := 70.
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 100.
	arsenal := OrderedCollection new.
	velocidadActual := 0.! !


!classDefinition: #TanqueDron category: 'Labo'!
Tanque subclass: #TanqueDron
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueDron methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 17:33:09'!
initialize	
	|bazooka|
	CantidadMaximaTripulantes := 0.
	CantidadMisiles := 15.
	VelocidadMaxima := 100.
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 75.
	bazooka := Bazooka bazookaConCabezasNucleares: 4.
	arsenal := {
		bazooka. bazooka. bazooka. 
		bazooka. bazooka. bazooka. 
		bazooka. bazooka. bazooka. 
		bazooka. bazooka. bazooka. 
		bazooka. bazooka.} asOrderedCollection.
	velocidadActual := 0.! !

!TanqueDron methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 17:13:36'!
reduccionDanio: unMisil contra: unTanque
	^0.! !


!classDefinition: #TanqueLiviano category: 'Labo'!
Tanque subclass: #TanqueLiviano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueLiviano methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 22:51:07'!
initialize
	CantidadMaximaTripulantes := 5.
	CantidadMisiles := 15.
	VelocidadMaxima := 70.
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 100.
	arsenal := OrderedCollection new.
	velocidadActual := 0.! !


!classDefinition: #TanquePesado category: 'Labo'!
Tanque subclass: #TanquePesado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanquePesado methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 22:51:48'!
initialize
	CantidadMaximaTripulantes := 4.
	CantidadMisiles := 20.
	VelocidadMaxima := 50.
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 150.
	arsenal := OrderedCollection new.
	velocidadActual := 0.! !


!classDefinition: #TanqueRapido category: 'Labo'!
Tanque subclass: #TanqueRapido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueRapido methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 17:20:39'!
initialize
	CantidadMaximaTripulantes := 0.
	CantidadMisiles := 10.
	VelocidadMaxima := 100.
	cantidadTripulantes := CantidadMaximaTripulantes.
	blindaje := 75.
	arsenal := OrderedCollection new.
	velocidadActual := 0.! !


!classDefinition: #Unidad category: 'Labo'!
Object subclass: #Unidad
	instanceVariableNames: 'nombre tanques'
	classVariableNames: 'CantidadTanques'
	poolDictionaries: ''
	category: 'Labo'!

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 18:24:37'!
atacarUnidad: unaUnidad
	self tanques select:[ :t | t estoyFueraDeCombate not ]
	thenDo:[ :t | t atacarUnidad: unaUnidad ].! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 19:12:10'!
batallaEntre: unaUnidad y: otraUnidad
	|unidadAtaca unidadEnEspera|
	unidadAtaca := unaUnidad.
	unidadEnEspera := otraUnidad.
	(unaUnidad estoyFueraDeCombate not | otraUnidad estoyFueraDeCombate) 
	whileTrue:[
		unidadAtaca atacarUnidad: unidadEnEspera.
		unidadAtaca := unidadEnEspera.
		unidadEnEspera := unidadAtaca. 	
	].! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 18:51:49'!
estoyFueraDeCombate
	^self hayTanquesEnCombate  | self tienenMunicionLosTanques.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 18:36:06'!
hayTanquesEnCombate
	^self tanques select:[ :t | t estoyFueraDeCombate not] size > 0.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/13/2023 17:16:18'!
initialize
	tanques := OrderedCollection new.
	CantidadTanques := 5.! !

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/15/2023 15:23:54'!
moverseA: unaVelocidad
	self tanques 
		select:[ :t | t estoyFueraDeCombate not ]
		thenDo: [ :t | t movermeA: unaVelocidad ].! !

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

!Unidad methodsFor: 'as yet unclassified' stamp: 'afs 6/16/2023 18:40:59'!
tienenMunicionLosTanques
	^self tanques select: [ :t | t tengoMunicion ] size > 0.! !

MisilTermico initialize!