//
//  FAQVC.swift
//  CodingChallenge
//
//  Created by Jarle Matland on 07.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit
import MessageUI

class FAQVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    var socialSelectedImage = UIImage(named: "socialSelected.png")
    var socialUnselectedImage = UIImage(named: "socialUnselected.png")
    var aboutSelectedImage = UIImage(named: "aboutSelected.png")
    var aboutUnselectedImage = UIImage(named: "aboutUnselected.png")
    
    @IBOutlet var aboutButton: UIButton!
    @IBOutlet var socialButton: UIButton!
    @IBOutlet var aboutArrow: UIImageView!
    @IBOutlet var socialArrow: UIImageView!
    @IBOutlet var aboutView: UIView!
    @IBOutlet var socialView: UIView!
    
    @IBAction func aboutButtonPressed(sender: UIButton) {
        aboutArrow.hidden = false
        socialArrow.hidden = true
        socialButton.setImage(socialUnselectedImage, forState: .Normal)
        aboutButton.setImage(aboutSelectedImage, forState: .Normal)
        aboutView.hidden = false
        socialView.hidden = true
    }
    
    @IBAction func socialButtonPressed(sender: UIButton) {
        aboutArrow.hidden = true
        socialArrow.hidden = false
        socialButton.setImage(socialSelectedImage, forState: .Normal)
        aboutButton.setImage(aboutUnselectedImage, forState: .Normal)
        aboutView.hidden = true
        socialView.hidden = false
    }
    
    override func viewDidLoad() {
        aboutArrow.hidden = false
        socialArrow.hidden = true
        socialButton.setImage(socialUnselectedImage, forState: .Normal)
        aboutButton.setImage(aboutSelectedImage, forState: .Normal)
        aboutView.hidden = false
        socialView.hidden = true
    }
    
    
    @IBAction func webButton(sender: AnyObject) {
        
        let url = NSURL(string: "http://en.theappacademy.nl")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func makeCall(sender: AnyObject) {
        
        let url:NSURL = NSURL(string: "tel//0031202610899")!
        
        UIApplication.sharedApplication().openURL(url)
        
    }
    
    @IBAction func linkedlinButton(sender: AnyObject) {
        
        let url = NSURL(string: "https://www.linkedin.com/company/the-app-academy")!
        UIApplication.sharedApplication().openURL(url)
        //webView.loadRequest(NSURLRequest(URL: url))
        
        
    }
    
    
    @IBAction func twitterButton(sender: AnyObject) {
        
        let url = NSURL(string: "https://twitter.com/AppAcademyNL")!
        UIApplication.sharedApplication().openURL(url)
        //webView.loadRequest(NSURLRequest(URL: url))
        
    }
    
    @IBAction func facebookButton(sender: AnyObject) {
        let url = NSURL(string: "https://www.facebook.com/AppAcademyNL")!
        UIApplication.sharedApplication().openURL(url)
        //webView.loadRequest(NSURLRequest(URL: url))
    }
    
    @IBAction func emailButton(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func signUPNewsletter(sender: UIButton) {
        var nameTextField: UITextField?
        var emailTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Sign up for newsletter", message: "Fill in your email", preferredStyle: .Alert)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Sign me up!", style: .Default) { action -> Void in
            //self.addMailToNewsletter((nameTextField?.text)!, email: (emailTextField?.text)!)
           // print(nameTextField)
            print(emailTextField)
        }
        actionSheetController.addAction(nextAction)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some stuff
        }
        actionSheetController.addAction(cancelAction)
        
//        //Add a text field
//        actionSheetController.addTextFieldWithConfigurationHandler { nameField -> Void in
//            // you can use this text field
//            nameTextField = nameField
//        }
        
        //Add a text field
        actionSheetController.addTextFieldWithConfigurationHandler { emailField -> Void in
            // you can use this text field
            emailTextField = emailField
        }
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info@theappacademy.nl"])
        mailComposerVC.setSubject("Interested in bootcamp at The App Academy")
        mailComposerVC.setMessageBody("Hello, \r\r I am interested in getting more information about the mobile developer bootcamps at The App Academy \r\r", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func addMailToNewsletter(name: String, email: String) {
        let url = "https://us4.api.mailchimp.com/2.0/lists/subscribe"
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let params = ["apikey":"a62c8e83cc3c031bf910efd60a536244-us9", "id":"1781fc944c", "email":["email":email, "euid": "", "leid": ""], "merge_vars":["FNAME": name,"LNAME": ""], "double_optin": "false"]
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: [])
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    print("Success: \(String(json))")
                    
                }
                
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        
        task.resume()
        
    }
    
}
