//
//  SyntaxTextStorage.swift
//  TestRegExProject
//
//  Created by Jarle Matland on 07.04.2016.
//  Copyright © 2016 Donkey Monkey. All rights reserved.
//

import UIKit

// Global Constants for use in the dictionary
let DisplayedCode = "displayedCode"
let DisplayedCodeFormatted = "displayedCodeFormatted"
let AttributedCode = "attributedCode"
let AttributedText = "attributedText"

let CodeOption1Code = "codeOption1Code"
let CodeOption2Code = "codeOption2Code"
let CodeOption3Code = "codeOption3Code"

let CodeOption1Text = "codeOption1Text"
let CodeOption2Text = "codeOption2Text"
let CodeOption3Text = "codeOption3Text"

let CodeOption1AttributedCode = "codeOption1FormattedCode"
let CodeOption2AttributedCode = "codeOption2FormattedCode"
let CodeOption3AttributedCode = "codeOption3FormattedCode"


class SyntaxTextStorage: NSTextStorage {
    
    var tutorialDictionary = [String: AnyObject]()
    var tutorialStore: TutorialStore!
    var challenge: Challenge!
    
    var codeText: String = ""
    
    var regExFormats: [String : AnyObject]!
    var codeString: NSMutableAttributedString!
    var initialViewAttrString: NSMutableAttributedString!
    
    var wholeText = ""
    var enterCodeText = ""
    var codeOption1 = ""
    var codeOption2 = ""
    var codeOption3 = ""
    
    func processText(_ challenge: Challenge) {
        
        self.challenge = challenge
        setRegexFormats()
        performFormatting(codeText)
        
    }
    
    override var string: String {
        codeString = NSMutableAttributedString(string: codeText, attributes:nil)
        return codeString.string
    }
    
    func setRegexFormats() {
        
        // Create the different attributes
        let declarationAttribute = [NSForegroundColorAttributeName: UIColor.purple]
        let blueAttribute = [NSForegroundColorAttributeName: UIColor.blue]
        let redAttribute = [NSForegroundColorAttributeName: UIColor.red, NSBackgroundColorAttributeName: UIColor.gray]
        
        // Construct a dictionary of replacements based on regexes
        regExFormats = [
            "(var)" : declarationAttribute as AnyObject, // VAR - purple color
            "(class)" : declarationAttribute as AnyObject, // CLASS - purple color
            "(func)" : declarationAttribute as AnyObject, // FUNC - purple color
            "(print)" : blueAttribute as AnyObject, // PRINT - blue color
            "(Enter Code)" : redAttribute as AnyObject,
            "(@IBOutlet)" : blueAttribute as AnyObject,
            "(String)" : blueAttribute as AnyObject,
            "(UILabel)" : blueAttribute as AnyObject,
            "(presentViewController)" : blueAttribute as AnyObject,
            "(imagePicker)" : blueAttribute as AnyObject
        ]
    }
    
    func performFormatting(_ codeText: String) {
        
        let textString = NSMutableAttributedString(string: challenge.text!, attributes:nil)
        textString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Menlo", size: 12)!, range: NSMakeRange(0, textString.length))
        
        let codeString = NSMutableAttributedString(string: challenge.code!, attributes:nil)
        codeString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "Menlo", size: 12)!, range: NSMakeRange(0, codeString.length))
        
        tutorialDictionary[AttributedCode] = codeString
        tutorialDictionary[AttributedText] = textString
        
        makeOptionCodeString(challenge.input1!, nameOfKey: CodeOption1Code)
        makeOptionCodeString(challenge.input2!, nameOfKey: CodeOption2Code)
        makeOptionCodeString(challenge.input3!, nameOfKey: CodeOption3Code)
        
        performFormattingOnCode(AttributedText, nameOfKey: AttributedText)
        performFormattingOnCode(AttributedCode, nameOfKey: DisplayedCodeFormatted)
        performFormattingOnCode(CodeOption1Code, nameOfKey: CodeOption1AttributedCode)
        performFormattingOnCode(CodeOption2Code, nameOfKey: CodeOption2AttributedCode)
        performFormattingOnCode(CodeOption3Code, nameOfKey: CodeOption3AttributedCode)
    }
    
    
    func makeOptionCodeString(_ userCode: String, nameOfKey: String) {
        
        let displayedCode = tutorialDictionary[AttributedCode] as! NSMutableAttributedString
        
        let editableAttrString: NSMutableAttributedString = displayedCode.mutableCopy() as! NSMutableAttributedString
        
        let tempCodeText = editableAttrString.mutableString as String
        
        let enterCodePattern = "Enter Code"
        
        let regex = try? NSRegularExpression(pattern: enterCodePattern, options: [])
        let rangeOfCode = NSMakeRange(0, editableAttrString.length)
        let matches = (regex?.matches(in: tempCodeText, options: [], range: rangeOfCode))!
        
        //Iterate over regex matches
        for match in matches {
            editableAttrString.replaceCharacters(in: match.rangeAt(0), with: userCode)
        }
        tutorialDictionary[nameOfKey] = editableAttrString
        
    }

    
    func performFormattingOnCode(_ optionCode: String, nameOfKey: String) {
        
        let normalAttrs = [NSFontAttributeName : UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        let tempAttrCode =  tutorialDictionary[optionCode] as! NSMutableAttributedString
        let editableAttrString: NSMutableAttributedString = tempAttrCode.mutableCopy() as! NSMutableAttributedString
        let tempCode = editableAttrString.mutableString as String
        
        // iterate over each replacement
        for (pattern, attributes) in regExFormats {
            
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let range = NSMakeRange(0, tempCode.characters.count)
            regex.enumerateMatches(in: tempCode, options: [], range: range) {
                
                match, flags, stop in
                
                // apply the style
                let matchRange = match!.rangeAt(1)
                let attribute = attributes as! [String: AnyObject]
                tempAttrCode.addAttributes(attribute, range: matchRange)
                
                // reset the style to the original
                let maxRange = matchRange.location + matchRange.length
                if maxRange + 1 < self.length {
                    self.addAttributes(normalAttrs, range: NSMakeRange(maxRange, 1))
                }
            }
        }
        tutorialDictionary[nameOfKey] = tempAttrCode
    }
    
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String : Any] {
        let attrString = NSMutableAttributedString(string: codeText, attributes:nil)
        
        return attrString.attributes(at: location, effectiveRange: range)
    }
    
    override func setAttributes(_ attrs: [String : Any]!, range: NSRange) {
        let attrString = NSMutableAttributedString(string: codeText, attributes:nil)
        beginEditing()
        attrString.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    
}
