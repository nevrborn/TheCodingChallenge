//
//  tutorial.swift
//  CodeChallenge
//
//  Created by Jarle Matland on 01.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

class TutorialVC: UIViewController, UITextViewDelegate {
    
    var indexOfTutorial: Int?
    
    var indexOfChallenges: Int = 0
    var processedChallenges = [String: AnyObject]()
    var selectedUserOption: Int = 0
    var tutorialIntroFinished = false
    var lastchallenge = false
    var numberOfChallenges: Int = 0
    var lastChallenge = false
    var imageToBeDisplayed: String = ""
    
    var tutorial: Tutorial!
    var tutorialStore: TutorialStore!
    var syntaxTextStorage: SyntaxTextStorage?
    var tutorialOverlayDelegate = TutorialOverlayVC()
    
    var optionImage = UIImage(named: "questionBar.png")
    var selectedOptionImage = UIImage(named: "questionBarGreen.png")
    var wrongOptionImage = UIImage(named: "questionBarRed.png")
    

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
        
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        
        if tutorialIntroFinished == true {
            
            if selectedUserOption == currentChallenge.correctInput! || currentChallenge.correctInput == 0 {
                let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TutorialOverlayVC") as! TutorialOverlayVC

                prepareOverlayVC(overlayVC)
                
                overlayVC.updateOverlay(currentChallenge.correctAnswerText!, currentChallenge: indexOfChallenges, totalChallenges: numberOfChallenges, endText: tutorial.endText!, displayImage: currentChallenge.imageToDisplay!, imageName: imageToBeDisplayed)
                
                presentViewController(overlayVC, animated: true, completion: nil)

                if indexOfChallenges != numberOfChallenges {
                    indexOfChallenges += 1
                    nextChallenge(indexOfChallenges)
                }
                
            } else if selectedUserOption != currentChallenge.correctInput! {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                if selectedUserOption == 1 {
                    option1Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                    option2Button.setBackgroundImage(optionImage, forState: .Normal)
                    option3Button.setBackgroundImage(optionImage, forState: .Normal)
                    
                    option1Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                    option2Button.setTitle(currentChallenge.input2! as String, forState: .Normal)
                    option3Button.setTitle(currentChallenge.input3! as String, forState: .Normal)
                }
                if selectedUserOption == 2 {
                    option1Button.setBackgroundImage(optionImage, forState: .Normal)
                    option2Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                    option3Button.setBackgroundImage(optionImage, forState: .Normal)
                    
                    option1Button.setTitle(currentChallenge.input1! as String, forState: .Normal)
                    option2Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                    option3Button.setTitle(currentChallenge.input3! as String, forState: .Normal)
                }
                if selectedUserOption == 3 {
                    option1Button.setBackgroundImage(optionImage, forState: .Normal)
                    option2Button.setBackgroundImage(optionImage, forState: .Normal)
                    option3Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                    
                    option1Button.setTitle(currentChallenge.input1! as String, forState: .Normal)
                    option2Button.setTitle(currentChallenge.input2! as String, forState: .Normal)
                    option3Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                }
            }
        } else {
            tutorialIntroFinished = true
            runButton.setTitle("Try it out!", forState: .Normal)
            nextChallenge(indexOfChallenges)
            
        }
        
    }
    
    @IBAction func pressedOption1(sender: UIButton) {
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        tutorialCodeView.attributedText = processedChallenges[CodeOption1AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 1
        imageToBeDisplayed = tutorial.challenges[indexOfChallenges].input1!
        option1Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        
        option1Button.setTitle(currentChallenge.input1! as String, forState: .Normal)
        option2Button.setTitle(currentChallenge.input2! as String, forState: .Normal)
        option3Button.setTitle(currentChallenge.input3! as String, forState: .Normal)
    }
    
    @IBAction func pressedOption2(sender: UIButton) {
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        tutorialCodeView.attributedText = processedChallenges[CodeOption2AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 2
        imageToBeDisplayed = tutorial.challenges[indexOfChallenges].input2!
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        
        option1Button.setTitle(currentChallenge.input1! as String, forState: .Normal)
        option2Button.setTitle(currentChallenge.input2! as String, forState: .Normal)
        option3Button.setTitle(currentChallenge.input3! as String, forState: .Normal)
    }
    
    @IBAction func pressedOption3(sender: UIButton) {
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        tutorialCodeView.attributedText  = processedChallenges[CodeOption3AttributedCode] as! NSMutableAttributedString
        selectedUserOption = 3
        imageToBeDisplayed = tutorial.challenges[indexOfChallenges].input3!
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        
        option1Button.setTitle(currentChallenge.input1! as String, forState: .Normal)
        option2Button.setTitle(currentChallenge.input2! as String, forState: .Normal)
        option3Button.setTitle(currentChallenge.input3! as String, forState: .Normal)
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
        
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        
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


