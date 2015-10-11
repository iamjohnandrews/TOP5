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
    
    var userInfo = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawLines()
        firstName.userInteractionEnabled = false
        lastName.userInteractionEnabled = false
        birthday.userInteractionEnabled = false
        email.userInteractionEnabled = false
    
    }
    
    init(FBdetails: NSDictionary){
        super.init(nibName: nil, bundle: nil)
        userInfo = FBdetails
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if let first: String = userInfo[userFBFirstName] as? String {
            firstName.text = first
        }
        if let last: String = userInfo[userFBLastName] as? String {
            lastName.text = last
        }
        if let emailString: String = userInfo[userFBemail] as? String {
            email.text = emailString
        }
        if let bday: String = userInfo[userFBBirthday] as? String {
            birthday.text = bday
        }
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