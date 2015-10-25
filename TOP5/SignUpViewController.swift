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
    let bufferScreenEdge: CGFloat = 5
    let maleLabelTag = 8
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var birthday: UITextField!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var editButton: UIButton!

    var userInfo: [String: String]? {
        return NSUserDefaults.standardUserDefaults().objectForKey(userFBDetails) as? [String: String]
    }

    // MARK: Actions

    @IBAction func editButtonPressed(sender: UIButton) {
        print("editButtonPressed \(sender)")

        if firstName.userInteractionEnabled.boolValue == false {
            firstName.userInteractionEnabled = true
            lastName.userInteractionEnabled = true
            birthday.userInteractionEnabled = true
            email.userInteractionEnabled = true
        } else {
            firstName.userInteractionEnabled = false
            lastName.userInteractionEnabled = false
            birthday.userInteractionEnabled = false
            email.userInteractionEnabled = false
        }
    }
    
    @IBAction func continueButtonPressed(sender: AnyObject) {

    }

    func genderLabelTapped(sender: UITapGestureRecognizer) {
        if sender.view?.tag == maleLabelTag {
            maleLabel.backgroundColor = UIColor.yellowColor()
            femaleLabel.backgroundColor = UIColor.clearColor()
        } else {
            maleLabel.backgroundColor = UIColor.clearColor()
            femaleLabel.backgroundColor = UIColor.yellowColor()
        }
    }

    override func viewDidLoad() {
        addAutoLayoutContraints()
        super.viewDidLoad()

        firstName.userInteractionEnabled = false
        firstName.borderStyle = .None
        lastName.userInteractionEnabled = false
        lastName.borderStyle = .None
        birthday.userInteractionEnabled = false
        birthday.borderStyle = .None
        email.userInteractionEnabled = false
        email.borderStyle = .None

        navigationController?.navigationBarHidden = false

        maleLabel.userInteractionEnabled = true
        maleLabel.tag = maleLabelTag
        let tappedMaleLabel = UITapGestureRecognizer(target: self, action: "genderLabelTapped:")
        maleLabel.addGestureRecognizer(tappedMaleLabel)
        femaleLabel.userInteractionEnabled = true
        let tappedFemaleLabel = UITapGestureRecognizer(target: self, action: "genderLabelTapped:")
        femaleLabel.addGestureRecognizer(tappedFemaleLabel)
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
        drawLines()
    }

    func addAutoLayoutContraints() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.preferredMaxLayoutWidth = self.view.bounds.width
        firstName.translatesAutoresizingMaskIntoConstraints = false
        lastName.translatesAutoresizingMaskIntoConstraints = false
        birthday.translatesAutoresizingMaskIntoConstraints = false
        maleLabel.translatesAutoresizingMaskIntoConstraints = false
        femaleLabel.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false

        let viewDict = ["topLabel": topLabel, "firstName": firstName, "lastName": lastName, "birthday": birthday, "maleLabel": maleLabel, "femaleLabel": femaleLabel, "email": email, "edit": editButton]
        let metrics = ["hDistanceBTWLabels": bufferScreenEdge, "distanceFromNavBar": 100, "halfScreenWidth": self.view.bounds.width/2, "vDistanceBTWLabels": 40]

        let topLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[topLabel]|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(topLabelHConstrinats)
        let namesHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hDistanceBTWLabels-[firstName]-hDistanceBTWLabels-[lastName]-hDistanceBTWLabels-|", options: .AlignAllBaseline, metrics: metrics, views: viewDict)
        firstName.superview?.addConstraints(namesHConstrinats)
        let emailHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hDistanceBTWLabels-[email]-hDistanceBTWLabels-|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(emailHConstrinats)
        let birthdayHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hDistanceBTWLabels-[birthday]-hDistanceBTWLabels-|", options: .AlignAllCenterX, metrics: metrics, views: viewDict)
        self.view.addConstraints(birthdayHConstrinats)
        let genderHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|-hDistanceBTWLabels-[maleLabel]-hDistanceBTWLabels-[femaleLabel]-halfScreenWidth-|", options: .AlignAllBaseline, metrics: metrics, views: viewDict)
        maleLabel.superview?.addConstraints(genderHConstrinats)
        let editButtonHConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[edit]-hDistanceBTWLabels-|", options: .AlignAllRight, metrics: metrics, views: viewDict)
        self.view.addConstraints(editButtonHConstraints)

        let vContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-distanceFromNavBar-[topLabel]-60-[firstName]-vDistanceBTWLabels-[email]-vDistanceBTWLabels-[birthday]-vDistanceBTWLabels-[maleLabel]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metrics, views: viewDict)
        self.view.addConstraints(vContraint)
        let editVConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:[birthday]-distanceFromNavBar-[edit]", options: NSLayoutFormatOptions.AlignAllRight, metrics: metrics, views: viewDict)
        self.view.addConstraints(editVConstraint)
    }

    private func drawLines() {
        let lineColor = UIColor.blackColor()

        let topLine = UIBezierPath()
        topLine.moveToPoint(CGPointMake(topLabel.frame.origin.x + bufferScreenEdge, topLabel.frame.origin.y))
        topLine.addLineToPoint(CGPointMake(topLabel.frame.origin.x + topLabel.frame.size.width - (bufferScreenEdge * 2), topLabel.frame.origin.y))
        let topLineShapeLayer = CAShapeLayer()
        topLineShapeLayer.path = topLine.CGPath
        topLineShapeLayer.strokeColor = lineColor.CGColor
        topLineShapeLayer.lineWidth = topLineWidth
        view.layer.addSublayer(topLineShapeLayer)
        
        let secondLine = UIBezierPath()
        secondLine.moveToPoint(CGPointMake(firstName.frame.origin.x, firstName.frame.origin.y - firstName.frame.size.height * 2))
        secondLine.addLineToPoint(CGPointMake(firstName.frame.origin.x + email.frame.size.width - (bufferScreenEdge * 2), firstName.frame.origin.y - firstName.frame.size.height * 2))
        let secondLineShapeLayer = CAShapeLayer()
        secondLineShapeLayer.path = secondLine.CGPath
        secondLineShapeLayer.strokeColor = lineColor.CGColor
        secondLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(secondLineShapeLayer)
        
        let thirdLine = UIBezierPath()
        thirdLine.moveToPoint(CGPointMake(firstName.frame.origin.x, firstName.frame.origin.y + firstName.frame.size.height * 2))
        thirdLine.addLineToPoint(CGPointMake(firstName.frame.origin.x + email.frame.size.width - (bufferScreenEdge * 2), firstName.frame.origin.y + firstName.frame.size.height * 2))
        let thirdLineShapeLayer = CAShapeLayer()
        thirdLineShapeLayer.path = thirdLine.CGPath
        thirdLineShapeLayer.strokeColor = lineColor.CGColor
        thirdLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(thirdLineShapeLayer)
        
        let fourthLine = UIBezierPath()
        fourthLine.moveToPoint(CGPointMake(email.frame.origin.x, email.frame.origin.y + email.frame.size.height * 2))
        fourthLine.addLineToPoint(CGPointMake(email.frame.origin.x + email.frame.size.width - (bufferScreenEdge * 2), email.frame.origin.y + email.frame.size.height * 2))
        let fourthLineShapeLayer = CAShapeLayer()
        fourthLineShapeLayer.path = fourthLine.CGPath
        fourthLineShapeLayer.strokeColor = lineColor.CGColor
        fourthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(fourthLineShapeLayer)
        
        let fifthLine = UIBezierPath()
        fifthLine.moveToPoint(CGPointMake(birthday.frame.origin.x, birthday.frame.origin.y + birthday.frame.size.height * 2))
        fifthLine.addLineToPoint(CGPointMake(birthday.frame.origin.x + birthday.frame.size.width - (bufferScreenEdge * 2), birthday.frame.origin.y + birthday.frame.size.height * 2))
        let fifthLineShapeLayer = CAShapeLayer()
        fifthLineShapeLayer.path = fifthLine.CGPath
        fifthLineShapeLayer.strokeColor = lineColor.CGColor
        fifthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(fifthLineShapeLayer)
        
        let sixthLine = UIBezierPath()
        sixthLine.moveToPoint(CGPointMake(maleLabel.frame.origin.x, maleLabel.frame.origin.y + maleLabel.frame.size.height * 2))
        sixthLine.addLineToPoint(CGPointMake(maleLabel.frame.origin.x + birthday.frame.size.width - (bufferScreenEdge * 2), maleLabel.frame.origin.y + maleLabel.frame.size.height * 2))
        let sixthLineShapeLayer = CAShapeLayer()
        sixthLineShapeLayer.path = sixthLine.CGPath
        sixthLineShapeLayer.strokeColor = lineColor.CGColor
        sixthLineShapeLayer.lineWidth = regularLineWidth
        view.layer.addSublayer(sixthLineShapeLayer)
    }
    
    
    
}