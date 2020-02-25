//
//  MonthInputTextField.swift
//  Caishen
//
//  Created by Daniel Vancura on 3/8/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

import UIKit

/// A text field which can be used to enter months and provides validation and auto completion.
open class MonthInputTextField: DetailInputTextField {
    
    /**
     Checks the validity of the entered month.
     
     - returns: True, if the month is valid.
     */
    internal override func isInputValid(_ month: String, partiallyValid: Bool) -> Bool {
        let length = month.count
        if partiallyValid && length == 0 {
            return true
        }
        
        if length == 1 && !["0","1"].contains(month) {
            return false
        }
        
        if length == 2 && partiallyValid == false {
            return false
        }

        if length <= 2 {
            return isMonthInputValid(month, partiallyValid: partiallyValid)
        }
        
        // check if length >= 3
        if length >= 3 {
            // separates the string from the slash
            let components = month.components(separatedBy: "/")
            let isYearValid = (components[0] != "") ? isYearInputValid(year: components[1], partiallyValid: partiallyValid) : true
            let isMonthValid = isMonthInputValid(components[0], partiallyValid: partiallyValid)
            return isYearValid && isMonthValid
        }
        
        return false
    }
    
    func isMonthInputValid(_ month: String, partiallyValid: Bool) -> Bool {
        let length = month.count
        if partiallyValid && length == 0 {
            return true
        }
        
        guard let monthInt = UInt(month) else {
            return false
        }
        
        return ((monthInt >= 1 && monthInt <= 12) ||
            (partiallyValid && month == "0")) &&
            (partiallyValid || length == 2)
    }
    
    func isYearInputValid(year: String, partiallyValid: Bool) -> Bool {
        if partiallyValid && year.count == 0 {
            return true
        }
        
        guard let yearInt = UInt(year) else {
            return false
        }
        
        return yearInt >= 0 &&
            yearInt < 100 &&
            (partiallyValid || year.count == 2)
    }

    /**
     Returns the auto-completed text for the current month input
     E.g. if user input a "4", it should return a string of "04" instead.
     This makes the input process easier for users

     - returns: Auto-completed string.
     */
    internal override func autocomplete(_ text: String) -> String {
        let length = text.characters.count
        
        var textValue = text
        if text.characters.last == "/" {
            textValue = String(text.characters.dropLast())
            return textValue
        }
        if length == 2 {
            return text + "/"
        }
        if length == 3 && text.characters.last != "/" {
            let lastDigit = String(describing: text.characters.last!)
            textValue = String(text.characters.dropLast())
            return textValue + "/" + lastDigit
        }
        let monthNumber = Int(text) ?? 0
        if monthNumber > 1 {
            return "0" + text + "/"
        }

        return text
    }
}
