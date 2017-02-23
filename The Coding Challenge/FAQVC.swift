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
    
    // Displaying the About tab
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        aboutArrow.isHidden = false
        socialArrow.isHidden = true
        socialButton.setImage(socialUnselectedImage, for: UIControlState())
        aboutButton.setImage(aboutSelectedImage, for: UIControlState())
        aboutView.isHidden = false
        socialView.isHidden = true
    }
    
    // Displaying the Social tab
    @IBAction func socialButtonPressed(_ sender: UIButton) {
        aboutArrow.isHidden = true
        socialArrow.isHidden = false
        socialButton.setImage(socialSelectedImage, for: UIControlState())
        aboutButton.setImage(aboutUnselectedImage, for: UIControlState())
        aboutView.isHidden = true
        socialView.isHidden = false
    }
    
    override func viewDidLoad() {
        aboutArrow.isHidden = false
        socialArrow.isHidden = true
        socialButton.setImage(socialUnselectedImage, for: UIControlState())
        aboutButton.setImage(aboutSelectedImage, for: UIControlState())
        aboutView.isHidden = false
        socialView.isHidden = true
    }
    
    // The App academy website
    @IBAction func webButton(_ sender: AnyObject) {
        let url = URL(string: "http://en.theappacademy.nl")!
        UIApplication.shared.openURL(url)
    }
    
    // Phone call action
    @IBAction func makeCall(_ sender: AnyObject) {
        let url:URL = URL(string: "tel//0031202610899")!
        UIApplication.shared.openURL(url)
    }
    
    // Connection to linkedlin
    @IBAction func linkedlinButton(_ sender: AnyObject) {
        let url = URL(string: "https://www.linkedin.com/company/the-app-academy")!
        UIApplication.shared.openURL(url)
    }
    
    // Connection to twitter
    @IBAction func twitterButton(_ sender: AnyObject) {
        let url = URL(string: "https://twitter.com/AppAcademyNL")!
        UIApplication.shared.openURL(url)
    }
    
    // Connection to facebook
    @IBAction func facebookButton(_ sender: AnyObject) {
        let url = URL(string: "https://www.facebook.com/AppAcademyNL")!
        UIApplication.shared.openURL(url)
    }
    
    // Connection to email
    @IBAction func emailButton(_ sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    // Connection to newsletter
    @IBAction func signUPNewsletter(_ sender: UIButton) {
        var emailTextField: UITextField?
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Sign up for newsletter", message: "Fill in your email", preferredStyle: .alert)
        
        //Create and an option action
        let nextAction: UIAlertAction = UIAlertAction(title: "Sign me up!", style: .default) { action -> Void in
        self.addMailToNewsletter((emailTextField?.text)!)
           // print(nameTextField)
            print(emailTextField)
        }
        actionSheetController.addAction(nextAction)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
    
        }
        actionSheetController.addAction(cancelAction)
        
        //Add a text field
        actionSheetController.addTextField { emailField -> Void in
            // you can use this text field
            emailTextField = emailField
        }
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    // Functions for setting up email
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info@theappacademy.nl"])
        mailComposerVC.setSubject("Interested in bootcamp at The App Academy")
        mailComposerVC.setMessageBody("Hello, \r\r I am interested in getting more information about the mobile developer bootcamps at The App Academy \r\r", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert: UIAlertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //Adding news Letter
    func addMailToNewsletter(_ email: String) {
        let url = "https://us4.api.mailchimp.com/2.0/lists/subscribe"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        
        let session = URLSession.shared
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let params = ["apikey":"a62c8e83cc3c031bf910efd60a536244", "id":"1781fc944c", "email":["email":email, "euid": "", "leid": ""], "merge_vars":["FNAME": "","LNAME": ""], "double_optin": "false"] as [String : Any]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard data != nil else {
                print("no data found: \(error)")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("Success: \(String(describing: json))")
                }
            } catch let parseError {
                print(parseError)                                                         
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }) 
        
        task.resume()
        
    }
    
}
