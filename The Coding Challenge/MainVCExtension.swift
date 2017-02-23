//
//  MainExtensionTutorials.swift
//  CodingChallenge
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

extension MainVC {
    
    // SGo back to main menu from tutorial or quiz
    func showMainMenu() {
        
        buttonNo1.setImage(tutorialsImage, for: UIControlState())
        buttonNo2.setImage(faqImage, for: UIControlState())
        buttonNo3.setImage(quizImage, for: UIControlState())
        buttonNo5.setImage(logoImage, for: UIControlState())
        
        buttonNo1.isHidden = false
        buttonNo2.isHidden = false
        buttonNo3.isHidden = false
        buttonNo4.isHidden = true
        buttonNo5.isHidden = false
        mainMenuButton.isHidden = true
        
        buttonNo1.isEnabled = true
        buttonNo2.isEnabled = true
        buttonNo3.isEnabled = true
        buttonNo4.isEnabled = false
        buttonNo5.isEnabled = false
        mainMenuButton.isEnabled = false
        
        quizTile1.isEnabled = false
        quizTile2.isEnabled = false
        quizTile3.isEnabled = false
        quizTile4.isEnabled = false
        quizTile5.isEnabled = false
        quizTile6.isEnabled = false
        quizTile7.isEnabled = false
        quizTile8.isEnabled = false
        quizTile9.isEnabled = false
        quizTile10.isEnabled = false
        quizMainMenu.isEnabled = false
        scoreTile.isEnabled = false
        
        quizTile1.isHidden = true
        quizTile2.isHidden = true
        quizTile3.isHidden = true
        quizTile4.isHidden = true
        quizTile5.isHidden = true
        quizTile6.isHidden = true
        quizTile7.isHidden = true
        quizTile8.isHidden = true
        quizTile9.isHidden = true
        quizTile10.isHidden = true
        quizMainMenu.isHidden = true
        scoreTile.isHidden = true
        
        logoButton.isHidden = false
        logoButton.isEnabled = true
        codeChallengeLogo.isHidden = false
        
    }
    
    // Show the Tutorials menu
    func showTutorials() {
        
        buttonNo5.setImage(moreTutorialsImage, for: UIControlState())
        mainMenuButton.setImage(mainMenuImage, for: UIControlState())
        
        buttonNo4.isEnabled = true
        buttonNo5.isEnabled = true
        mainMenuButton.isEnabled = true
        mainMenuButton.isHidden = false
        
        indexOfPage = 0
        
        // Calculate the number of pages needed and number of tutorials on the last page
        if tutorialStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = tutorialStore.count
            buttonNo5.setImage(logoImage, for: UIControlState())
            buttonNo5.isEnabled = false
        } else {
            numberOfPagesNeeded = Double(tutorialStore.count) / 4.0
            numberOfPagesTotal = Int(ceil(numberOfPagesNeeded))
            numberOfItemsOnLastPage = 4 - Int((numberOfPagesTotal * 4) - tutorialStore.count)
        }
        
        // If already on the last page of tutorials, then go to the first page
        if indexOfPage == numberOfPagesTotal - 1 {
            indexOfPage = 0
        } else {
            indexOfPage += 1
        }
        
        if indexOfPage <= numberOfPagesTotal - 1 {
            
            let startIndexOfPicForPage = indexOfPage * 4
            
            // Only display the number of tutorials that is needed on the last page
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = true
                self.buttonNo3.isHidden = true
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = false
                self.buttonNo3.isEnabled = false
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = true
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = false
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], for: UIControlState())
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = false
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = true
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], for: UIControlState())
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], for: UIControlState())
                buttonNo4.setImage(tutorialIcons[startIndexOfPicForPage+3], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = false
                self.buttonNo4.isHidden = false
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = true
                self.buttonNo4.isEnabled = true
            }
        }
    }
    
    // Show the Quiz menu
    func showQuizzes() {
        
        buttonNo5.setImage(moreTutorialsImage, for: UIControlState())
        mainMenuButton.setImage(mainMenuImage, for: UIControlState())
        
        buttonNo4.isEnabled = true
        buttonNo5.isEnabled = true
        mainMenuButton.isEnabled = true
        mainMenuButton.isHidden = false
        scoreTile.isEnabled = false
        
        
        indexOfPage = 0
        
        // Calculate the number of pages needed and number of quizzes on the last page
        if quizStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = quizStore.count
            buttonNo5.setImage(logoImage, for: UIControlState())
            buttonNo5.isEnabled = false
        } else {
            numberOfPagesNeeded = Double(quizStore.count) / 4.0
            numberOfPagesTotal = Int(ceil(numberOfPagesNeeded))
            numberOfItemsOnLastPage = 4 - Int((numberOfPagesTotal * 4) - quizStore.count)
        }
        
        // If already on the last page of tutorials, then go to the first page
        if indexOfPage == numberOfPagesTotal - 1 {
            indexOfPage = 0
        } else {
            indexOfPage += 1
        }
        
        if indexOfPage <= numberOfPagesTotal - 1 {
            
            let startIndexOfPicForPage = indexOfPage * 4
            
            // Only display the number of quizzes that is needed on the last page
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = true
                self.buttonNo3.isHidden = true
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = false
                self.buttonNo3.isEnabled = false
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = true
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = false
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], for: UIControlState())
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = false
                self.buttonNo4.isHidden = true
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = true
                self.buttonNo4.isEnabled = false
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], for: UIControlState())
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], for: UIControlState())
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], for: UIControlState())
                buttonNo4.setImage(quizIcons[startIndexOfPicForPage+3], for: UIControlState())
                
                self.buttonNo1.isHidden = false
                self.buttonNo2.isHidden = false
                self.buttonNo3.isHidden = false
                self.buttonNo4.isHidden = false
                
                self.buttonNo1.isEnabled = true
                self.buttonNo2.isEnabled = true
                self.buttonNo3.isEnabled = true
                self.buttonNo4.isEnabled = true
            }
        }
    }
    
    // Show the Quiz tiles/questions of a selected Quiz
    func showQuiz(_ quizIndex: Int) {
        
        buttonNo1.isEnabled = false
        buttonNo2.isEnabled = false
        buttonNo3.isEnabled = false
        buttonNo4.isEnabled = false
        buttonNo5.isEnabled = false
        mainMenuButton.isEnabled = false
        
        buttonNo1.isHidden = true
        buttonNo2.isHidden = true
        buttonNo3.isHidden = true
        buttonNo4.isHidden = true
        buttonNo5.isHidden = true
        mainMenuButton.isHidden = true
        
        quizTile1.isEnabled = true
        quizTile2.isEnabled = true
        quizTile3.isEnabled = true
        quizTile4.isEnabled = true
        quizTile5.isEnabled = true
        quizTile6.isEnabled = true
        quizTile7.isEnabled = true
        quizTile8.isEnabled = true
        quizTile9.isEnabled = true
        quizTile10.isEnabled = true
        quizMainMenu.isEnabled = true
        scoreTile.isEnabled = false
        
        quizTile1.isHidden = false
        quizTile2.isHidden = false
        quizTile3.isHidden = false
        quizTile4.isHidden = false
        quizTile5.isHidden = false
        quizTile6.isHidden = false
        quizTile7.isHidden = false
        quizTile8.isHidden = false
        quizTile9.isHidden = false
        quizTile10.isHidden = false
        quizMainMenu.isHidden = false
        scoreTile.isHidden = false
        
        quizTile1.setTitle("?", for: UIControlState())
        quizTile2.setTitle("?", for: UIControlState())
        quizTile3.setTitle("?", for: UIControlState())
        quizTile4.setTitle("?", for: UIControlState())
        quizTile5.setTitle("?", for: UIControlState())
        quizTile6.setTitle("?", for: UIControlState())
        quizTile7.setTitle("?", for: UIControlState())
        quizTile8.setTitle("?", for: UIControlState())
        quizTile9.setTitle("?", for: UIControlState())
        quizTile10.setTitle("?", for: UIControlState())
        
        scoreTile.setBackgroundImage(UIImage(named: "emptyTile.png"), for: UIControlState())
        scoreTile.setTitle("0 / 100\rpoints", for: .disabled)

        codeChallengeLogo.isHidden = true
        logoButton.isHidden = true
        logoButton.isEnabled = false
        
        animateQuizButtons()
        
    }
    
    //Animation of Quiz Buttons
    func animateQuizButtons() {
        quizTile1.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.9, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile1.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile2.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0.8, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile2.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile3.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0.7, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile3.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile4.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile4.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile5.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile5.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile6.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.3, delay: 0.4, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile6.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile7.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile7.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile8.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.6, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile8.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile9.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile9.transform = CGAffineTransform.identity }, completion: nil
        )
        
        quizTile10.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.3,initialSpringVelocity: 4, options: .curveLinear, animations: {
            self.quizTile10.transform = CGAffineTransform.identity }, completion: nil
        )
        
    }
    
    
    func randomNumber() -> Double {
        let randomNumber = Double(arc4random_uniform(1))
        return randomNumber
    }
    
}

