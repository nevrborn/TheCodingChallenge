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
    
    @IBOutlet var quizButton: UIButton!{

didSet {
    quizButton.transform = CGAffineTransformMakeScale(0, 0)
    UIView.animateWithDuration(1.0, delay: 1.0, usingSpringWithDamping: 0.3,initialSpringVelocity:4, options: .CurveLinear, animations: {
        self.quizButton.transform = CGAffineTransformIdentity }, completion: nil
    )}
}

    @IBOutlet var quiz1Button1: UIButton!{

        
        didSet {
            quiz1Button1.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.9, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz1Button1.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    @IBOutlet var quiz2Button: UIButton!{
        
        
        didSet {
            quiz2Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.8, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz2Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    


    @IBOutlet var quiz3Button: UIButton!{
        didSet {
            quiz3Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.7, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz3Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
  
    @IBOutlet var quiz4Button: UIButton!{
        didSet {
            quiz4Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.6, usingSpringWithDamping: 3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz4Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    @IBOutlet var quiz5Button: UIButton!{
        didSet {
            quiz5Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz5Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    @IBOutlet var quiz6Button: UIButton!{
        didSet {
            quiz6Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.4, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz6Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }

    @IBOutlet var quiz7Button: UIButton!{
        didSet {
            quiz7Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz7Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    @IBOutlet var quiz8Button: UIButton!{
        didSet {
            quiz8Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.4, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz8Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet var quiz9Button: UIButton!{
        didSet {
            quiz9Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.2, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz9Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet var quiz10Button: UIButton!{
        didSet {
            quiz10Button.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .CurveLinear, animations: {
                self.quiz10Button.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    

    }

