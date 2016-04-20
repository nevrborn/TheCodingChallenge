//
//  QuizMainVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 19.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class QuizMainVC: UIViewController {
    
    
    @IBOutlet weak var quiz1Button: UIButton!
    
    @IBAction func quizTapped(sender: UIButton) {
        
        UIView.animateWithDuration(3.0, animations:{
            self.quiz1Button.frame = CGRectMake(self.quiz1Button.frame.origin.x+25, self.quiz1Button.frame.origin.y, self.quiz1Button.frame.size.width + 300, self.quiz1Button.frame.size.height + 300)
        })
    }
    
}
