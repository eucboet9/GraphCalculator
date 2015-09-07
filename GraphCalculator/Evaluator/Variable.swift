//
//  Variable.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Variable: Evaluatable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func evaluate(x: Number?, y: Number?, z: Number?) -> Number? {
        switch name {
        case "x":
            return x
        case "y":
            return y
        case "z":
            return z
        default:
            println("Variable: wrong name parameter!")
            return nil
        }
    }
}