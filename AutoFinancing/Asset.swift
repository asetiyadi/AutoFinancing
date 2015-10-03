//
//  Asset.swift
//  AutoInspection
//
//  Created by Andi Setiyadi on 8/29/15.
//  Copyright (c) 2015 Andi Setiyadi. All rights reserved.
//

import UIKit
import Foundation

class Asset {
    
    // MARK: Properties
    
    //static LoanType
    static var LOANTYPE_USED_CAR_60 = "Used Car (Dealer) - 60 months"
    static var LOANTYPE_USED_CAR_72 = "Used Car (Dealer) - 72 months"
    static var LOANTYPE_NEW_CAR_60 = "New Car (Dealer) - 60 months"
    static var LOANTYPE_NEW_CAR_72 = "New Car (Dealer) - 72 months"
    static var LOANTYPE_REFINANCE_60 = "Refinance - 60 months"
    static var LOANTYPE_REFINANCE_72 = "Refinance - 72 months"
    
    // MARK: Static Public Functions
    
    static func textLabel(inputLabel: UILabel) -> UILabel {
        inputLabel.textColor = UIColor.whiteColor()
        
        return inputLabel
    }
    
    static func textViewBox(textView: UITextView) -> UITextView {
        // To match default UITextField color
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        
        return textView
    }
    
    static func buttonBoxAndLabel(inputButton: UIButton) -> UIButton {
        inputButton.layer.borderWidth = 2
        inputButton.layer.borderColor = UIColor.whiteColor().CGColor
        inputButton.layer.cornerRadius = 4
        
        inputButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        inputButton.titleLabel?.font = UIFont(name: "Helvetica Neue Light", size: 18.0)
        inputButton.titleLabel?.text?.uppercaseString
        
        return inputButton
    }
    
    static func buttonImage(inputButton: UIButton) -> UIButton  {
        inputButton.layer.borderWidth = 1
        inputButton.layer.borderColor = UIColor.whiteColor().CGColor
        inputButton.layer.cornerRadius = 4
        
        return inputButton
    }
    
    static func imageBox(image: UIImageView) -> UIImageView {
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.whiteColor().CGColor
        image.layer.cornerRadius = 4
        
        return image
    }
    
    static func imageRound(image: UIImageView, radius: CGFloat) -> UIImageView {
        image.layer.borderWidth = 1
        image.layer.cornerRadius = radius
        image.layer.borderColor = UIColor.grayColor().CGColor
        
        return image
    }
    
    /*static func dashboardHeader() -> UIView {
        let headerView = UIView()
        
        let personImage = UIImageView()
        personImage.image = UIImage(named: <#String#>)
        
        return headerView
    }*/
}
