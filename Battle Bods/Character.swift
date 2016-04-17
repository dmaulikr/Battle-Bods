//
//  Character.swift
//  Battle Bods
//
//  Created by Del Dewar on 16/04/2016.
//  Copyright © 2016 Wee Toon Software. All rights reserved.
//

import Foundation

class Character {
    
    private var _hp: Int = 100
    private var _attackPower: Int = 0
    
//    private var _isDead = false
//    private var _winner = false
    
    init(hp: Int, ap:Int) {
        self._hp = hp
        self._attackPower = ap
    }
    
    var hp: Int {
        get {
            if _hp < 0 {
                return 0
            } else {
                return _hp
            }
        }
    }
    
    var attackPower: Int {
        get {
            return _attackPower
        }
    }
    
    var isAlive: Bool {
        get {
            if hp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    func attemptAttack(ap: Int) {
        _hp -= ap
    }
    
}