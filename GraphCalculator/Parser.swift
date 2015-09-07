//
//  Parser.swift
//  Parser
//
//  Created by Руслан Тхакохов on 07.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import Foundation

enum Token {
    case Plus, Minus, Multiply, Divide, Const, Variable, Sqrt, Sin, Cos, Log, End, Lp, Rp
    
    static func getTokenBySymbol(symbol: String) -> Token? {
        switch symbol {
        case "+":
            return .Plus
        case "-":
            return .Minus
        case "*":
            return .Multiply
        case "/":
            return .Divide
        case "(":
            return .Lp
        case ")":
            return .Rp
        case "sqrt":
            return .Sqrt
        case "sin":
            return .Sin
        case "cos":
            return .Cos
        case "log":
            return .Log
        case "\n":
            return .End
        default:
            return nil
        }
    }
}

class Parser {
    let expression: String
    
    private var pos = 0
    private var stringValue = ""
    private var numberValue: Number? = 0 {
        didSet {
            println("numberValue = \(numberValue)")
        }
    }
    
    init(expression: String) {
        var string = expression
        
        string = string.stringByReplacingOccurrencesOfString("×", withString: "*", options: .LiteralSearch, range: nil)
        string = string.stringByReplacingOccurrencesOfString("X", withString: "x", options: .LiteralSearch, range: nil)
        string = string.stringByReplacingOccurrencesOfString("÷", withString: "/", options: .LiteralSearch, range: nil)
        string = string.stringByReplacingOccurrencesOfString("√", withString: "sqrt", options: .LiteralSearch, range: nil)
        
        self.expression = string
    }
    
    func parse() -> Evaluatable? {
        return parseExpression()
    }
    
    private func parseExpression() -> Evaluatable? {
        var ans = parseTerm()
        
        while true {
            if let curTok = getToken() {
                switch curTok {
                case .Plus:
                    pos++
                    ans = Add(left: ans, right: parseTerm())
                case .Minus:
                    pos++
                    ans = Subtract(left: ans, right: parseTerm())
                default:
                    return ans
                }
            } else  {
                //error
                return nil
            }
        }
    }
    
    private func parseTerm() -> Evaluatable? {
        var ans = parsePrimary()
        
        while true {
            if let curTok = getToken() {
                switch curTok {
                case .Multiply:
                    pos++
                    ans = Multiply(left: ans, right: parseTerm())
                case .Divide:
                    pos++
                    ans = Divide(left: ans, right: parseTerm())
                default:
                    return ans
                }
            } else {
                //error
                return nil
            }
        }
    }
    
    private func parsePrimary() -> Evaluatable? {
        if let curTok = getToken() {
            switch curTok {
            case .Const:
                if let value = numberValue {
                    return Const(value: value)
                } else {
                    println("Illegal const")
                    return nil
                }
            case .Variable:
                return Variable(name: stringValue)
            case .Lp:
                pos++
                let ans = parseExpression()
                if getToken() != .Rp {
                    println("Right bracket expected!")
                    return nil
                }
                pos++
                return ans
            case .Minus:
                pos++
                return Negate(left: parsePrimary())
            case .Sqrt:
                return Sqrt(left: parsePrimary())
            case .Sin:
                return Sin(left: parsePrimary())
            case .Cos:
                return Cos(left: parsePrimary())
            case .Log:
                return Log(left: parsePrimary())
            default:
                println("Token expected!")
                return nil
            }
        } else {
            println("Token expected!")
            return nil
        }
    }
    
    private func getToken() -> Token? {
        if pos == count(expression) {
            return Token.End
        }
        
        let c = expression.stringAt(pos)
        switch c {
        case "+", "-", "*", "/", "(", ")":
            return Token.getTokenBySymbol(c)
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            var curPos = pos
            while curPos < count(expression) && String.isDigit(expression.charAt(curPos)) {
                curPos++
            }
            var formatter = NSNumberFormatter()
            formatter.decimalSeparator = "."
            numberValue = formatter.numberFromString(expression.substr(pos, r: curPos))?.doubleValue
            pos = curPos
            return .Const
        case "x", "y", "z":
            stringValue = c + ""
            pos++
            return .Variable
        default:
            //function
            if pos + 3 <= count(expression) {
                let fn = expression.substr(pos, r: pos + 3)
                switch fn {
                case "sqr":
                    pos += 4
                    return .Sqrt
                case "sin", "cos", "log":
                    pos += 3
                    return Token.getTokenBySymbol(fn)
                default:
                    break
                }
            }
            
            println("Unknow operation: \(c)")
            return nil
        }
        
    }
    
    private func charAt(i: Int) -> Character {
        return expression[advance(expression.startIndex, i)]
    }
    
    private func substr(l: Int, r: Int) -> String {
        let lIndex = advance(expression.startIndex, l)
        let rIndex = advance(expression.startIndex, r)
        return expression.substringWithRange(lIndex..<rIndex)
    }

}