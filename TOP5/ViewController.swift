//
//  ViewController.swift
//  TOP5
//
//  Created by John Andrews on 8/16/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public var pageViewController: UIPageViewController!
    var pageTitles: [String]!
    public var genericLabel = UILabel()
    var index = 0
    
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitles = ["page1", "page2", "page3", "page4", "page5"]

        pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        pageViewController.dataSource = self

        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
        pageController.backgroundColor = UIColor.whiteColor()

        let startVC = viewControllerAtIndex(0) as WelcomeViewController
        let viewControllers = NSArray(object: startVC)

        pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        pageViewController.view.frame = CGRectMake(0, view.frame.height/2 - 150, view.frame.width, view.frame.height/2 + 60)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)

        setUpLogoTextOnPage1(index)
        emailLoginButton.layer.borderColor = UIColor.blackColor().CGColor
        emailLoginButton.layer.borderWidth = 1

        let fbButton = FBSDKLoginButton()
        fbButton.center = CGPointMake(view.center.x, facebookLoginButton.center.y - 40)
        view.addSubview(fbButton)
    }

    // MARK: Onboarding
    private func setUpLogoTextOnPage1(pageIndex: Int) {
        genericLabel.frame = CGRectMake(50, 50, 400, 200)
        genericLabel.textAlignment = NSTextAlignment.Center
        genericLabel.font = genericLabel.font.fontWithSize(80)
        
        genericLabel.center = CGPointMake(view.center.x, view.center.y - 100)
        
        let baseString = "TopFIVE" as NSString
        let attributedString = NSMutableAttributedString(string: baseString as String)
        
        let thinFont = UIFont(name: "HelveticaNeue-Thin", size: 80)!
        let thinAttribute = [NSFontAttributeName: thinFont]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(80)]
        attributedString.addAttributes(boldAttribute, range: baseString.rangeOfString("FIVE"))
        attributedString.addAttributes(thinAttribute, range: baseString.rangeOfString("Top"))
        
        genericLabel.attributedText = attributedString
        
        view.addSubview(genericLabel)
    }
    
    private func setUpOnboardingNumbers(pageIndex: Int) {
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
    
    @IBAction func emailLoginButtonAction(sender: AnyObject) {
    }

    @IBAction func facebookLoginButtonAction(sender: AnyObject) {
    }
   
    // MARK: Onboarding Views UI Set Up

    func removePageViewController(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }


    // create new WelcomeVC and assign correct title
    func viewControllerAtIndex(index: Int) -> WelcomeViewController {
        if pageTitles.count == 0 {
            return WelcomeViewController()
        }

        let vc = storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! WelcomeViewController

        vc.pageIndex = index

        return vc
    }
    
    // MARK: PageViewController DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WelcomeViewController // could have this be a different VC based on index and it will display a differeent vc
        index = vc.pageIndex as Int

        if index == 0 || index == NSNotFound {
            setUpLogoTextOnPage1(index)
            return nil
        } else {
            setUpOnboardingNumbers(index)
        }

        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WelcomeViewController
        index = vc.pageIndex as Int

        if index == NSNotFound || index == pageTitles.count {
            return nil
        }
        
        if index > 0 {
            setUpOnboardingNumbers(index)
        }

        index++

        print("ViewController Hash=\(viewController.hash) and Index =\(index)")

        return viewControllerAtIndex(index)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageTitles.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

