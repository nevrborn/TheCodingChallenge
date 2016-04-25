//
//  throphyVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 19.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TrophyOverlayVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var throphy: UIImageView!
    @IBOutlet var congratulationsLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    var tutorialName: String = ""
    var score: Int = 0
    var quizName: String = ""
    var toBeDisplayed: String = ""
    
    @IBAction func share(sender: UIButton) {
        let vc = UIActivityViewController(activityItems:["\(Int(score)) / 100 points on the \(quizName) quiz with CodeChallenge app.\r\r Interested in coding? Check out @AppAcademyNL"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func learnMore(sender: UIButton) {
    }
    
    @IBAction func goToMainMenu(sender: UIButton) {
        self.performSegueWithIdentifier("unwindToMenu", sender: self)
    }
    
    
    override func viewDidLoad() {
        
        if toBeDisplayed == "quiz" {
            textLabel.text = "You've completed the \(quizName) quiz and scored \(Int(score)) / 100 points!"
        } else if toBeDisplayed == "tutorial" {
            textLabel.text = "You've completed the \(tutorialName) tutorial! \r\r"
        }
        
        for _ in 0..<100 {
            drawCircle(20)
        }
        
    }
    
    func updateQuizTrophyOverlay(toBeDisplayed: String, quizName: String) {
        self.toBeDisplayed = toBeDisplayed
        self.quizName = quizName
    }
    
    func updateTutorialTrophyOverlay(toBeDiplayed: String, tutorialName: String, score: Int) {
        self.toBeDisplayed = toBeDiplayed
        self.tutorialName = tutorialName
        self.score = score
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
