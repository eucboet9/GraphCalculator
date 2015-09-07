//
//  BinaryOperation.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class BinaryOperation: Evaluatable { //abstract
    let left: Evaluatable?
    let right: Evaluatable?
    
    init(left: Evaluatable?, right: Evaluatable?) {
        self.left = left
        self.right = right
    }
    
    func evaluate(x: Number?, y: Number?, z: Number?) -> Number? {
        return calc(left?.evaluate(x, y: y, z: z), b: right?.evaluate(x, y: y, z: z))
    }
    
    func calc(a: Number?, b: Number?) -> Number? { //abstract
        return nil
    }
}