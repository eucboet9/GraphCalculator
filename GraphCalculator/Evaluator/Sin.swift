//
//  Sin.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Sin: UnaryOperation, Evaluatable {
    
    override func calc(a: Number?) -> Number? {
        if a == nil {
            return nil
        } else {
            return sin(a!)
        }
    }
}