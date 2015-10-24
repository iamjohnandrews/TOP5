//
//  SignUpViewController.swift
//  TOP5
//
//  Created by John Andrews on 10/10/15.
//  Copyright © 2015 John Andrews. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    let topLineWidth: CGFloat = 4.0
    let regularLineWidth: CGFloat = 2.0
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var birthday: UITextField!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonPressed(sender: UIButton) {
        firstName.userInteractionEnabled = true
        lastName.userInteractionEnabled = true
        birthday.userInteractionEnabled = true
        email.userInteractionEnabled = true
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {
    }
    var userInfo: [String: String]? {
        return NSUserDefaults.standardUserDefaults().objectForKey(userFBDetails) as? [String: String]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        drawLines()
        firstName.userInteractionEnabled = false
        lastName.userInteractionEnabled = false
        birthday.userInteractionEnabled = false
        email.userInteractionEnabled = false

        navigationController?.navigationBarHidden = false
        addAutoLayoutContraints()
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let titleString = ViewController().getLogoTextForFontSize(20, andColor: UIColor.whiteColor())
        let logoLabel = UILabel(frame: CGRectMake(0, 0, 50, 25))
        logoLabel.textAlignment = .Center
        logoLabel.attributedText = titleString
        
        navigationItem.titleView = logoLabel

        if let fbUserDetails = userInfo {
            if let first: String = fbUserDetails[userFBFirstName] {
                firstName.text = first
            }
            if let last: String = fbUserDetails[userFBLastName] {
                lastName.text = last
            }
            if let emailString: String = fbUserDetails[userFBemail] {
                email.text = emailString
            }
            if let bday: String = fbUserDetails[userFBBirthday] {
                birthday.text = bday
            }
        }
    }

    func addAutoLayoutContraints() {
        let viewDict = ["topLabel": topLabel, "firstName": firstName, "lastName": lastName, "birthday": birthday, "maleLabel": maleLabel, "femaleLabel": femaleLabel, "email": email]
        let metrics = ["distanceBTWLabels": 5, "distanceFromNavBar": 60, "halfScreenWidth": self.view.bounds.width/2]

        let topLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topLabel]|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(topLabelHConstrinats)
        let namesHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[firstName]-distanceBTWLabels-[lastName]|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(namesHConstrinats)
        let emailHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[email]|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(emailHConstrinats)
        let birthdayHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[birthday]|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(birthdayHConstrinats)
        let genderHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[maleLabel]-distanceBTWLabels-[femaleLabel]-halfScreenWidth-|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(genderHConstrinats)

        let vContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-distanceFromNavBar-[topLabel]-distanceFromNavBar-[firstName]-distanceBTWLabels-[email]-distanceBTWLabels-[birthday]-distanceBTWLabels-[mail]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(vContraint)
    }

    private func drawLines() {
        let lineColor = UIColor.blackColor()

        let topLine = UIBezierPath()
        topLine.moveToPoint(CGPointMake(topLabel.frame.origin.x, topLabel.frame.origin.y))
        topLine.addLineToPoint(CGPointMake(topLabel.frame.origin.x + topLabel.frame.size.width, topLabel.frame.origin.y))
        let topLineShapeLayer = CAShapeLayer()
        topLineShapeLayer.path = topLine.CGPath
        topLineShapeLayer.strokeColor = lineColor.CGColor
        topLineShapeLayer.lineWidth = topLineWidth
        view.layer.addSublayer(topLineShapeLayer)
        
        let secondLine = UIBezierPath()
        secondLine.moveToPoint(CGPointMake(topLabel.frame.origin.x, topLabel.frame.origin.y + topLabel.frame.size.height))
        secondLine.addLineToPoint(CGPointMake(topLabel.frame.origin.x + topLabel.frame.size.width, topLabel.frame.origin.y + topLabel.frame.size.height))
        let secondLineShapeLayer = CAShapeLayer()
        secondLineShapeLayer.path = secondLine.CGPath
        secondLineShapeLayer.strokeColor = lineColor.CGColor
        secondLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(secondLineShapeLayer)
        
        let thirdLine = UIBezierPath()
        thirdLine.moveToPoint(CGPointMake(email.frame.origin.x, email.frame.origin.y))
        thirdLine.addLineToPoint(CGPointMake(email.frame.origin.x + email.frame.size.width, email.frame.origin.y))
        let thirdLineShapeLayer = CAShapeLayer()
        thirdLineShapeLayer.path = thirdLine.CGPath
        thirdLineShapeLayer.strokeColor = lineColor.CGColor
        thirdLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(thirdLineShapeLayer)
        
        let fourthLine = UIBezierPath()
        fourthLine.moveToPoint(CGPointMake(email.frame.origin.x, email.frame.origin.y + email.frame.size.height))
        fourthLine.addLineToPoint(CGPointMake(email.frame.origin.x + email.frame.size.width, email.frame.origin.y + email.frame.size.height))
        let fourthLineShapeLayer = CAShapeLayer()
        fourthLineShapeLayer.path = fourthLine.CGPath
        fourthLineShapeLayer.strokeColor = lineColor.CGColor
        fourthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(fourthLineShapeLayer)
        
        let fifthLine = UIBezierPath()
        fifthLine.moveToPoint(CGPointMake(birthday.frame.origin.x, birthday.frame.origin.y + birthday.frame.size.height))
        fifthLine.addLineToPoint(CGPointMake(birthday.frame.origin.x + email.frame.size.width, birthday.frame.origin.y + birthday.frame.size.height))
        let fifthLineShapeLayer = CAShapeLayer()
        fifthLineShapeLayer.path = fifthLine.CGPath
        fifthLineShapeLayer.strokeColor = lineColor.CGColor
        fifthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(fifthLineShapeLayer)
        
        let sixthLine = UIBezierPath()
        sixthLine.moveToPoint(CGPointMake(maleLabel.frame.origin.x, maleLabel.frame.origin.y + maleLabel.frame.size.height))
        sixthLine.addLineToPoint(CGPointMake(maleLabel.frame.origin.x + email.frame.size.width, maleLabel.frame.origin.y + maleLabel.frame.size.height))
        let sixthLineShapeLayer = CAShapeLayer()
        sixthLineShapeLayer.path = sixthLine.CGPath
        sixthLineShapeLayer.strokeColor = lineColor.CGColor
        sixthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(sixthLineShapeLayer)
    }
    
    
    
}