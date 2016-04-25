//
//  TutorialVCExt.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 23.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

extension TutorialVC: UIImagePickerControllerDelegate {
    
    
    func takeAPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // Reading the image from the imagePicker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Chooses the original image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Display the image in the app
            newImage = pickedImage
            
        }
        dismissViewControllerAnimated(true, completion: nil)
    }

}
