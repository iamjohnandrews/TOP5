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

let userFBDetails = "userFBDetails"
let userFBFirstName = "userFBFirstName"
let userFBLastName = "userFBLastName"
let userFBemail = "userFBemail"
let userFBProfilePictureURL = "userFBProfilePictureURL"
let userFBBirthday = "userFBBirthday"

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, FBSDKLoginButtonDelegate {
    
    var pageViewController: UIPageViewController!
    var pageTitles: [String]!
    var genericLabel = UILabel()
    var index = 0
    internal let fetchedFromFB: NSMutableDictionary = NSMutableDictionary()
    
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        
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

//        if (FBSDKAccessToken.currentAccessToken() != nil) {
//            // User is already logged in, do work such as go to next view controller.
//        } else {
            let fbButton = FBSDKLoginButton()
            fbButton.center = CGPointMake(view.center.x, facebookLoginButton.center.y - 40)
            view.addSubview(fbButton)
            fbButton.readPermissions = ["public_profile", "email", "user_birthday"]
            fbButton.delegate = self
        
    }

    func getLogoTextForFontSize(fontSize: CGFloat, andColor textColor: UIColor) -> NSMutableAttributedString {
        let baseString = "TopFIVE" as NSString
        let attributedString = NSMutableAttributedString(string: baseString as String)
        
        let thinFont = UIFont(name: "HelveticaNeue-Thin", size: fontSize)!
        let thinAttribute = [NSFontAttributeName: thinFont]
        let boldAttribute = [NSFontAttributeName : UIFont.boldSystemFontOfSize(fontSize)]
        let colorAttribute = [NSForegroundColorAttributeName: textColor]
        attributedString.addAttributes(boldAttribute, range: baseString.rangeOfString("FIVE"))
        attributedString.addAttributes(thinAttribute, range: baseString.rangeOfString("Top"))
        attributedString.addAttributes(colorAttribute, range: baseString.rangeOfString("TopFIVE"))

        return attributedString
    }
    
    // MARK: Onboarding
    private func setUpLogoTextOnPage1(pageIndex: Int) {
        genericLabel.frame = CGRectMake(50, 50, 400, 200)
        genericLabel.textAlignment = NSTextAlignment.Center
        genericLabel.font = genericLabel.font.fontWithSize(80)
        genericLabel.center = CGPointMake(view.center.x, view.center.y - 100)
        genericLabel.attributedText = getLogoTextForFontSize(80, andColor: UIColor.blackColor())
        
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
        
        
        let belowNumbersLine = UIBezierPath()
        belowNumbersLine.moveToPoint(CGPointMake(view.frame.origin.x + 10, genericLabel.frame.origin.y + genericLabel.frame.size.height))
        belowNumbersLine.addLineToPoint(CGPointMake(view.frame.origin.x + view.frame.size.width - 20, genericLabel.frame.origin.y + genericLabel.frame.size.height))
        let belowNumbersLineShapeLayer = CAShapeLayer()
        belowNumbersLineShapeLayer.path = belowNumbersLine.CGPath
        belowNumbersLineShapeLayer.strokeColor = UIColor.blackColor().CGColor
        belowNumbersLineShapeLayer.lineWidth = 5
        view.layer.addSublayer(belowNumbersLineShapeLayer)
    }
    
    @IBAction func emailLoginButtonAction(sender: AnyObject) {
    }

    @IBAction func facebookLoginButtonAction(sender: AnyObject) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        _ = SignUpViewController(FBdetails: fetchedFromFB)        
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, last_name, birthday, email, picture"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            } else {
                print("fetched user: \(result)")
                let picture: NSDictionary = result.valueForKey("picture") as! NSDictionary
                let data: NSDictionary = picture.valueForKey("data") as! NSDictionary
                let url: NSString = data.valueForKey("url") as! NSString
                
                self.fetchedFromFB[userFBBirthday] = result.valueForKey("birthday") as! NSString
                self.fetchedFromFB[userFBFirstName] = result.valueForKey("first_name") as! NSString
                self.fetchedFromFB[userFBLastName] = result.valueForKey("last_name") as! NSString
                self.fetchedFromFB[userFBemail] = result.valueForKey("email") as! NSString
                self.fetchedFromFB[userFBProfilePictureURL] = url
            }
        })
        if NSUserDefaults.standardUserDefaults().valueForKey(userFBDetails) == nil {
            NSUserDefaults.standardUserDefaults().setValue(fetchedFromFB, forKey: userFBDetails)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("signUpSegue", sender: self)
        }
    }

    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        print("whats Facebook returns \(result.declinedPermissions) and \(result.grantedPermissions) for token \(result.token.userID)")
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            print("Login was cancelled")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.count > 0
            {
                print("User granted access to \(result.grantedPermissions)")
                returnUserData()
                // Do work
            }
            if result.declinedPermissions.count > 0
            {
                print("User declined access to \(result.declinedPermissions)")
                
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
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

