//
//  Utility.swift
//  GraphCalculator
//
//  Created by Руслан Тхакохов on 31.07.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

class Utility {
    class func removeTail(string: String) -> String {
        var tmp = string
        if tmp.hasSuffix(".0") {
            tmp.removeRange(tmp.endIndex.predecessor().predecessor()..<tmp.endIndex)
        }
        return tmp
    }
}