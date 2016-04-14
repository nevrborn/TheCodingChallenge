//
//  JSONDataManager.swift
//  newTestRegEx
//
//  Created by Jarle Matland on 08.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

public protocol JSONSourceDelegate {
    func dataIsLoaded()
    func loadingFailed(errorMessage: String)
}

public class TutorialStore {
    
    internal var delegate: JSONSourceDelegate?
    internal var count: Int {
        return tutorials.count
    }
    
    subscript(index: Int) -> Tutorial {
        return tutorials[index]
    }
    
    private var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    private var tutorials = [Tutorial]()
    
    public func loadTutorialsData() {
        let JSONFileURL = NSBundle.mainBundle().URLForResource("tutorials", withExtension: ".json")!
        let task = session.dataTaskWithURL(JSONFileURL) { (data, response, error) in
            guard let data = data else {
                self.failed("Data did not come back from the server")
                return
            }
            
            guard let json = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? NSDictionary else {
                self.failed("Data from the server was not valid JSON")
                return
            }
            
            guard let tutorialInfo = json["tutorials"] as? Array<NSDictionary> else {
                self.failed("The JSON format from the server changed!")
                return
            }
            
            self.tutorials = tutorialInfo.map(Tutorial.init).flatMap({ $0 })
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.delegate?.dataIsLoaded()
            })
        }
        task.resume()
    }
    
    private func failed(message: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock({
            self.delegate?.loadingFailed(message)
        })
        return
    }
    
}