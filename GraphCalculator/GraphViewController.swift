//
//  GraphViewController.swift
//  GraphDrawer
//
//  Created by Руслан Тхакохов on 02.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

/*This class gets a (Double -> Double) function as its model and draws a graph*/

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource, UIAdaptivePresentationControllerDelegate {
    typealias Evaluator = Double -> Double?
    
    var evaluator: Evaluator?
    var minValue: CGFloat?
    var maxValue: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*var calculatorBrain: CalculatorBrain? { //Model
        didSet {
            graphView?.setNeedsDisplay()
            evaluator = calculatorBrain!.composeEvaluator()
            minValue = nil
            maxValue = nil
        }
    }*/
    
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.dataSource = self
            var gesture = UITapGestureRecognizer(target: graphView, action: "doubleTapped:")
            gesture.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(gesture)
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "zoom:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: "move:"))
        }
    }
    
    func getY(x: CGFloat) -> CGFloat {
        let value = CGFloat(getValueForX(Double(x)))
        updateMinMax(value)
        return value
    }
    
    func getBounds() -> CGRect {
        return navigationController?.view.bounds ?? view.bounds
    }
    
    private func getValueForX(x: Double) -> Double { //delegate method
        if let safeEvaluator = evaluator {
            println(safeEvaluator(x) ?? Double.NaN)
            return safeEvaluator(x) ?? Double.NaN
        }
        return Double.NaN
    }
    
    private func updateMinMax(value: CGFloat) {
        if minValue != nil {
            minValue = min(minValue!, value)
        } else {
            minValue = value
        }
        if maxValue != nil {
            maxValue = max(maxValue!, value)
        } else {
            maxValue = value
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Stats":
                if let svc = segue.destinationViewController as? StatsViewController {
                    if let pvc = svc.presentationController {
                        pvc.delegate = self
                    }
                    svc.minValue = minValue
                    svc.maxValue = maxValue
                }
            default:
                break
            }
        }
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}

