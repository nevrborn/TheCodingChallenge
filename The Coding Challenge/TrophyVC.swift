//
//  throphyVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 19.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TrophyVC: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var throphy: UIImageView!
    @IBOutlet var congratulationsLabel: UILabel!
    
    override func viewDidLoad() {
        
        for _ in 0..<100 {
            drawCircle(20)
        }
        
    }
    
    func drawCircle(radiusDivider: CGFloat) {
        
        let circleLayer = CAShapeLayer()
        
        //Find random x and y values
        let randomX = CGFloat(arc4random_uniform(UInt32(self.view.bounds.size.width)))
        let randomY = CGFloat(arc4random_uniform(UInt32(self.view.bounds.size.height)))
        
        let randomCenter = CGPointMake(randomX, randomY)
        
        // Make random radius
        let randomRadius = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.height/radiusDivider)))
        
        let circlePath = UIBezierPath(arcCenter: randomCenter, radius: randomRadius, startAngle: 1, endAngle: 100, clockwise: true)
        
        let randomColor = getRandomColor()
        let randomRed = randomColor.red
        let randomGreen = randomColor.green
        let randomBlue = randomColor.blue
        
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5).CGColor
        circleLayer.strokeColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5).CGColor
        circleLayer.lineWidth = 0.2
        
        view.layer.addSublayer(circleLayer)
        
    }
    
    
    func getRandomColor() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        
        return (randomRed, randomBlue, randomGreen)
    }
}
