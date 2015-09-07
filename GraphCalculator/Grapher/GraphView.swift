//
//  GraphView.swift
//  GraphDrawer
//
//  Created by Руслан Тхакохов on 02.08.15.
//  Copyright (c) 2015 Руслан Тхакохов. All rights reserved.
//

import UIKit

protocol GraphViewDataSource {
    func getY(x: CGFloat) -> CGFloat
    func getBounds() -> CGRect
}

class GraphView: UIView {
    var origin: CGPoint! {
        didSet {
            setNeedsDisplay()
        }
    }
    var scale: CGFloat = 40 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var dataSource: GraphViewDataSource?
    private let drawer = AxesDrawer(color: UIColor.blackColor())
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        if origin == nil {
            origin = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        }
        drawer.drawAxesInRect(dataSource?.getBounds() ?? bounds, origin: origin, pointsPerUnit: scale)
        
        var path = UIBezierPath()
        var wasValid = false
        if let data = dataSource {
            for var i = CGFloat(0); i <= bounds.size.width; i += 1.0 {
                let xInGraphCoordinates = (i - origin.x) / scale
                let yInGraphCoordinates = data.getY(xInGraphCoordinates)
                if yInGraphCoordinates.isNaN {
                    wasValid = false
                    continue
                }
                
                let xInViewCoordinates = i
                let yInViewCoordinates = yInGraphCoordinates * scale + (bounds.size.height - origin.y)
                
                let point = CGPoint(x: xInViewCoordinates, y: bounds.size.height - yInViewCoordinates)
                
                if wasValid {
                    path.addLineToPoint(point)
                } else {
                    path.moveToPoint(point)
                }
                wasValid = true
            }
        
            UIColor.blackColor().set()
            path.stroke()
        }
    }
    
    func doubleTapped(sender: UITapGestureRecognizer) {
        origin = sender.locationInView(self)
    }

    func zoom(sender: UIPinchGestureRecognizer) {
        scale *= sender.scale
        sender.scale = 1.0
    }
    
    func move(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self)
        origin.x += translation.x
        origin.y += translation.y
        sender.setTranslation(CGPointZero, inView: self)
    }
}
