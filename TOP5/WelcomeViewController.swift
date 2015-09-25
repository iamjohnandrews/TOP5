//
//  WelcomeViewController.swift
//  TOP5
//
//  Created by John Andrews on 9/10/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

import Foundation
import UIKit

public class WelcomeViewController: UIViewController {

    public var pageIndex = 0
    public var titleText = ""
    var genericLabel = UILabel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NSLog("pageIndex =\(pageIndex)")

        if pageIndex == 0 {
            setUpLabel(false)
            setUpLogoTextOnPage1()
        } else {
            setUpLabel(true)
            setupTextView()
        }
    }

    private func setUpLabel(withBottomBorder: Bool) {
        genericLabel.frame = CGRectMake(50, 50, 400, 200)
        genericLabel.textAlignment = NSTextAlignment.Center
        genericLabel.font = genericLabel.font.fontWithSize(80)
        view.addSubview(genericLabel)

        if withBottomBorder == true {
            setUpOnboardingNumbers()
            let bottomBorder = CALayer()
            bottomBorder.borderColor = UIColor.blackColor().CGColor
            bottomBorder.borderWidth = 4
            bottomBorder.frame = CGRectMake(genericLabel.frame.origin.x, genericLabel.frame.origin.y + genericLabel.frame.size.height, CGRectGetWidth(genericLabel.frame), 2)
        }
    }

    private func setupTextView() {
        let textView = UITextView(frame: CGRectMake(genericLabel.frame.origin.x, genericLabel.frame.origin.y + genericLabel.frame.size.height + 30, genericLabel.frame.size.width, 180))
        view.addSubview(textView)

        var topBaseString = "Tell us about YOURSELF" as NSString
        var topAttributedString = NSMutableAttributedString(string: topBaseString as String)
        let regularTopText = [NSFontAttributeName : UIFont.systemFontOfSize(20)]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(20)]
        topAttributedString.addAttributes(boldAttribute, range: topBaseString.rangeOfString("YOURSELF"))
        topAttributedString.addAttributes(regularTopText, range: topBaseString.rangeOfString("Tell us about"))

        textView.attributedText = topAttributedString;

        var bottomString = "The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence."


    }

    private func setUpLogoTextOnPage1() {
        genericLabel.center = CGPointMake(view.center.x, view.center.y - 100)

        let baseString = "TopFIVE" as NSString
        let attributedString = NSMutableAttributedString(string: baseString as String)

        let thinFont = UIFont(name: "HelveticaNeue-Thin", size: 80)!
        let thinAttribute = [NSFontAttributeName: thinFont]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(80)]
        attributedString.addAttributes(boldAttribute, range: baseString.rangeOfString("FIVE"))
        attributedString.addAttributes(thinAttribute, range: baseString.rangeOfString("Top"))

        genericLabel.attributedText = attributedString
    }

    private func setUpOnboardingNumbers() {
        genericLabel.center = CGPointMake(view.center.x, view.center.y - 100)

        let numberString = "1 2 3 4" as NSString
        let numberAttributedString = NSMutableAttributedString(string: numberString as String)
        let greyColorAttribute = [NSForegroundColorAttributeName: UIColor.lightGrayColor()]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(80)]

        if pageIndex == 1 {
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("2 3 4"))
        } else if pageIndex == 2 {
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("1"))
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("3 4"))
        } else if pageIndex == 3 {
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("1 2"))
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("4"))
        } else if pageIndex == 4 {
            numberAttributedString.addAttributes(greyColorAttribute, range: numberString.rangeOfString("1 2 3"))
        }
        numberAttributedString.addAttributes(boldAttribute, range: numberString.rangeOfString(numberString as String))
        genericLabel.attributedText = numberAttributedString
    }
    
    
}