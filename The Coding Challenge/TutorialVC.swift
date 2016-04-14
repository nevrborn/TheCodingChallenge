//
//  tutorial.swift
//  CodeChallenge
//
//  Created by Jarle Matland on 01.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController, UITextViewDelegate {
    
    var indexOfTutorial: Int?
    
    var indexOfChallenges: Int = 0
    var processedChallenges = [String: AnyObject]()
    var selectedUserOption: Int = 0
    var tutorialIntroFinished = false
    var lastchallenge = false
    var numberOfChallenges: Int = 0
    var lastChallenge = false
    
    var tutorial: Tutorial!
    var tutorialStore: TutorialStore!
    var syntaxTextStorage: SyntaxTextStorage?
    var tutorialOverlayDelegate = TutorialOverlayVC()
    

    @IBOutlet var tutorialText: UILabel!
    @IBOutlet var tutorialCodeView: UITextView!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var tutorialTitle: UINavigationItem!
    
    
    override func viewDidLoad() {
        
        tutorialIntroFinished = false
        
        tutorial = tutorialStore[indexOfTutorial!]
        syntaxTextStorage = SyntaxTextStorage()
        numberOfChallenges = tutorial.challenges.count - 1
       
        tutorialCodeView.hidden = true
        option1Button.hidden = true
        option2Button.hidden = true
        option3Button.hidden = true
        
        tutorialTitle.title = tutorial.name
        tutorialText.text = tutorial.introText
        
        super.viewDidLoad()
    }
    

    @IBAction func runButtonPressed(sender: UIButton) {
        
        if tutorialIntroFinished == true {
            
            if selectedUserOption == tutorial.challenges[indexOfChallenges].correctInput! {
                
                print("You made the correct choice")
                
                let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TutorialOverlayVC") as! TutorialOverlayVC

                prepareOverlayVC(overlayVC)
                
                overlayVC.updateOverlay(tutorial.challenges[indexOfChallenges].correctAnswerText!, currentChallenge: indexOfChallenges, totalChallenges: numberOfChallenges, endText: tutorial.endText!)
                
                presentViewController(overlayVC, animated: true, completion: nil)

                if indexOfChallenges != numberOfChallenges {
                    indexOfChallenges += 1
                    nextChallenge(indexOfChallenges)
                }
                
            } else if selectedUserOption != tutorial.challenges[indexOfChallenges].correctInput! {
                print("You made the WRONG choice")
                if selectedUserOption == 1 {
                    option1Button.backgroundColor = UIColor.redColor()
                    option2Button.backgroundColor = UIColor.lightGrayColor()
                    option3Button.backgroundColor = UIColor.lightGrayColor()
                }
                if selectedUserOption == 2 {
                    option1Button.backgroundColor = UIColor.lightGrayColor()
                    option2Button.backgroundColor = UIColor.redColor()
                    option3Button.backgroundColor = UIColor.lightGrayColor()
                }
                if selectedUserOption == 3 {
                    option1Button.backgroundColor = UIColor.lightGrayColor()
                    option2Button.backgroundColor = UIColor.lightGrayColor()
                    option3Button.backgroundColor = UIColor.redColor()
                }
            }
        } else {
            tutorialIntroFinished = true
            runButton.setTitle("Try it out!", forState: .Normal)
            nextChallenge(indexOfChallenges)
            
        }
        
    }
    
    @IBAction func pressedOption1(sender: UIButton) {
        tutorialCodeView.attributedText = processedChallenges[CodeOption1AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 1
        option1Button.backgroundColor = UIColor.cyanColor()
        option2Button.backgroundColor = UIColor.lightGrayColor()
        option3Button.backgroundColor = UIColor.lightGrayColor()
    }
    
    @IBAction func pressedOption2(sender: UIButton) {
        tutorialCodeView.attributedText = processedChallenges[CodeOption2AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 2
        option1Button.backgroundColor = UIColor.lightGrayColor()
        option2Button.backgroundColor = UIColor.cyanColor()
        option3Button.backgroundColor = UIColor.lightGrayColor()
    }
    
    @IBAction func pressedOption3(sender: UIButton) {
        tutorialCodeView.attributedText  = processedChallenges[CodeOption3AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 3
        option1Button.backgroundColor = UIColor.lightGrayColor()
        option2Button.backgroundColor = UIColor.lightGrayColor()
        option3Button.backgroundColor = UIColor.cyanColor()
    }
    
    
    func nextChallenge(challengeIndex: Int) {
        
        let challenge = tutorial.challenges[challengeIndex]
        syntaxTextStorage?.processText(challenge)

        self.processedChallenges = (syntaxTextStorage?.tutorialDictionary)!
        
        tutorialText.attributedText = processedChallenges[AttributedText] as? NSMutableAttributedString
        tutorialCodeView.attributedText = processedChallenges[DisplayedCodeFormatted] as? NSMutableAttributedString
        option1Button.setTitle(challenge.input1! as String, forState: .Normal)
        option2Button.setTitle(challenge.input2! as String, forState: .Normal)
        option3Button.setTitle(challenge.input3! as String, forState: .Normal)
        
        option1Button.backgroundColor = UIColor.lightGrayColor()
        option2Button.backgroundColor = UIColor.lightGrayColor()
        option3Button.backgroundColor = UIColor.lightGrayColor()
        
        tutorialCodeView.hidden = false
        option1Button.hidden = false
        option2Button.hidden = false
        option3Button.hidden = false
        
    }
    
    private func prepareOverlayVC(overlayVC: UIViewController) {
        overlayVC.transitioningDelegate = tutorialOverlayDelegate
        overlayVC.modalPresentationStyle = .FullScreen
    }
}


