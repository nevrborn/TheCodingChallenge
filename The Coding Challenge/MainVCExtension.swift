//
//  MainExtensionTutorials.swift
//  CodingChallenge
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

extension MainVC {
    
    // When pressing Tutorials button
    func showMainMenu() {
        
        buttonNo1.setImage(tutorialsImage, forState: .Normal)
        buttonNo2.setImage(faqImage, forState: .Normal)
        buttonNo3.setImage(quizImage, forState: .Normal)
        buttonNo5.setImage(logoImage, forState: .Normal)
        
        buttonNo1.hidden = false
        buttonNo2.hidden = false
        buttonNo3.hidden = false
        buttonNo4.hidden = true
        buttonNo5.hidden = false
        mainMenuButton.hidden = true
        
        buttonNo4.enabled = false
        buttonNo5.enabled = false
        mainMenuButton.enabled = false
        
    }
    
    // Show Tutorials
    func showTutorials() {
        
        buttonNo5.setImage(moreTutorialsImage, forState: .Normal)
        mainMenuButton.setImage(mainMenuImage, forState: .Normal)
        
        buttonNo4.enabled = true
        buttonNo5.enabled = true
        mainMenuButton.enabled = true
        mainMenuButton.hidden = false
        
        indexOfPage = 0
        
        if tutorialStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = tutorialStore.count
            buttonNo5.setImage(logoImage, forState: .Normal)
            buttonNo5.enabled = false
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
            
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = true
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(tutorialIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialIcons[startIndexOfPicForPage+2], forState: .Normal)
                buttonNo4.setImage(tutorialIcons[startIndexOfPicForPage+3], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = false
            }
        }
    }
    
    // Show Quizzes
    func showQuizzes() {
        
        buttonNo5.setImage(moreTutorialsImage, forState: .Normal)
        mainMenuButton.setImage(mainMenuImage, forState: .Normal)
        
        buttonNo4.enabled = true
        buttonNo5.enabled = true
        mainMenuButton.enabled = true
        mainMenuButton.hidden = false
        
        indexOfPage = 0
        
        if quizStore.count <= 4 {
            numberOfPagesNeeded = 1
            numberOfPagesTotal = 1
            numberOfItemsOnLastPage = quizStore.count
            buttonNo5.setImage(logoImage, forState: .Normal)
            buttonNo5.enabled = false
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
            
            if numberOfItemsOnLastPage == 1 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = true
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 2 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 3 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = true
            }
            
            if numberOfItemsOnLastPage == 4 {
                buttonNo1.setImage(quizIcons[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(quizIcons[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(quizIcons[startIndexOfPicForPage+2], forState: .Normal)
                buttonNo4.setImage(quizIcons[startIndexOfPicForPage+3], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = false
            }
        }
    }

    
}
