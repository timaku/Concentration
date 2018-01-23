//
//  ViewController.swift
//  Concentration
//
//  Created by Student User on 1/14/18.
//  Copyright © 2018 iOS crash course. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //lazy initialization is assume its initialized and then initilize when u need it
    //lazy vars can't use property observers
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2) 
    
    //observer
    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //TODO : high score label and high score in model and restart game in the model
    
    @IBAction func newGameGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        themeNumber = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        emojiSuite = emojiChoices[themeNumber]!
        colors = themeColors[themeNumber]!
        updateViewFromModel()
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    //an array
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton)  {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        score = game.score
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : colors[1]
            }
        }
        view.backgroundColor = colors[0]
        scoreLabel.textColor = colors[1]
    }
    
    var emojiChoices = [0:["👻","🎃","🙀","👹","💀","🧟‍♂️","🦇","😈"],
                        1:["🤺","🏋🏻‍♂️","🤾‍♀️","🏄🏻‍♀️","🚵‍♀️","🏌🏿‍♂️","⛹🏻‍♂️","🏂"],
                        2:["🐳","🐺","🐼","🐷","🙉","🦁","🦉","🐴"],
                        3:["🍏","🍎","🍓","🍋","🍌","🍑","🍉","🍊"],
                        4:["🍦","🥧","🍰","🎂","🍮","🍧","🍨","🥠"],
                        5:["🌲","🌳","🌴","🌱","🌿","☘️","🌵","🎄"]]
    
    var themeColors = [0:[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       1:[#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       2:[#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       3:[#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       4:[#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       5:[#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colors[0]
        scoreLabel.textColor = colors[1]
    }
    
    lazy var themeNumber = Int(arc4random_uniform(UInt32(emojiChoices.count)))

    lazy var emojiSuite = emojiChoices[themeNumber]!
    lazy var colors = themeColors[themeNumber]!
    
    
    // = Dictionary<Int,String>()
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        //just in time loading the dict
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiSuite.count)))
                emoji[card.identifier] = emojiSuite.remove(at: randomIndex)

            }
        return emoji[card.identifier] ??  "?"
    }
    
    
    
    
    
}

