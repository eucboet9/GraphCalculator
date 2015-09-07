//
//  Log.swift
//  GraphCalculator
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

//
//  Sqrt.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.09.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Log: UnaryOperation, Evaluatable {
    
    override func calc(a: Number?) -> Number? {
        if a == nil {
            return nil
        } else {
            return (a! <= 0) ? nil : log(a!)
        }
    }
}