//
//  TutorialVCExt.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 23.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

// **** Functions that are part of the tutorials ***
extension TutorialVC {
    
    // Function to perform functions as part of a tutorial. Get this function from the hson file
    func performAction(_ code: String) {
        perform(NSSelectorFromString(code))
    }
    
    // Part of the DISPLAY A PICTURE tutorial
    func takeAPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Part of the DISPLAY A PICTURE tutorial
    func chooseAPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Part of the DISPLAY A PICTURE tutorial
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Chooses the original image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Display the image in the app
            newImage = pickedImage
            
        }
        
        let currentChallenge = tutorial.challenges[indexOfChallenges]
        let overlayVC = storyboard!.instantiateViewController(withIdentifier: "TutorialOverlayVC") as! TutorialOverlayVC
        prepareOverlayVC(overlayVC)
        
        overlayVC.updateOverlay(tutorial.name!, correctAnswer: currentChallenge.correctAnswerText!, currentChallenge: indexOfChallenges, totalChallenges: numberOfChallenges, endText: tutorial.endText!, displayImage: "fromTakenPhoto", imageName: "", image: newImage)
        
        dismiss(animated: true, completion: nil)
        present(overlayVC, animated: true, completion: nil)
    }

}
