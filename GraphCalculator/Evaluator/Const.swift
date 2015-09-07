//
//  Const.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Const: Evaluatable {
    private let value: Number
    
    init(value: Number) {
        self.value = value
    }
    
    func evaluate(x: Number?, y: Number?, z: Number?) -> Number? {
        return value
    }
}