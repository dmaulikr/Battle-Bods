//
//  Soldier.swift
//  Battle Bods
//
//  Created by Del Dewar on 16/04/2016.
//  Copyright © 2016 Wee Toon Software. All rights reserved.
//

import Foundation

class Soldier: Character {
    private var _name = ""
    
    var name: String {
        get {
            return _name
        }
    }
    
    convenience init(name: String, hp: Int, ap:Int) {
        self.init(hp: hp, ap: ap)
        _name = name
    }
}