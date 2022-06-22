//
//  Concentration.swift
//  Concentration
//
//  Created by Irene Hernández on 21/6/22.
//

import Foundation

struct Concentration //Clase Concentration
{
   private(set) var cards = [Card]() //Creamos array de tipo Card
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter{ cards[$0].isFaceUp}.oneAndOnly
           // var foundIndex: Int?
           // for index in cards.indices{
              //  if cards[index].isFaceUp{
               //     if foundIndex == nil{
              //          foundIndex = index
              //      }else{
             //           return nil
            //        }
           //     }
          //  }
         //   return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    mutating func chooseCard(at index: Int) { //creamos funcion escoger carta al que le pasamos un indice de tipo int (Le pasamos una posicion del array)
        assert(cards.indices.contains(index),"Concentration.chooseCard(at:\(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int) { // Creamos un metodo que iniciamos y le pasamos el nombre de una variable de tipo int
        assert(numberOfPairsOfCards > 0,"Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")

        for _ in 1...numberOfPairsOfCards { //for lo que sea de 1 a el numero de elementos en el array
            let card = Card() //creamos constante y le decimos que es igual a nuestro array de cartas
            cards += [card,card]// y le añadimos copias de este
        }
       //TODO: Shuffle the cards
        
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
