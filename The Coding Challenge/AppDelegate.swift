//
//  AppDelegate.swift
//  CodingChallenge
//
//  Created by Jarle Matland on 06.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var tutorialStore = TutorialStore()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        tutorialStore.loadTutorialsData()
 
        let mainMenuViewController = window?.rootViewController as! MainVC
        mainMenuViewController.tutorialStore = tutorialStore
        
     
        return true
    }

    
}

