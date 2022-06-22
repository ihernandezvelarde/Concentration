//
//  ViewController.swift
//  Concentration
//
//  Created by Irene Hernández on 20/6/22.
//

import UIKit

class ViewController: UIViewController {
    
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    //creamos una variable llamada game que se iniciara cuando se la llame que será igual a nuestra Clase concentration dandole valor a la variable numberOfParisOfCards, le decimos que  es la variable de abajo que es de tipo int y cuenta nuestros botones + 1 / 2 ya que si tenemos 3 cartas necesitaremos 2 pares.
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count + 1) / 2
    }
    private(set) var flipCopunt = 0 { //variable contador de veces que hemos pulsado el boton
        didSet{ // cada vez que esta cambie
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCopunt)", attributes: attributes)
        flipCountLabel.attributedText = attributedString //cambiaremos el texto de ella
    }
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    } //creamos la label que mostrara nuestro contador
    
    @IBOutlet private var cardButtons: [UIButton]! //creamos nuestros array de botones
    
    
    @IBAction private func touchCard(_ sender: UIButton) { //funcion que se encarga de lo que va a pasar cuando toquemos un boton
        flipCopunt += 1 //sumaremos 1 a nuestro contador de pulsaciones
        if let cardNumber = cardButtons.firstIndex(of: sender){ // iniciamos una constante que igualamos a la posicion del array del boton que hayamos presionado
            game.chooseCard(at: cardNumber) //llamamos a nuestra variable game que contiene la clase Concentration por lo que podemos llamar al metodo de esta clase chooseCard pasandole la posicion del array del boton que hemos presionado, este metodo girará las cartas boca arriba o boca abajo según se encuentren
            updateViewFromModel() //llamamos al metodo que se explica mas alante
        } else { //sino
            print("Chosen card was not in cardButtons") //si nos sale este mensaje quiere decir que hay un boton que no hemos metido en nuestro array
        }
    }
   private func updateViewFromModel() { //funcion
        for index in cardButtons.indices { //recoremos las posiciones de nuestro array
            let button = cardButtons[index] //creamos constante llamada button que será cada una de las posiciones del array de botones
            let card = game.cards[index] //creamos constante card que igualamos a nuestro array de cartas
            if card.isFaceUp { //si la carta está boca arriba
                button.setTitle(emoji(for: card), for: UIControl.State.normal) //cambiamos el titulo mostrando el emoji
                button.backgroundColor = UIColor.white //cambiamos el fondo de nuestra carta a blanco
            } else { //sino
                button.setTitle("", for: UIControl.State.normal) //cambiamos el titulo y lo dejamos vacio
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange //cambiamos el fondo si hacemos mach a transparente sino a naranja
            }
        }
    }
    //private var emojiChoices = ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"] //array de emojis
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    private var emoji = [Card:String]() //creamos diccionario
    private func emoji(for card: Card) -> String { //metodo que selecciona emojis al azar
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        //if emoji[card.identifier] != nil{
        //    return emoji[card.identifier]!
        //} else{
        //    return "?"
        //}
        return emoji[card] ?? "?" //Esto es lo mismo que el codigo anterior retorname el identificador de la carta y si es 0 retorname "?"
    }
}

extension Int {
    var arc4random: Int{
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}
