//
//  Tutorial.swift
//  newTestRegEx
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public struct Tutorial {
    
    public var tutorialDictionary = [String: AnyObject]()
    public var challenges = [Challenge]()
    
    public var name: String?
    public var imageName: String?
    public var introText: String?
    public var challengeDict: Array<NSDictionary>?
    public var endText: String?
    
    public init?(dictionary: NSDictionary) {
        let name = dictionary["name"] as? String
        let imageName = dictionary["imageName"] as? String
        let introText = dictionary["introText"] as? String
        let challengeDict = dictionary["challenges"] as! Array<NSDictionary>
        let endText = dictionary["endTutorialText"] as? String
        
        self.name = name
        self.imageName = imageName
        self.introText = introText
        self.challengeDict = challengeDict
        self.endText = endText
        
        self.challenges = challengeDict.map(Challenge.init).flatMap({ $0 })
        
    }
}

public struct Challenge {
    
    public var text: String?
    public var code: String?
    public var input1: String?
    public var input2: String?
    public var input3: String?
    public var correctInput: Int?
    public var correctAnswerText: String?
    
    public init?(dictionary: NSDictionary) {
        let text = dictionary["text"] as? String
        let code = dictionary["code"] as? String
        let input1 = dictionary["input1"] as? String
        let input2 = dictionary["input2"] as? String
        let input3 = dictionary["input3"] as? String
        let correctInput = dictionary["correctInput"] as? Int
        let correctAnswerText = dictionary["correctAnswerText"] as? String
        
        self.text = text
        self.code = code
        self.input1 = input1
        self.input2 = input2
        self.input3 = input3
        self.correctInput = correctInput
        self.correctAnswerText = correctAnswerText
        
    }
    
}
