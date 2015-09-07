//
//  ViewController.swift
//  GraphCalculator
//
//  Created by Руслан Тхакохов on 30.07.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel! {
        didSet {
            display.numberOfLines = 1
            display.adjustsFontSizeToFitWidth = true
        }
    }
    
    var variableValues = Dictionary<String, Double>()
    var currentNumber = "0" {
        didSet {
            display.text = displayText + currentNumber
        }
    }
    var displayText = "" {
        didSet {
            if displayText == "0" {
                displayText = ""
                currentNumber = "0"
                display.text = currentNumber
            } else {
                display.text = displayText
            }
        }
    }
    
    @IBAction func digitTapped(sender: UIButton) {
        let symbol = sender.titleLabel!.text!
        
        if !(currentNumber == "0") || !(symbol == "0") {
            if currentNumber == "0" {
                currentNumber = ""
            }
            currentNumber += sender.titleLabel!.text!
            display.text = displayText + currentNumber
        }
    }
    
    @IBAction func pointTapped() {
        display.text? += "."
    }
    
    @IBAction func operationTapped(sender: UIButton) {
        displayText += currentNumber
        currentNumber = ""
        
        let text = sender.titleLabel!.text!
        displayText += text
        if text == "sin" || text == "cos" || text == "log" || text == "√" {
            displayText += "("
        }
    }
    
    
    @IBAction func enter() {
        displayText += currentNumber
        currentNumber = ""
        
        let parser = Parser(expression: displayText)
        let ans = parser.parse()
        if let safeAns = ans {
            if let value = safeAns.evaluate(variableValues["x"], y: 0, z: 0) {
                displayText = Utility.removeTail("\(value)")
            } else {
                reportError("Failed to evaluate the expression!")
            }
        } else {
            reportError("Failed to parse the expression!")
        }
    }

    @IBAction func setX(sender: AnyObject) {
        var alert = UIAlertController(title: "Set X value", message: "", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as! UITextField
            
            var formatter = NSNumberFormatter()
            formatter.decimalSeparator = "."
            let numberValue = formatter.numberFromString(textField.text)?.doubleValue
            
            if numberValue != nil {
                self.variableValues["x"] = numberValue!
                let button = sender as! UIBarButtonItem
                button.title = "X = \(textField.text)"
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func clear() {
        currentNumber = ""
        displayText = ""
        display.text = "0"
    }
    
    @IBAction func deleteSymbol() {
        if currentNumber == "" {
            if displayText != "" {
                displayText.removeAtIndex(displayText.endIndex.predecessor())
                if displayText == "" {
                    currentNumber = "0"
                }
            }
        } else {
            currentNumber.removeAtIndex(currentNumber.endIndex.predecessor())
            if displayText == "" && currentNumber == "" {
                currentNumber = "0"
            }
        }
    }
    private func reportError(message: String) {
        var alert = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Graph":
                if let nvc = segue.destinationViewController as? UINavigationController {
                    if let gvc = nvc.viewControllers[0] as? GraphViewController {
                        let evaluator = Parser(expression: displayText + currentNumber).parse()
                        if evaluator != nil {
                            gvc.evaluator = { (x: Double) -> Double? in evaluator!.evaluate(x, y: 0, z: 0) }
                        }
                    }
                }
            default: break
            }
        }
    }

}

