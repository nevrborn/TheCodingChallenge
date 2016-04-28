//
//  TutorialVCExt.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 23.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

extension TutorialVC {
    
    func performAction(code: String) {
        performSelector(NSSelectorFromString(code))
    }
    
    func printHello() {
        print("Hello")
    }
    
    func takeAPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func chooseAPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Reading the image from the imagePicker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Chooses the original image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Display the image in the app
            newImage = pickedImage
            
        }
        
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("TutorialOverlayVC") as! TutorialOverlayVC
        prepareOverlayVC(overlayVC)
        
        overlayVC.updateOverlay(currentChallenge.correctAnswerText!, currentChallenge: indexOfChallenges, totalChallenges: numberOfChallenges, endText: tutorial.endText!, displayImage: "fromTakenPhoto", imageName: "", image: newImage)
        
        dismissViewControllerAnimated(true, completion: nil)
        presentViewController(overlayVC, animated: true, completion: nil)
    }

}
