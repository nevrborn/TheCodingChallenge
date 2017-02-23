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
    
    var button: UIButton?
    
    var currentQuestion: Question!
    var quizName = ""
    var userAnswer: Int = 0
    
    var score: Double = 0
    var pointsToScore: Double = 10
    var correctAnswerNeeded = false
    
    var optionImage = UIImage(named: "tutorialOption.png")
    var selectedOptionImage = UIImage(named: "tutorialOptionSelected.png")
    var wrongOptionImage = UIImage(named: "tutorialOptionWrong.png")
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var option1Button: UIButton!
    @IBOutlet var option2Button: UIButton!
    @IBOutlet var option3Button: UIButton!
    @IBOutlet var option4Button: UIButton!
    @IBOutlet var runButton: UIButton!
    @IBOutlet var quizView: UIView!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var quizNameLabel: UILabel!
    @IBOutlet var quizHeaderView: UIView!
    
    @IBAction func exitButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToQuiz", sender: self)
    }
    
    @IBAction func option1ButtonPressed(_ sender: UIButton) {
        userAnswer = 1
        option1Button.setBackgroundImage(selectedOptionImage, for: UIControlState())
        option2Button.setBackgroundImage(optionImage, for: UIControlState())
        option3Button.setBackgroundImage(optionImage, for: UIControlState())
        option4Button.setBackgroundImage(optionImage, for: UIControlState())
    }
    
    @IBAction func option2ButtonPressed(_ sender: UIButton) {
        userAnswer = 2
        option1Button.setBackgroundImage(optionImage, for: UIControlState())
        option2Button.setBackgroundImage(selectedOptionImage, for: UIControlState())
        option3Button.setBackgroundImage(optionImage, for: UIControlState())
        option4Button.setBackgroundImage(optionImage, for: UIControlState())
    }
    
    
    @IBAction func option3ButtonPressed(_ sender: UIButton) {
        userAnswer = 3
        option1Button.setBackgroundImage(optionImage, for: UIControlState())
        option2Button.setBackgroundImage(optionImage, for: UIControlState())
        option3Button.setBackgroundImage(selectedOptionImage, for: UIControlState())
        option4Button.setBackgroundImage(optionImage, for: UIControlState())
    }
    
    @IBAction func option4ButtonPressed(_ sender: UIButton) {
        userAnswer = 4
        option1Button.setBackgroundImage(optionImage, for: UIControlState())
        option2Button.setBackgroundImage(optionImage, for: UIControlState())
        option3Button.setBackgroundImage(optionImage, for: UIControlState())
        option4Button.setBackgroundImage(selectedOptionImage, for: UIControlState())
    }
    //sharing score on social media.
    @IBAction func share(_ sender: UIButton) {
        let vc = UIActivityViewController(activityItems:["\(Int(score)) / 100 points on the \(quizName) quiz with CodeChallenge app.\r\r Interested in coding? Check out @AppAcademyNL"], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    //RunButton to display answers options.
    @IBAction func runButton(_ sender: AnyObject) {
        
        if userAnswer == currentQuestion.correctOption && correctAnswerNeeded == false {
            score = ceil(pointsToScore)
            option1Button.isHidden = true
            option2Button.isHidden = true
            option3Button.isHidden = true
            option4Button.isHidden = true
            correctLabel.isHidden = false
            quizHeaderView.isHidden = true
            questionLabel.text = currentQuestion?.correctAnswerText
            runButton.setTitle("Next question", for: UIControlState())
            correctAnswerNeeded = true
        
        } else if userAnswer == currentQuestion.correctOption && correctAnswerNeeded == true {
            self.performSegue(withIdentifier: "unwindToQuiz", sender: self)
            correctAnswerNeeded = false
        }
        else if userAnswer != currentQuestion.correctOption {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            pointsToScore = pointsToScore - 3
            
            if pointsToScore <= 0 {
                pointsToScore = 0
            }
            
            if userAnswer == 1 {
                option1Button.setBackgroundImage(wrongOptionImage, for: UIControlState())
                option2Button.setBackgroundImage(optionImage, for: UIControlState())
                option3Button.setBackgroundImage(optionImage, for: UIControlState())
                option4Button.setBackgroundImage(optionImage, for: UIControlState())
                
                option1Button.setTitle("Wrong answer. Try again!", for: UIControlState())
                option2Button.setTitle(currentQuestion.option2! as String, for: UIControlState())
                option3Button.setTitle(currentQuestion.option3! as String, for: UIControlState())
                option4Button.setTitle(currentQuestion.option4! as String, for: UIControlState())
            }
            if userAnswer == 2 {
                option1Button.setBackgroundImage(optionImage, for: UIControlState())
                option2Button.setBackgroundImage(wrongOptionImage, for: UIControlState())
                option3Button.setBackgroundImage(optionImage, for: UIControlState())
                option4Button.setBackgroundImage(optionImage, for: UIControlState())
                
                option1Button.setTitle(currentQuestion.option1! as String, for: UIControlState())
                option2Button.setTitle("Wrong answer. Try again!", for: UIControlState())
                option3Button.setTitle(currentQuestion.option3! as String, for: UIControlState())
                option4Button.setTitle(currentQuestion.option4! as String, for: UIControlState())
            }
            if userAnswer == 3 {
                option1Button.setBackgroundImage(optionImage, for: UIControlState())
                option2Button.setBackgroundImage(optionImage, for: UIControlState())
                option3Button.setBackgroundImage(wrongOptionImage, for: UIControlState())
                option4Button.setBackgroundImage(optionImage, for: UIControlState())
                
                option1Button.setTitle(currentQuestion.option1! as String, for: UIControlState())
                option2Button.setTitle(currentQuestion.option2! as String, for: UIControlState())
                option3Button.setTitle("Wrong answer. Try again!", for: UIControlState())
                option4Button.setTitle(currentQuestion.option4! as String, for: UIControlState())
            }
            if userAnswer == 4 {
                option1Button.setBackgroundImage(optionImage, for: UIControlState())
                option2Button.setBackgroundImage(optionImage, for: UIControlState())
                option3Button.setBackgroundImage(optionImage, for: UIControlState())
                option4Button.setBackgroundImage(wrongOptionImage, for: UIControlState())
                
                option1Button.setTitle(currentQuestion.option1! as String, for: UIControlState())
                option2Button.setTitle(currentQuestion.option2! as String, for: UIControlState())
                option3Button.setTitle(currentQuestion.option3! as String, for: UIControlState())
                option4Button.setTitle("Wrong answer. Try again!", for: UIControlState())
            }
        }
    }
    
    override func viewDidLoad() {

        questionLabel.text = currentQuestion!.question
        option1Button.setTitle(currentQuestion!.option1! as String, for: UIControlState())
        option2Button.setTitle(currentQuestion!.option2! as String, for: UIControlState())
        option3Button.setTitle(currentQuestion!.option3! as String, for: UIControlState())
        option4Button.setTitle(currentQuestion!.option4! as String, for: UIControlState())
        
        option1Button.isHidden = false
        option2Button.isHidden = false
        option3Button.isHidden = false
        option4Button.isHidden = false

        correctLabel.isHidden = true
        quizHeaderView.isHidden = false
        quizNameLabel.text = quizName
        
        runButton.setTitle("Answer", for: UIControlState())
        
        correctAnswerNeeded = false

    }
    //Going back to the MainVC.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToQuiz" {

            let mainViewController = segue.destination as! MainVC
            
            mainViewController.quizScore = mainViewController.quizScore + Int(score)
            mainViewController.scoreTile.setTitle("\(mainViewController.quizScore) / 100\r points", for: .disabled)
            
            if mainViewController.numberOfQuestionsFinished == 10 {
                mainViewController.scoreTile.setBackgroundImage(UIImage(named: "finishedQuizTile.png"), for: UIControlState())
                mainViewController.scoreTile.setTitle("Press me!!", for: UIControlState())
                mainViewController.scoreTile.isEnabled = true
            }
            
            let quizUnwindSegue = segue as! QuizUnwindSegue
            quizUnwindSegue.button = button
            
            
        }
    }
    
}
