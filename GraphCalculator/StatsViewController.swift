//
//  StatsViewController.swift
//  GraphCalculator
//
//  Created by Руслан Тхакохов on 04.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet weak var display: UITextView! {
        didSet {
            var text = ""
            if let unwrappedMin = minValue {
                text += "Min value = \(unwrappedMin)\n"
            } else {
                text += "Min value is unavailable"
            }
            if let unwrappedMax = maxValue {
                text += "Max value = \(unwrappedMax)\n"
            } else {
                text += "Max value is unavailable"
            }
            display?.text = text
        }
    }
    
    var minValue: CGFloat? {
        didSet {
            var text = "Min value = \(minValue)\n"
            if let unwrappedMax = maxValue {
                text += "Max value = \(unwrappedMax)\n"
            } else {
                text += "Max value is unavailable"
            }
            display?.text = text
        }
    }
    var maxValue: CGFloat? {
        didSet {
            var text = ""
            if let unwrappedMin = minValue {
                text += "Min value = \(unwrappedMin)\n"
            } else {
                text += "Min value is unavailable"
            }
            text += "Max value = \(maxValue)\n"
            display?.text = text
        }
    }
    
    override var preferredContentSize: CGSize {
        get {
            if display != nil && presentingViewController != nil {
                return display.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set {
           super.preferredContentSize = newValue
        }
    }

}
