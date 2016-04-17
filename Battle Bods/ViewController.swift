//
//  ViewController.swift
//  Battle Bods
//
//  Created by Del Dewar on 16/04/2016.
//  Copyright © 2016 Wee Toon Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gc: GameController!
    
    @IBOutlet weak var gameOutputLabel: UILabel!
    
    @IBOutlet weak var playerChoiceStack: UIStackView!
    @IBOutlet weak var soldierChoiceLabel: UILabel!
    @IBOutlet weak var orcChoiceLabel: UILabel!
    
    @IBOutlet weak var player1Soldier: UIImageView!
    @IBOutlet weak var player1Orc: UIImageView!
    @IBOutlet weak var player1Tombstone: UIImageView!
    @IBOutlet weak var player1AttackButton: UIButton!
    @IBOutlet weak var player1AttackLabel: UILabel!
    @IBOutlet weak var player1HealthLabel: UILabel!
    
    @IBOutlet weak var player2Soldier: UIImageView!
    @IBOutlet weak var player2Orc: UIImageView!
    @IBOutlet weak var player2Tombstone: UIImageView!
    @IBOutlet weak var player2AttackButton: UIButton!
    @IBOutlet weak var player2AttackLabel: UILabel!
    @IBOutlet weak var player2HealthLabel: UILabel!
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var restartLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gc = GameController(vc: self)
        gc.showPlayerChoiceScreen() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPlayerChoicePressed(sender: UIButton) {
        gc.playerSelected(sender.tag)
    }
    
    @IBAction func onAttackPressed(sender: UIButton) {
        gc.attackAttempt(sender.tag)
    }
    
    @IBAction func onRestartPressed(sender: UIButton) {
        gc.restartGame()
    }
    
}

