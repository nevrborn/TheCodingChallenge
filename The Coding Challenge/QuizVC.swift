//
//  QuizVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
    
    var quizStore: QuizStore!
    var quiz: Quiz!
    
    var indexOfQuiz: Int?
    var userAnswer: Int = 0
    
    var indexOfQuestion: Int = 0
    var lastchallenge = false
    var numberOfQuestions: Int = 0
    var lastQuestion = false
    var score: Double = 0
    var pointsPerQuestion: Double = 0
    var pointsToScore: Double = 0
    var firstTimeLoad = true
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var option4Button: UIButton!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var progressView: UIProgressView!
    
    @IBAction func option1ButtonPressed(sender: UIButton) {
        userAnswer = 1
        sender.setTitleColor(UIColor.greenColor(), forState: .Normal)
        option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func option2ButtonPressed(sender: UIButton) {
        userAnswer = 2
        sender.setTitleColor(UIColor.greenColor(), forState: .Normal)
        option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func option3ButtonPressed(sender: UIButton) {
        userAnswer = 3
        sender.setTitleColor(UIColor.greenColor(), forState: .Normal)
        option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func option4ButtonPressed(sender: UIButton) {
        userAnswer = 4
        sender.setTitleColor(UIColor.greenColor(), forState: .Normal)
        option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    @IBAction func share(sender: UIButton) {
        let vc = UIActivityViewController(activityItems:["\(Int(score)) / 100 points on the \(quiz.name!) quiz with CodeChallenge app.\r\r Interested in coding? Check out @AppAcademyNL"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func runButton(sender: AnyObject) {
        
        if userAnswer == quiz.questions[indexOfQuestion].correctOption {
            let percentage = Float(calculatePercentage(indexOfQuestion))
            progressView.setProgress(percentage, animated: true)
            score = score + pointsToScore
            self.navigationController?.popViewControllerAnimated(true)
            
            if indexOfQuestion != numberOfQuestions {
                indexOfQuestion += 1
                pointsToScore = pointsPerQuestion
                nextQuestion(indexOfQuestion)
                
                option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                
            } else if indexOfQuestion == numberOfQuestions && lastQuestion == false {
                questionLabel.text = quiz.endQuizText
                runButton.setTitle("Go to more Quizzes!", forState: .Normal)
                //shareButton.hidden = false
                option1Button.hidden = true
                option2Button.hidden = true
                option3Button.hidden = true
                option4Button.hidden = true
                lastQuestion = true
            } else if lastQuestion == true {
                self.performSegueWithIdentifier("unwindToMenu", sender: self)
                lastQuestion = false
            }

        } else if userAnswer != quizStore[indexOfQuiz!].questions[indexOfQuestion].correctOption {
            if userAnswer == 1 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setTitleColor(UIColor.redColor(), forState: .Normal)
                option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
            if userAnswer == 2 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option2Button.setTitleColor(UIColor.redColor(), forState: .Normal)
                option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
            if userAnswer == 3 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option3Button.setTitleColor(UIColor.redColor(), forState: .Normal)
                option4Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
            }
            if userAnswer == 4 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option2Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option3Button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                option4Button.setTitleColor(UIColor.redColor(), forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {
//        quiz = quizStore[indexOfQuiz!]
//        numberOfQuestions = quiz.questions.count - 1
//        let question = quiz.questions[indexOfQuestion]
//        pointsPerQuestion = Double(100 / quiz.questions.count)
//        
//        if firstTimeLoad == true {
//            pointsToScore = pointsPerQuestion
//            firstTimeLoad = false
//        }
//        
//        
//        questionLabel.text = question.question
//        option1Button.setTitle(question.option1! as String, forState: .Normal)
//        option2Button.setTitle(question.option2! as String, forState: .Normal)
//        option3Button.setTitle(question.option3! as String, forState: .Normal)
//        option4Button.setTitle(question.option4! as String, forState: .Normal)
//        
//        //shareButton.hidden = true
    }
    
    func nextQuestion(questionIndex: Int) {
        
        let question = quiz.questions[indexOfQuestion]
        
        questionLabel.text = question.question
        option1Button.setTitle(question.option1! as String, forState: .Normal)
        option2Button.setTitle(question.option2! as String, forState: .Normal)
        option3Button.setTitle(question.option3! as String, forState: .Normal)
        option4Button.setTitle(question.option4! as String, forState: .Normal)
        
    }
    
    func calculatePercentage(indexOfCurrentQuiz: Int) -> Double {
        
        let percentage = Double(indexOfCurrentQuiz+1) / Double(quiz.questions.count)
        
        return percentage
    }
    
}
