//
//  OverlayTransitionDelegate.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 13.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TutorialOverlayVC: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    var answerText: String?
    var currentChallenge: Int?
    var totalChallenges: Int?
    var endText: String?
    var finishedChallenge: Bool = false
    var tutorialStore: TutorialStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        textLabel.text = answerText
    }
    
    // ---- UIViewControllerTransitioningDelegate methods
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            return OverlayPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented == self {
            return OverlayAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed == self {
            return OverlayAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }

    @IBAction func nextChallenge(sender: UIButton) {
        
        if currentChallenge != totalChallenges {
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else if currentChallenge! == totalChallenges! && finishedChallenge == false {
            
            nextButton.setTitle("Finish Tutorial", forState: .Normal)
            textLabel.text = endText
            finishedChallenge = true
            
        } else if finishedChallenge == true {
            self.performSegueWithIdentifier("unwindToMenu", sender: self)
            finishedChallenge = false
        }
    }
    
    
    func updateOverlay(correctAnswer: String, currentChallenge: Int, totalChallenges: Int, endText: String) {
        self.answerText = correctAnswer
        self.currentChallenge = currentChallenge
        self.totalChallenges = totalChallenges
        self.endText = endText
    }
    
}