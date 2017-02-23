//
//  QuizSegue.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 25.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

// Custom animated segue for quiz tiles
class QuizSegue: UIStoryboardSegue {
    
    var button: UIButton?
    
    override func perform() {
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        let quizViewController = destination as! QuizVC
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        secondVCView?.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        quizViewController.quizView.transform = quizViewController.quizView.transform.scaledBy(x: 0.001, y: 0.001)
        secondVCView?.transform = (secondVCView?.transform.scaledBy(x: 0.001, y: 0.001))!
        
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            self.button!.transform = CGAffineTransform(scaleX: 15,y: 15)
            quizViewController.quizView.transform = CGAffineTransform.identity
            
        }, completion: { (Finished) -> Void in
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                secondVCView?.transform = CGAffineTransform.identity
                
                }, completion: { (Finished) -> Void in
                    
                    firstVCView?.transform = CGAffineTransform.identity
                    self.source.present(self.destination as UIViewController, animated: false, completion: nil)
            })
        }) 
        
        
    }
    
}
