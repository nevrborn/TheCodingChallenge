//
//  JSONDataManager.swift
//  newTestRegEx
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public protocol JSONSourceDelegate {
    func tutorialDataIsLoaded()
    func tutorialLoadingFailed(_ errorMessage: String)
}

open class TutorialStore {
    
    internal var delegate: JSONSourceDelegate?
    internal var count: Int {
        return tutorials.count
    }
    
    subscript(index: Int) -> Tutorial {
        return tutorials[index]
    }
    
    fileprivate var session = URLSession(configuration: URLSessionConfiguration.default)
    
    fileprivate var tutorials = [Tutorial]()
    
    // Fetching Tutorials from JSON File.
    open func loadTutorialsData() {
        let JSONFileURL = Bundle.main.url(forResource: "tutorials", withExtension: ".json")!
        let task = session.dataTask(with: JSONFileURL, completionHandler: { (data, response, error) in
            guard let data = data else {
                self.failed("Data did not come back from the server")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? NSDictionary else {
                self.failed("Data from the server was not valid JSON")
                return
            }
            
            guard let tutorialInfo = json["tutorials"] as? Array<NSDictionary> else {
                self.failed("The JSON format from the server changed!")
                return
            }
            
            self.tutorials = tutorialInfo.map(Tutorial.init).flatMap({ $0 })
            
            OperationQueue.main.addOperation({
                self.delegate?.tutorialDataIsLoaded()
            })
        }) 
        task.resume()
    }
    
    fileprivate func failed(_ message: String) {
        OperationQueue.main.addOperation({
            self.delegate?.tutorialLoadingFailed(message)
        })
        return
    }
    
}
