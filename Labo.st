!classDefinition: #Tanque category: 'Labo'!
Object subclass: #Tanque
	instanceVariableNames: 'nombre modelo cantidadDeTripulantes blindaje arsenal velocidadMaxima'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:26:32'!
arsenal
	^arsenal.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 19:40:24'!
arsenal: unArsenaldeArmas
	unArsenaldeArmas  size. 
	arsenal := unArsenaldeArmas.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:12'!
blindaje
	^blindaje.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:46'!
cantidadDeTripulantes
	^cantidadDeTripulantes.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:59:29'!
initialize
	self subclassResponsibility.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:19'!
modelo
	^modelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:49:01'!
modelo: unModelo
	modelo := unModelo.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:46:01'!
nombre
	^nombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/8/2023 15:48:30'!
nombre: unNombre
	nombre := unNombre.! !

!Tanque methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:25:48'!
velocidadMaxima
	^velocidadMaxima.! !


!classDefinition: #TanqueLiviano category: 'Labo'!
Tanque subclass: #TanqueLiviano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueLiviano methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:50:09'!
initialize
	cantidadDeTripulantes := 5.
	blindaje := 100.
	arsenal := OrderedCollection new.
	velocidadMaxima := 70.! !


!classDefinition: #TanquePesado category: 'Labo'!
Tanque subclass: #TanquePesado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanquePesado methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:59:50'!
initialize
	cantidadDeTripulantes := 4.
	blindaje := 150.
	arsenal := OrderedCollection new.
	velocidadMaxima := 50.! !


!classDefinition: #TanqueRapido category: 'Labo'!
Tanque subclass: #TanqueRapido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Labo'!

!TanqueRapido methodsFor: 'as yet unclassified' stamp: 'afs 6/9/2023 18:49:52'!
initialize
	cantidadDeTripulantes := 3.
	blindaje := 75.
	arsenal := OrderedCollection new.
	velocidadMaxima := 100.! !


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
