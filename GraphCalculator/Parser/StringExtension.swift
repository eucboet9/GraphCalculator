//
//  StringExtension.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

extension String {
    func charAt(i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    func stringAt(i: Int) -> String {
        return substr(i, r: i + 1)
    }
    
    func substr(l: Int, r: Int) -> String {
        let lIndex = advance(self.startIndex, l)
        let rIndex = advance(self.startIndex, r)
        return self.substringWithRange(lIndex..<rIndex)
    }
    
    func substrFrom(l: Int)  -> String {
        let lIndex = advance(self.startIndex, l)
        return substringFromIndex(lIndex)
    }
    
    func substrTo(r: Int)  -> String {
        let rIndex = advance(self.startIndex, r)
        return substringToIndex(rIndex)
    }
    
    static func isDigit(c: Character) -> Bool {
        if c >= "0" && c <= "9" {
            return true
        } else {
            return false
        }
    }
    
}