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
        buttonNo3.setImage(iosImage, forState: .Normal)
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
    
    // When pressing Tutorials button
    func showTutorials() {
        
        buttonNo5.setImage(moreTutorialsImage, forState: .Normal)
        mainMenuButton.setImage(mainMenuImage, forState: .Normal)
        
        buttonNo4.enabled = true
        buttonNo5.enabled = true
        mainMenuButton.enabled = true
        mainMenuButton.hidden = false
        
        indexOfTutorialsPage = 0
        
        if tutorialStore.count <= 4 {
            numberOfTutorialPagesNeeded = 1
            numberOfTutorialPagesTotal = 1
            numberOfTutorialsOnLastPage = tutorialStore.count
            buttonNo5.setImage(logoImage, forState: .Normal)
            buttonNo5.enabled = false
        } else {
            numberOfTutorialPagesNeeded = Double(tutorialStore.count) / 4.0
            numberOfTutorialPagesTotal = Int(ceil(numberOfTutorialPagesNeeded))
            numberOfTutorialsOnLastPage = 4 - Int((numberOfTutorialPagesTotal * 4) - tutorialStore.count)
        }
        
        // If already on the last page of tutorials, then go to the first page
        if indexOfTutorialsPage == numberOfTutorialPagesTotal - 1 {
            indexOfTutorialsPage = 0
        } else {
            indexOfTutorialsPage += 1
        }
        
        if indexOfTutorialsPage <= numberOfTutorialPagesTotal - 1 {
            
            let startIndexOfPicForPage = indexOfTutorialsPage * 4
            
            if numberOfTutorialsOnLastPage == 1 {
                buttonNo1.setImage(tutorialImages[startIndexOfPicForPage], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = true
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfTutorialsOnLastPage == 2 {
                buttonNo1.setImage(tutorialImages[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialImages[startIndexOfPicForPage+1], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = true
                self.buttonNo4.hidden = true
            }
            
            if numberOfTutorialsOnLastPage == 3 {
                buttonNo1.setImage(tutorialImages[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialImages[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialImages[startIndexOfPicForPage+2], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = true
            }
            
            if numberOfTutorialsOnLastPage == 4 {
                buttonNo1.setImage(tutorialImages[startIndexOfPicForPage], forState: .Normal)
                buttonNo2.setImage(tutorialImages[startIndexOfPicForPage+1], forState: .Normal)
                buttonNo3.setImage(tutorialImages[startIndexOfPicForPage+2], forState: .Normal)
                buttonNo4.setImage(tutorialImages[startIndexOfPicForPage+3], forState: .Normal)
                
                self.buttonNo1.hidden = false
                self.buttonNo2.hidden = false
                self.buttonNo3.hidden = false
                self.buttonNo4.hidden = false
            }
        }
    }

    
}
