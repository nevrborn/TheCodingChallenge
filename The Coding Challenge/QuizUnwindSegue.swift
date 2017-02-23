//
//  QuizUnwindSegue.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 25.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

//Going back to the mainmenue.
class QuizUnwindSegue: UIStoryboardSegue {
    
    var button: UIButton? = nil
    
    override func perform() {
        let mainVCView = destination.view as UIView!
        let quizVCView = source.view as UIView!
        
        self.source.dismiss(animated: false, completion: nil)
        
        self.button!.transform = self.button!.transform.scaledBy(x: 15, y: 15)
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(mainVCView!, aboveSubview: quizVCView!)
        
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            
            self.button!.transform = CGAffineTransform(scaleX: 1,y: 1)
            
        }, completion: { (Finished) -> Void in
            
            self.button?.isEnabled = false

        }) 
        
    }
    
    
}
