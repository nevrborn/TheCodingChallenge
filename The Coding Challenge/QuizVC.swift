//
//  QuizVC.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import AudioToolbox

class QuizVC: UIViewController {
    
    var quizStore: QuizStore!
    var quiz: Quiz!
    
    var button: UIButton?
    
    
    var indexOfQuiz: Int?
    var indexOfQuestion: Int = 0
    var userAnswer: Int = 0
    
    var lastchallenge = false
    var numberOfQuestions: Int = 0
    var lastQuestion = false
    var score: Double = 0
    var pointsToScore: Double = 10
    var firstTimeLoad = true
    
    var optionImage = UIImage(named: "questionBar.png")
    var selectedOptionImage = UIImage(named: "questionBarGreen.png")
    var wrongOptionImage = UIImage(named: "questionBarRed.png")
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var option4Button: UIButton!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var quizView: UIView!
    
    @IBAction func option1ButtonPressed(sender: UIButton) {
        userAnswer = 1
        option1Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    @IBAction func option2ButtonPressed(sender: UIButton) {
        userAnswer = 2
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    @IBAction func option3ButtonPressed(sender: UIButton) {
        userAnswer = 3
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
        option4Button.setBackgroundImage(optionImage, forState: .Normal)
    }
    
    @IBAction func option4ButtonPressed(sender: UIButton) {
        userAnswer = 4
        option1Button.setBackgroundImage(optionImage, forState: .Normal)
        option2Button.setBackgroundImage(optionImage, forState: .Normal)
        option3Button.setBackgroundImage(optionImage, forState: .Normal)
        option4Button.setBackgroundImage(selectedOptionImage, forState: .Normal)
    }
    
    @IBAction func share(sender: UIButton) {
        let vc = UIActivityViewController(activityItems:["\(Int(score)) / 100 points on the \(quiz.name!) quiz with CodeChallenge app.\r\r Interested in coding? Check out @AppAcademyNL"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func runButton(sender: AnyObject) {
        
        let currentQuestion = quiz.questions[indexOfQuestion]
        
        if userAnswer == currentQuestion.correctOption {
            score = ceil(pointsToScore)
            self.performSegueWithIdentifier("unwindToQuiz", sender: self)


        } else if userAnswer != quizStore[indexOfQuiz!].questions[indexOfQuestion].correctOption {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            if userAnswer == 1 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 2 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 3 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                option4Button.setBackgroundImage(optionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle("Wrong answer. Try again!", forState: .Normal)
                option4Button.setTitle(currentQuestion.option4! as String, forState: .Normal)
            }
            if userAnswer == 4 {
                pointsToScore = pointsToScore * 0.8
                option1Button.setBackgroundImage(optionImage, forState: .Normal)
                option2Button.setBackgroundImage(optionImage, forState: .Normal)
                option3Button.setBackgroundImage(optionImage, forState: .Normal)
                option4Button.setBackgroundImage(wrongOptionImage, forState: .Normal)
                
                option1Button.setTitle(currentQuestion.option1! as String, forState: .Normal)
                option2Button.setTitle(currentQuestion.option2! as String, forState: .Normal)
                option3Button.setTitle(currentQuestion.option3! as String, forState: .Normal)
                option4Button.setTitle("Wrong answer. Try again!", forState: .Normal)
            }
        }
    }
    
    override func viewDidLoad() {
        quiz = quizStore[indexOfQuiz!]
        numberOfQuestions = quiz.questions.count - 1
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "unwindToQuiz" {

            let mainViewController = segue.destinationViewController as! MainVC
            
            mainViewController.quizScore = mainViewController.quizScore + Int(score)
            mainViewController.scoreTile.setTitle("\(mainViewController.quizScore) / 100\rpoints", forState: .Normal)
            
            if mainViewController.numberOfQuestionsFinished == 10 {
                mainViewController.scoreTile.setBackgroundImage(UIImage(named: "finishedQuizTile.png"), forState: .Normal)
                mainViewController.scoreTile.enabled = true
            }
            
            let quizUnwindSegue = segue as! QuizUnwindSegue
            quizUnwindSegue.button = button
            
            
        }
    }
    
}
