//
//  ViewController.swift
//  TOP5
//
//  Created by John Andrews on 8/16/15.
//  Copyright (c) 2015 John Andrews. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pageViewController: UIPageViewController!
    var pageTitles: [String]!
    
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingPage1UISetUp()
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
        pageViewController.view.frame = CGRectMake(0, 30, view.frame.width, view.frame.height - 180)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }

    
    @IBAction func emailLoginButtonAction(sender: AnyObject) {
    }

    @IBAction func facebookLoginButtonAction(sender: AnyObject) {
    }
   
    // MARK: Onboarding Views UI Set Up
    private func onboardingPage1UISetUp () {
        let continueButton = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "removePageViewController:")
        continueButton.title = "Skip"
        self.navigationItem.rightBarButtonItem = continueButton

        emailLoginButton.layer.borderColor = UIColor.blackColor().CGColor
        emailLoginButton.layer.borderWidth = 1
        
    }

    func removePageViewController(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }


    // create new WelcomeVC and assign correct title
    func viewControllerAtIndex(index: Int) -> WelcomeViewController {
        if pageTitles.count == 0 {
            return WelcomeViewController()
        }

        let vc = storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! WelcomeViewController

        vc.titleText = pageTitles[index] as String
        vc.pageIndex = index

        return vc
    }
    
    // MARK: PageViewController DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WelcomeViewController // could have this be a different VC based on index and it will display a differeent vc
        var index = vc.pageIndex as Int

        if index == 0 || index == NSNotFound {
            return nil
        }

        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WelcomeViewController
        var index = vc.pageIndex as Int

        if index == NSNotFound {
            return nil
        }

        index++

        if index == pageTitles.count {
            return nil
        }

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

