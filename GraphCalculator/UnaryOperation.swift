//
//  UnaryOperation.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class UnaryOperation: Evaluatable { //abstract
    let left: Evaluatable?
    
    init(left: Evaluatable?) {
        self.left = left
    }
    
    func evaluate(x: Number?, y: Number?, z: Number?) -> Number? {
        return calc(left?.evaluate(x, y: y, z: z))
    }
    
    func calc(a: Number?) -> Number? { //abstract
        return nil
    }
}