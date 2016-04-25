//
//  QuizSegue.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 25.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class QuizSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstVCView = self.sourceViewController.view as UIView!
        let secondVCView = self.destinationViewController.view as UIView!
        
        
        
        // Get the screen width and height.
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        secondVCView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.sharedApplication().keyWindow
        window?.insertSubview(secondVCView, aboveSubview: firstVCView)
        
        
    }
    
    
//    func showQuizQuestion(button: UIButton) {
//        
//        button.setTitle("", forState: .Normal)
//        
//        self.view.bringSubviewToFront(button)
//        
//        self.quizQuestionView.transform = CGAffineTransformMakeScale(0, 0)
//        
//        UIView.animateWithDuration(1, animations: { () -> Void in
//            button.transform = CGAffineTransformMakeScale(15,15)
//            self.quizQuestionView.hidden = false
//            self.view.bringSubviewToFront(self.quizQuestionView)
//            self.quizQuestionView.transform = CGAffineTransformIdentity
//            
//        }) { (Finished) -> Void in
//            
//            UIView.animateWithDuration(1, animations: { () -> Void in
//                //button.transform = CGAffineTransformMakeScale(1,1)
//                
//            }) { (Finished) -> Void in
//                button.setTitle("", forState: .Normal)
//                button.enabled = false
//            }
//        }
//    }
    
    
}
