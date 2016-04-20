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
    
    @IBAction func webButton(sender: AnyObject) {
        
        let url = NSURL(string: "http://en.theappacademy.nl")!
        UIApplication.sharedApplication().openURL(url)
        //webView.loadRequest(NSURLRequest(URL: url))
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
    
}
