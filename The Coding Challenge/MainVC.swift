//
//  ViewController.swift
//  CodeChallenge
//
//  Created by Jarle Matland on 31.03.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class MainVC: UIViewController, JSONSourceDelegate {
    
    var indexOfTutorialsPage = 0
    var numberOfTutorialPagesNeeded: Double = 1.0
    var numberOfTutorialPagesTotal = 0
    var numberOfTutorialsOnLastPage = 0
    var tutorialStore: TutorialStore!
    var indexOfSelectedTutorial = 0
    
    var tutorialsImage = UIImage(named: "tutorialsIcon")
    var faqImage = UIImage(named: "faqIcon")
    var iosImage = UIImage(named: "iosIcon")
    var moreTutorialsImage = UIImage(named: "tutMore")
    var mainMenuImage = UIImage(named: "tutMainMenu")
    var logoImage = UIImage(named: "taaLogo")
    var tutorialImages: [UIImage] = []
    
    override func viewDidLoad() {
        
        tutorialStore?.loadTutorialsData()
        
        buttonNo1.imageView?.image = tutorialsImage
        buttonNo2.imageView?.image = faqImage
        buttonNo3.imageView?.image = iosImage
        
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
        
        setImages()
        
        super.viewDidLoad()
    }
    
    @IBOutlet weak var buttonNo1: UIButton! {
        didSet {
            buttonNo1.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo1.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo2: UIButton! {
        didSet {
            buttonNo2.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
                self.buttonNo2.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var buttonNo3: UIButton! {
        didSet {
            buttonNo3.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.6,initialSpringVelocity: 3, options: .CurveLinear, animations: {
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
            UIView.animateWithDuration(2.0, delay: 1, usingSpringWithDamping: 0.6,initialSpringVelocity: 5, options: .CurveLinear, animations: {
                self.buttonNo5.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBOutlet weak var mainMenuButton: UIButton! {
        didSet {
            mainMenuButton.transform = CGAffineTransformMakeScale(0, 0)
            UIView.animateWithDuration(2.0, delay: 0.2, usingSpringWithDamping: 0.5,initialSpringVelocity: 5, options: .CurveLinear, animations: {
                self.mainMenuButton.transform = CGAffineTransformIdentity }, completion: nil
            )}
    }
    
    @IBAction func buttonNo1Pressed(sender: UIButton) {
        if tutorialStore!.count != 0 {
            if buttonNo1.imageView?.image == tutorialsImage {
                showTutorials()
            } else {
                findIndexOfTutorialFromImage(sender)
                print(indexOfSelectedTutorial)
                performSegueWithIdentifier("showTutorial", sender: sender)
            }
        }
    }
    
    @IBAction func button2Pressed(sender: UIButton) {
        if buttonNo2.imageView?.image == faqImage {
            
        } else {
            findIndexOfTutorialFromImage(sender)
            print(indexOfSelectedTutorial)
            performSegueWithIdentifier("showTutorial", sender: sender)
        }
    }
    
    @IBAction func button3Pressed(sender: UIButton) {
        if buttonNo3.imageView?.image == iosImage {
            
        } else {
            findIndexOfTutorialFromImage(sender)
            print(indexOfSelectedTutorial)
            performSegueWithIdentifier("showTutorial", sender: sender)
        }
    }
    
    
    
    @IBAction func button4Pressed(sender: UIButton) {
        findIndexOfTutorialFromImage(sender)
        print(indexOfSelectedTutorial)
    }
    
    
    @IBAction func showMoreTutorials(sender: UIButton) {
        showTutorials()
    }
    
    @IBAction func goToMainMenu(sender: UIButton) {
        if mainMenuButton.imageView?.image == mainMenuImage {
            showMainMenu()
        }
    }
    
    func randomNumber() -> Double {
        let randomNumber = Double(arc4random_uniform(2))
        print("Random number is: \(randomNumber)")
        return randomNumber
    }
    
    func setImages() {
        var i = 0
        
        while tutorialStore.count == 0 {
        }
        
        while i < tutorialStore!.count {
            tutorialImages.append(UIImage(named: tutorialStore![i].imageName!)!)
            i += 1
        }
    }
    
    func findIndexOfTutorialFromImage(button: UIButton) -> Int {
        for image in 0..<tutorialImages.count {
            if UIImage(named: tutorialStore[image].imageName!) == button.imageView?.image {
                indexOfSelectedTutorial = image
            }
        }
        return indexOfSelectedTutorial
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTutorial" {
            
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let tutorialViewController = navigationViewController.childViewControllers[0] as! TutorialVC
            tutorialViewController.indexOfTutorial = indexOfSelectedTutorial
            tutorialViewController.tutorialStore = self.tutorialStore
        }
    }
    
    func loadingFailed(errorMessage: String) {
        let error = errorMessage
        print(error)
    }
    
    func dataIsLoaded() {
    }
    
    
}

