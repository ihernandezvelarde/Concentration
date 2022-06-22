//
//  Card.swift
//  Concentration
//
//  Created by Irene Hernández on 21/6/22.
//

import Foundation

struct Card : Hashable { 
    var hashValue: Int {return identifier}
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isFaceUp = false //Está de cara para arriba? boleano inicializado a falso
    var isMatched = false //Son  iguales ? bloseano inicializado a falso
    private var identifier : Int //identificador para cada carta (unico)
    private static var identifierFactory = 0 //inicializamos una variable que será con la que crearemos el ID
    private static func getUniqueIdentifier() -> Int{ //funcion que genera ID
        identifierFactory += 1 //decimos que nuestra variable es igual a si misma +1 así nunca repetiremos ID
        return identifierFactory //Retornamos ID generada
    }
    init(){ //para que funcione todo debe estar inicializado  y en nuestro caso tenemos isFaceUp y isMached inicializados a false pero identifier no, por lo que usaremos el metodo init
        self.identifier = Card.getUniqueIdentifier() //Le diremos que nuestra variable identifier es igual al metodo que genera las ID
    }
}
