//
//  Quiz.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class Quiz {
    var question: String?
    var iconName: String?
    var option1: String?
    var option2: String?
    var option3: String?
    var option4: String?
    var correctOption: Int?
    var correctAnswerText: String?
    
    init(dictionary: NSDictionary) {
        
        let question = dictionary["question"] as? String
        let iconName = dictionary["iconName"] as? String
        let option1 = dictionary["option1"] as? String
        let option2 = dictionary["option2 "] as? String
        let option3 = dictionary["option3"] as? String
        let option4 = dictionary["option4 "] as? String
        let correctOption = dictionary["correctOption"] as? Int
        let correctAnswerText = dictionary["correctAnswerText"] as? String
        
        self.question = question
        self.iconName = iconName
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.option4 = option4
        self.correctOption = correctOption
        self.correctAnswerText = correctAnswerText
        
    }
}
