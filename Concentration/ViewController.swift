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
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get{
            return (cardButtons.count + 1) / 2
        }
    }
    
    @IBAction func resetMaxScore(_ sender: UIButton) {
        UserDefaults.standard.set(0, forKey: "max")
        maxScore = 0
        game.maxScore = 0
        
    }
    //observer
    private(set) var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private(set) var maxScore = UserDefaults.standard.integer(forKey: "max" ) {
        didSet {
            maxScoreLabel.text = "High score: \(maxScore)"
        }
    }
    
    @IBOutlet weak var maxScoreLabel: UILabel!
    
    @IBAction private func newGameGame(_ sender: UIButton) {
        game.restart()
        themeNumber = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        emojiSuite = emojiChoices[themeNumber]!
        colors = themeColors[themeNumber]!
        updateViewFromModel()
    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    //an array
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton)  {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    
    private func updateViewFromModel() {
        score = game.score
        maxScore = UserDefaults.standard.integer(forKey: "max")
        if(game.gameOver) {
            maxScore = UserDefaults.standard.integer(forKey: "max")
        }
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
    
    private var emojiChoices = [0:["👻","🎃","🙀","👹","💀","🧟‍♂️","🦇","😈"],
                        1:["🤺","🏋🏻‍♂️","🤾‍♀️","🏄🏻‍♀️","🚵‍♀️","🏌🏿‍♂️","⛹🏻‍♂️","🏂"],
                        2:["🐳","🐺","🐼","🐷","🙉","🦁","🦉","🐴"],
                        3:["🍏","🍎","🍓","🍋","🍌","🍑","🍉","🍊"],
                        4:["🍦","🥧","🍰","🎂","🍮","🍧","🍨","🥠"],
                        5:["🌲","🌳","🌴","🌱","🌿","☘️","🌵","🎄"]]
    
    private var themeColors = [0:[#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       1:[#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       2:[#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       3:[#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       4:[#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
                       5:[#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]]
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = colors[0]
//        scoreLabel.textColor = colors[1]
//    }
    
    lazy var themeNumber = Int(arc4random_uniform(UInt32(emojiChoices.count)))

    lazy var emojiSuite = emojiChoices[themeNumber]!
    lazy var colors = themeColors[themeNumber]!
    
    
    // = Dictionary<Int,String>()
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        
        //just in time loading the dict
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                emoji[card.identifier] = emojiSuite.remove(at: emojiSuite.count.arc4random)

            }
        return emoji[card.identifier] ??  "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
    
    
    


