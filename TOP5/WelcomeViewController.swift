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
    
    private let pageBold1 = "YOURSELF"
    private let pageNormal1 = "Tell us about"
    private var pageText1 : String {
        get {
            return pageNormal1 + " " + pageBold1
        }
    }
    private let pageBold2 = "YOUR FAVORITES"
    private let pageNormal2 = "Tell us about"
    private var pageText2 : String {
        get {
            return pageNormal2 + " " + pageBold2
        }
    }
    private let pageBold3 = "OTHER'S FAVORITES"
    private let pageNormal3 = "Search for "
    private var pageText3 : String {
        get {
            return pageNormal3 + " " + pageBold3
        }
    }
    private let pageBold4 = "YOUR NEW FAVORITES"
    private let pageNormal4 = "Discover"
    private var pageText4 : String {
        get {
            return pageNormal4 + " " + pageBold4
        }
    }

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        NSLog("pageIndex =\(pageIndex)")

        if pageIndex == 1 {
            setupTextView(pageBold1, forNormal: pageNormal1, inText: pageText1)
        } else if pageIndex == 2 {
            setupTextView(pageBold2, forNormal: pageNormal2, inText: pageText2)
        } else if pageIndex == 3 {
            setupTextView(pageBold3, forNormal: pageNormal3, inText: pageText3)
        } else if pageIndex == 4 {
            setupTextView(pageBold4, forNormal: pageNormal4, inText: pageText4)
        }
    }

    private func setupTextView(forBold: String, forNormal: String, inText: String) {
        let moreDetails = UILabel(frame: CGRectMake(view.frame.origin.x + 20, view.frame.origin.y + 110 , view.frame.size.width - 40, 100))
        moreDetails.numberOfLines = 0
        moreDetails.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
//        moreDetails.layer.borderWidth = 2
//        moreDetails.layer.borderColor = UIColor.redColor().CGColor

        let topBaseString = inText as NSString
        let topAttributedString = NSMutableAttributedString(string: topBaseString as String)
        let regularTopText = [NSFontAttributeName : UIFont.systemFontOfSize(30)]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(30)]
        topAttributedString.addAttributes(boldAttribute, range: topBaseString.rangeOfString(forBold))
        topAttributedString.addAttributes(regularTopText, range: topBaseString.rangeOfString(forNormal))
        moreDetails.attributedText = topAttributedString;

        let subDetails = UILabel(frame: CGRectMake(moreDetails.frame.origin.x, view.frame.origin.y + moreDetails.frame.height + 50 , moreDetails.frame.size.width, 170))
        let bottomString = "The will to win, the desire to succeed, the urge to reach your full potential... these are the keys that will unlock the door to personal excellence."
        subDetails.text = bottomString
        subDetails.numberOfLines = 0
        subDetails.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subDetails.font = UIFont.systemFontOfSize(15)
        
//        subDetails.layer.borderWidth = 2
//        subDetails.layer.borderColor = UIColor.blueColor().CGColor
        
        view.addSubview(subDetails)
        view.addSubview(moreDetails)
    }
    
    
}