//
//  Divide.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Divide: BinaryOperation, Evaluatable {
    
    override func calc(a: Number?, b: Number?) -> Number? {
        if a == nil || b == nil {
            return nil
        } else {
            return (b! == 0) ? nil : a! / b!
        }
    }
}