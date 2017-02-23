//
//  QuizStore.swift
//  The Coding Challenge
//
//  Created by Jarle Matland on 14.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public protocol JSONQuizSourceDelegate {
    func quizDataIsLoaded()
    func quizLoadingFailed(_ errorMessage: String)
}

open class QuizStore {
    
    internal var delegate: JSONQuizSourceDelegate?
    internal var count: Int {
        return quiz.count
    }
    
    subscript(index: Int) -> Quiz {
        return quiz[index]
    }
    
    fileprivate var session = URLSession(configuration: URLSessionConfiguration.default)
    
    fileprivate var quiz = [Quiz]()
    
    // Fetching Quiz from the server/JSON.
    open func loadQuizData() {
        let JSONFileURL = Bundle.main.url(forResource: "quiz", withExtension: ".json")!
        let task = session.dataTask(with: JSONFileURL, completionHandler: { (data, response, error) in
            guard let data = data else {
                self.failed("Quiz: Data did not come back from the server")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? NSDictionary else {
                self.failed("Quiz: Data from the server was not valid JSON")
                return
            }
            
            guard let quizInfo = json["quiz"] as? Array<NSDictionary> else {
                self.failed("Quiz: The JSON format from the server changed!")
                return
            }
            
            self.quiz = quizInfo.map(Quiz.init).flatMap({ $0 })
            
            OperationQueue.main.addOperation({
                self.delegate?.quizDataIsLoaded()
            })
        }) 
        task.resume()
    }
    
    fileprivate func failed(_ message: String) {
        OperationQueue.main.addOperation({
            self.delegate?.quizLoadingFailed(message)
        })
        return
    }
    
}
