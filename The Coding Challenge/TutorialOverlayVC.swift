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
    var name: String?
    var endText: String?
    var finishedChallenge: Bool = false
    var tutorialStore: TutorialStore!
    var trophyOverlayDelegate = TrophyOverlayVC()
    
    var displayImage = ""
    var imageToDisplay: String = ""
    var image: UIImage?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    // Sets up the overlay depending on what need to be showed
    override func viewDidLoad() {
        if displayImage == "noImageToDisplay" {
            textLabel.text = answerText
            pictureTextLabel.isHidden = true
            imageView.isHidden = true
        } else if displayImage == "fromOptions" {
            textLabel.isHidden = true
            pictureTextLabel.isHidden = false
            pictureTextLabel.text = answerText
            imageView.image = UIImage(named: imageToDisplay)
            imageView.isHidden = false
        } else if displayImage == "fromTakenPhoto" {
            textLabel.isHidden = true
            pictureTextLabel.isHidden = false
            pictureTextLabel.text = answerText
            imageView.image = image
            imageView.isHidden = false
        }
    }

    // Go to next challenge OR go to trophy screen if this was the last challenge
    @IBAction func nextChallenge(_ sender: UIButton) {
        
        if currentChallenge != totalChallenges {
            
            self.dismiss(animated: true, completion: nil)
            
        } else if currentChallenge == totalChallenges && finishedChallenge == false {
            
            textLabel.text = endText
            textLabel.isHidden = false
            imageView.isHidden = true
            pictureTextLabel.isHidden = true
            
            nextButton.setTitle("Finish Tutorial", for: UIControlState())
            finishedChallenge = true
            
        } else if finishedChallenge == true {
            let overlayVC = storyboard!.instantiateViewController(withIdentifier: "TrophyOverlayVC") as! TrophyOverlayVC
            
            prepareOverlayVC(overlayVC)
            
            overlayVC.updateTutorialTrophyOverlay("tutorial", tutorialName: name!)
            
            present(overlayVC, animated: true, completion: nil)

            finishedChallenge = false
        }
    }
    
    // Function to update the overlay depending on what needs to be displayed
    func updateOverlay(_ name: String, correctAnswer: String, currentChallenge: Int, totalChallenges: Int, endText: String, displayImage: String, imageName: String, image: UIImage?) {
        
        if displayImage == "noImageToDisplay" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.displayImage = "noImageToDisplay"

        } else if displayImage == "fromOptions" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.imageToDisplay = imageName
            self.displayImage = "fromOptions"
            self.image = image
        } else if displayImage == "fromTakenPhoto" {
            self.name = name
            self.answerText = correctAnswer
            self.currentChallenge = currentChallenge
            self.totalChallenges = totalChallenges
            self.endText = endText
            self.imageToDisplay = ""
            self.displayImage = "fromTakenPhoto"
            self.image = image
        }
        
        
    }
    
    fileprivate func prepareOverlayVC(_ overlayVC: UIViewController) {
        overlayVC.transitioningDelegate = trophyOverlayDelegate
        overlayVC.modalPresentationStyle = .fullScreen
    }
    
    // UIViewControllerTransitioningDelegate methods
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        if presented == self {
            return OverlayPresentationController(presentedViewController: presented, presenting: presenting)
        }
        
        return nil
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if presented == self {
            return OverlayAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if dismissed == self {
            return OverlayAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }
    
}
