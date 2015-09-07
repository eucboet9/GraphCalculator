//
//  TripleExpression.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

protocol Evaluatable {
    func evaluate(x: Number?, y: Number?, z: Number?) -> Number?
}