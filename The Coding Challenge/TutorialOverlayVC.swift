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
    @IBOutlet var pictureTextLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nextButton: UIButton!
    
    var answerText: String?
    var currentChallenge: Int?
    var totalChallenges: Int?
    var endText: String?
    var finishedChallenge: Bool = false
    var tutorialStore: TutorialStore!
    var trophyOverlayDelegate = TrophyOverlayVC()
    
    var displayImage = false
    var imageToDisplay: String = ""
    
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
        if displayImage == false {
            textLabel.text = answerText
            pictureTextLabel.hidden = true
            imageView.hidden = true
        } else if displayImage == true {
            textLabel.hidden = true
            pictureTextLabel.hidden = false
            imageView.image = UIImage(named: imageToDisplay)
            imageView.hidden = false
        }
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
            
        } else if currentChallenge == totalChallenges && finishedChallenge == false {
            
            textLabel.text = endText
            textLabel.hidden = false
            imageView.hidden = true
            pictureTextLabel.hidden = true
            
            nextButton.setTitle("Finish Tutorial", forState: .Normal)
            finishedChallenge = true
            
        } else if finishedChallenge == true {
            let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TrophyOverlayVC") as! TrophyOverlayVC
            
            prepareOverlayVC(overlayVC)
            
            overlayVC.updateTutorialTrophyOverlay("tutorial", tutorialName: "Functions")
            
            presentViewController(overlayVC, animated: true, completion: nil)

            finishedChallenge = false
        }
    }
    
    
    func updateOverlay(correctAnswer: String, currentChallenge: Int, totalChallenges: Int, endText: String, displayImage: Bool, imageName: String) {
        
        if displayImage == false {
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.displayImage = false

        } else if displayImage == true {
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.imageToDisplay = imageName
            self.displayImage = true
        }
        
        
    }
    
    private func prepareOverlayVC(overlayVC: UIViewController) {
        overlayVC.transitioningDelegate = trophyOverlayDelegate
        overlayVC.modalPresentationStyle = .FullScreen
    }
    
}