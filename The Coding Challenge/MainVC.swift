//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Jarle Matland on 31.03.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class MainVC: UIViewController, JSONSourceDelegate, JSONQuizSourceDelegate {
    
    var tutorialStore: TutorialStore!
    var quizStore: QuizStore!
    
    var indexOfPage = 0
    var numberOfPagesNeeded: Double = 1.0
    var numberOfPagesTotal = 0
    var numberOfItemsOnLastPage = 0
    var indexOfSelectedItem = 0
    var firstTimeLoad: Bool?
    var quizOrTutorial: String?
    
    var tutorialsImage = UIImage(named: "tutorialsIcon")
    var faqImage = UIImage(named: "faqIcon")
    var quizImage = UIImage(named: "quizIcon")
    var moreTutorialsImage = UIImage(named: "tutMore")
    var mainMenuImage = UIImage(named: "mainMenu")
    var logoImage = UIImage(named: "taaLogo")
    var tutorialIcons: [UIImage] = []
    var quizIcons: [UIImage] = []
    
    @IBOutlet var logoButton: UIButton!
    @IBOutlet var codeChallengeLogo: UIImageView!
    
    // QUIZ buttons
    @IBOutlet var quizTile1: UIButton!
    @IBOutlet var quizTile2: UIButton!
    @IBOutlet var quizTile3: UIButton!
    @IBOutlet var quizTile4: UIButton!
    @IBOutlet var quizTile5: UIButton!
    @IBOutlet var quizTile6: UIButton!
    @IBOutlet var quizTile7: UIButton!
    @IBOutlet var quizTile8: UIButton!
    @IBOutlet var quizTile9: UIButton!
    @IBOutlet var quizTile10: UIButton!
    @IBOutlet var quizMainMenu: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var scoreTile: UIImageView!

    
    override func viewDidLoad() {
        
        setImages()
        
        buttonNo1.imageView?.image = tutorialsImage
        buttonNo2.imageView?.image = faqImage
        buttonNo3.imageView?.image = quizImage
        
        buttonNo1.hidden = false
        buttonNo2.hidden = false
        buttonNo3.hidden = false
        buttonNo4.hidden = true
        buttonNo5.hidden = false
        mainMenuButton.hidden = true
        
        buttonNo1.enabled = true
        buttonNo2.enabled = true
        buttonNo3.enabled = true
        buttonNo4.enabled = false
        buttonNo5.enabled = false
        mainMenuButton.enabled = false
        
        firstTimeLoad = true
        super.viewDidLoad()
    }
    
    @IBOutlet weak var buttonNo1: UIButton! {
        didSet {
            buttonNo1.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo1.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo2: UIButton! {
        didSet {
            buttonNo2.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo2.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo3: UIButton! {
        didSet {
            buttonNo3.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo3.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo4: UIButton! {
        didSet {
            buttonNo4.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.3,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo4.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo5: UIButton! {
        didSet {
            buttonNo5.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(1.5, delay: 1.5, usingSpringWithDamping: 1,initialSpringVelocity: 2, options: .CurveLinear, animations: {
                self.buttonNo5.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var mainMenuButton: UIButton! {
        didSet {
            mainMenuButton.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.5,initialSpringVelocity: 5, options: .CurveLinear, animations: {
                self.mainMenuButton.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBAction func taaLogoButton(sender: UIButton) {
        let url = NSURL(string: "http://en.theappacademy.nl")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // TUTORIALS BUTTON
    @IBAction func buttonNo1Pressed(sender: UIButton) {
        if tutorialStore!.count != 0 {
            if buttonNo1.imageView?.image == tutorialsImage {
                showTutorials()
                quizOrTutorial = "tutorial"
            } else if quizOrTutorial == "tutorial" {
                findIndexOfTutorialFromImage(sender)
                print(indexOfSelectedItem)
                performSegueWithIdentifier("showTutorial", sender: sender)
            } else if quizOrTutorial == "quiz" {
                let index = findIndexOfQuizFromImage(sender)
                showQuiz(index)
            }
        }
    }
    
    // APP ACADEMY FAQ BUTTON
    @IBAction func button2Pressed(sender: UIButton) {
        if buttonNo2.imageView?.image == faqImage {
            performSegueWithIdentifier("showFAQ", sender: sender)
        } else if quizOrTutorial == "tutorial" {
            findIndexOfTutorialFromImage(sender)
            print(indexOfSelectedItem)
            performSegueWithIdentifier("showTutorial", sender: sender)
        } else if quizOrTutorial == "quiz" {
            let index = findIndexOfQuizFromImage(sender)
            showQuiz(index)
        }
    }
    
    // QUIZ BUTTON
    @IBAction func button3Pressed(sender: UIButton) {
        if quizStore!.count != 0 {
            if buttonNo3.imageView?.image == quizImage {
                showQuizzes()
                quizOrTutorial = "quiz"
            } else if quizOrTutorial == "tutorial" {
                findIndexOfTutorialFromImage(sender)
                print(indexOfSelectedItem)
                performSegueWithIdentifier("showTutorial", sender: sender)
            } else if quizOrTutorial == "quiz" {
                let index = findIndexOfQuizFromImage(sender)
                showQuiz(index)
            }
        }
    }
    
    @IBAction func button4Pressed(sender: UIButton) {
        if quizOrTutorial == "tutorial" {
            findIndexOfTutorialFromImage(sender)
            print(indexOfSelectedItem)
            performSegueWithIdentifier("showTutorial", sender: sender)
        } else if quizOrTutorial == "quiz" {
            let index = findIndexOfQuizFromImage(sender)
            showQuiz(index)
        }
    }
    
    @IBAction func showMoreTutorials(sender: UIButton) {
        showTutorials()
    }
    
    @IBAction func goToMainMenu(sender: UIButton) {
        if mainMenuButton.imageView?.image == mainMenuImage && quizOrTutorial == "tutorial" {
            quizOrTutorial = ""
            showMainMenu()
        } else if mainMenuButton.imageView?.image == mainMenuImage && quizOrTutorial == "quiz" {
            animateMainMenu()
        }
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        
        
    }
    
    func randomNumber() -> Double {
        let randomNumber = Double(arc4random_uniform(2))
        print("Random number is: \(randomNumber)")
        return randomNumber
    }
    
    func setImages() {
        var i = 0
        
        while tutorialStore.count == 0 || quizStore.count == 0 {
        }
        
        if tutorialStore.count != 0 {
            while i < tutorialStore!.count {
                tutorialIcons.append(UIImage(named: tutorialStore![i].iconName!)!)
                i += 1
            }
        }
        
        if quizStore.count != 0 {
            i = 0
            while i < quizStore!.count {
                quizIcons.append(UIImage(named: quizStore![i].iconName!)!)
                i += 1
            }
        }
    }
    
    func findIndexOfTutorialFromImage(button: UIButton) -> Int {
        for image in 0..<tutorialIcons.count {
            if UIImage(named: tutorialStore[image].iconName!) == button.imageView?.image {
                indexOfSelectedItem = image
            }
        }
        return indexOfSelectedItem
    }
    
    func findIndexOfQuizFromImage(button: UIButton) -> Int {
        for image in 0..<quizIcons.count {
            if UIImage(named: quizStore[image].iconName!) == button.imageView?.image {
                indexOfSelectedItem = image
            }
        }
        return indexOfSelectedItem
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTutorial" {
            
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let tutorialViewController = navigationViewController.childViewControllers[0] as! TutorialVC
            tutorialViewController.indexOfTutorial = indexOfSelectedItem
            tutorialViewController.tutorialStore = self.tutorialStore
        }
        
        if segue.identifier == "showQuiz" {
            
            let quizViewController = segue.destinationViewController as! QuizVC
            quizViewController.indexOfQuiz = indexOfSelectedItem
            quizViewController.quizStore = self.quizStore
        }
    }
    
    // Actions for Quiz Buttons
    
    @IBAction func quizTile1(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile2(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile3(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile4(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile5(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile6(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile7(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile8(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile9(sender: UIButton) {
        showQuizQuestion(sender)
    }
    
    @IBAction func quizTile10(sender: UIButton) {
        showQuizQuestion(sender)
    }
    


    // JSONDelegate methods
    
    func tutorialLoadingFailed(errorMessage: String) {
        let error = errorMessage
        print(error)
    }
    
    func tutorialDataIsLoaded() {
        
    }
    
    func quizLoadingFailed(errorMessage: String) {
        let error = errorMessage
        print(error)
    }
    
    func quizDataIsLoaded() {
        
    }
    
}

