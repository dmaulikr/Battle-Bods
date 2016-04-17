//
//  GameController.swift
//  Battle Bods
//
//  Created by Del Dewar on 16/04/2016.
//  Copyright © 2016 Wee Toon Software. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class GameController: NSObject {
    
    // View Controller Reference
    var vc: ViewController!
    
    var player1Ready: Bool = false
    var player2Ready: Bool = false
    var player1Soldier: Soldier?
    var player1Orc: Orc?
    var player2Soldier: Soldier?
    var player2Orc: Orc?
    
    var swordSound: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    var soldierSound: AVAudioPlayer!
    var orcSound: AVAudioPlayer!
    var playerSelectSound: AVAudioPlayer!
    
    init(vc: ViewController) {
        self.vc = vc
        
        
        //set up punch sound for attacks
        let swordSoundPath = NSBundle.mainBundle().pathForResource("sword-hit", ofType: "wav")
        let deathSoundPath = NSBundle.mainBundle().pathForResource("soldier_die", ofType: "wav")
        let soldierSoundPath = NSBundle.mainBundle().pathForResource("soldier_attack", ofType: "wav")
        let orcSoundPath = NSBundle.mainBundle().pathForResource("orc-attack", ofType: "wav")
        let playerSelectSoundPath = NSBundle.mainBundle().pathForResource("player_select_music", ofType: "wav")
        let swordSoundURL = NSURL(fileURLWithPath: swordSoundPath!)
        let deathSoundURL = NSURL(fileURLWithPath: deathSoundPath!)
        let soldierSoundURL = NSURL(fileURLWithPath: soldierSoundPath!)
        let orcSoundURL = NSURL(fileURLWithPath: orcSoundPath!)
        let playerSelectSoundURL = NSURL(fileURLWithPath: playerSelectSoundPath!)
        do {
            try swordSound = AVAudioPlayer(contentsOfURL: swordSoundURL)
            swordSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        do {
            try deathSound = AVAudioPlayer(contentsOfURL: deathSoundURL)
            deathSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        do {
            try soldierSound = AVAudioPlayer(contentsOfURL: soldierSoundURL)
            soldierSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        do {
            try orcSound = AVAudioPlayer(contentsOfURL: orcSoundURL)
            orcSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        do {
            try playerSelectSound = AVAudioPlayer(contentsOfURL: playerSelectSoundURL)
            playerSelectSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
        
    func playerSelected(buttonTag: Int) {
        if !player1Ready {
            if buttonTag == 1 {
                soldierSound.play()
                player1Soldier = Soldier(name: "Maximus", hp: 100, ap: Int(arc4random_uniform(50)))
                player1Ready = true
            } else if buttonTag == 2 {
                orcSound.play()
                player1Orc = Orc(name: "Grunter", hp: 100, ap: Int(arc4random_uniform(50)))
                player1Ready = true
            }
        updateGameOutput("Player 2. Choose Your Warrior!")
        } else if !player2Ready {
            if buttonTag == 1 {
                soldierSound.play()
                player2Soldier = Soldier(name: "Decimus", hp: 100, ap: Int(arc4random_uniform(50)))
                player2Ready = true
            } else if buttonTag == 2 {
                orcSound.play()
                player2Orc = Orc(name: "Growler", hp: 100, ap: Int(arc4random_uniform(50)))
                player2Ready = true
            }
        updateGameOutput("Ready to Fight!")
        hidePlayerChoiceScreen()
        showBattleScreen()
        }
    }
    
    func attackAttempt(buttonTag: Int) {
        if buttonTag == 1 {
            if let player2: Soldier = player2Soldier {
                player2.attemptAttack(getP1Ap())
                vc.player2HealthLabel.text = "\(player2.hp) HP"
                updateGameOutput("Player 1 attacks with \(getP1Ap())")
                swordSound.play()
                //disableButton3s(vc.player1AttackButton)
                if !player2.isAlive {
                    deathSound.play()
                    vc.player2Soldier.hidden = true
                    vc.player2Tombstone.hidden = false
                    disableButton(vc.player1AttackButton)
                    disableButton(vc.player2AttackButton)
                    endGame("Player 1 Wins!")

                }
            }
            if let player2: Orc = player2Orc {
                player2.attemptAttack(getP1Ap())
                vc.player2HealthLabel.text = "\(player2.hp) HP"
                updateGameOutput("Player 1 attacks with \(getP1Ap())")
                swordSound.play()
                //disableButton3s(vc.player1AttackButton)
                if !player2.isAlive {
                    deathSound.play()
                    vc.player2Orc.hidden = true
                    vc.player2Tombstone.hidden = false
                    disableButton(vc.player1AttackButton)
                    disableButton(vc.player2AttackButton)
                    endGame("Player 1 Wins!")

                }
            }
        } else if buttonTag == 2 {
            if let player1: Soldier = player1Soldier {
                player1.attemptAttack(getP2Ap())
                vc.player1HealthLabel.text = "\(player1.hp) HP"
                updateGameOutput("Player 2 attacks with \(getP2Ap())")
                swordSound.play()
                //disableButton3s(vc.player2AttackButton)
                if !player1.isAlive {
                    deathSound.play()
                    vc.player1Soldier.hidden = true
                    vc.player1Tombstone.hidden = false
                    disableButton(vc.player1AttackButton)
                    disableButton(vc.player2AttackButton)
                    endGame("Player 2 Wins!")

                }
            }
            if let player1: Orc = player1Orc {
                player1.attemptAttack(getP2Ap())
                vc.player1HealthLabel.text = "\(player1.hp) HP"
                updateGameOutput("Player 2 attacks with \(getP2Ap())")
                swordSound.play()
                //disableButton3s(vc.player2AttackButton)
                if !player1.isAlive {
                    deathSound.play()
                    vc.player1Orc.hidden = true
                    vc.player1Tombstone.hidden = false
                    disableButton(vc.player1AttackButton)
                    disableButton(vc.player2AttackButton)
                    endGame("Player 2 Wins!")
                }
            }
        }
    }
    
    func getP1Ap() -> Int {
        if let player1: Soldier = player1Soldier {
            return player1.attackPower
        }
        if let player1: Orc = player1Orc {
            return player1.attackPower
        }
        return 0
    }
    
    func getP2Ap() -> Int {
        if let player2: Soldier = player2Soldier {
            return player2.attackPower
        }
        if let player2: Orc = player2Orc {
            return player2.attackPower
        }
        return 0
    }
    
    func endGame(text: String) {
        updateGameOutput(text)
        vc.restartButton.hidden = false
        vc.restartLabel.hidden = false
    }
    
    func restartGame() {
        hideBattleScreen()
        showPlayerChoiceScreen()
        player1Soldier = nil
        player1Orc = nil
        player2Soldier = nil
        player2Orc = nil
        player1Ready = false
        player2Ready = false
        enableButton(vc.player1AttackButton)
        enableButton(vc.player2AttackButton)
    }
    
    func showBattleScreen() {
        if (player1Soldier) != nil {
            vc.player1Soldier.hidden = false
            vc.player1HealthLabel.text = "\(player1Soldier!.hp) HP"
        }
        if (player1Orc) != nil {
            vc.player1Orc.hidden = false
            vc.player1HealthLabel.text = "\(player1Orc!.hp) HP"
        }
        if (player2Soldier) != nil {
            vc.player2Soldier.hidden = false
            vc.player2HealthLabel.text = "\(player2Soldier!.hp) HP"
        }
        if (player2Orc) != nil {
            vc.player2Orc.hidden = false
            vc.player2HealthLabel.text = "\(player2Orc!.hp) HP"
        }
        vc.player1AttackButton.hidden = false
        vc.player1AttackLabel.hidden = false
        vc.player1HealthLabel.hidden = false
        vc.player2AttackButton.hidden = false
        vc.player2AttackLabel.hidden = false
        vc.player2HealthLabel.hidden = false
    }
    
    func hideBattleScreen() {
        vc.player1Soldier.hidden = true
        vc.player1Orc.hidden = true
        vc.player1Tombstone.hidden = true
        vc.player1AttackButton.hidden = true
        vc.player1AttackLabel.hidden = true
        vc.player1HealthLabel.hidden = true
        
        vc.player2Soldier.hidden = true
        vc.player2Orc.hidden = true
        vc.player2Tombstone.hidden = true
        vc.player2AttackButton.hidden = true
        vc.player2AttackLabel.hidden = true
        vc.player2HealthLabel.hidden = true
        
        vc.restartButton.hidden = true
        vc.restartLabel.hidden = true
        
    }
        
    func showPlayerChoiceScreen() {
        playerSelectSound.play()
        vc.playerChoiceStack.hidden = false
        vc.soldierChoiceLabel.hidden = false
        vc.orcChoiceLabel.hidden = false
        updateGameOutput("Player 1. Choose Your Warrior!")
    }
    
    func hidePlayerChoiceScreen() {
        playerSelectSound.stop()
        vc.playerChoiceStack.hidden = true
        vc.soldierChoiceLabel.hidden = true
        vc.orcChoiceLabel.hidden = true
    }
    
    func updateGameOutput(str: String) {
        vc.gameOutputLabel.text = str
    }
    
    func enableButton3s(timer:NSTimer!) {
        
        let btn = timer.userInfo as? UIButton
        btn?.enabled = true
    }
    
    func disableButton3s(btn: UIButton) {
        btn.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(GameController.enableButton3s(_:)), userInfo: btn, repeats: false)
    }
    
    func disableButton(btn: UIButton) {
        btn.enabled = false
    }
    
    func enableButton(btn: UIButton) {
        btn.enabled = true
    }
}
