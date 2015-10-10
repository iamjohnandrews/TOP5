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
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var maleLabel: UILabel!
    
    @IBOutlet weak var femaleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    
    @IBAction func editButtonPressed(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawLines()
        
    }
    
    private func drawLines() {
        UIColor.blackColor().setStroke()

        let topLine = UIBezierPath()
        topLine.lineWidth = topLineWidth
        topLine.moveToPoint(CGPointMake(topLabel.frame.origin.x, topLabel.frame.origin.y))
        topLine.addLineToPoint(CGPointMake(topLabel.frame.origin.x + topLabel.frame.size.width, topLabel.frame.origin.y))
        topLine.stroke()
        
        let secondLine = UIBezierPath()
        secondLine.lineWidth = regularLineWidth
        secondLine.moveToPoint(CGPointMake(topLabel.frame.origin.x, topLabel.frame.origin.y + topLabel.frame.size.height))
        secondLine.addLineToPoint(CGPointMake(topLabel.frame.origin.x + topLabel.frame.size.width, topLabel.frame.origin.y + topLabel.frame.size.height))
        secondLine.stroke()
        
        let thirdLine = UIBezierPath()
        thirdLine.lineWidth = regularLineWidth
        thirdLine.moveToPoint(CGPointMake(emailLabel.frame.origin.x, emailLabel.frame.origin.y))
        thirdLine.addLineToPoint(CGPointMake(emailLabel.frame.origin.x + emailLabel.frame.size.width, emailLabel.frame.origin.y))
        thirdLine.stroke()
        
        let fourthLine = UIBezierPath()
        fourthLine.lineWidth = regularLineWidth
        fourthLine.moveToPoint(CGPointMake(emailLabel.frame.origin.x, emailLabel.frame.origin.y + emailLabel.frame.size.height))
        fourthLine.addLineToPoint(CGPointMake(emailLabel.frame.origin.x + emailLabel.frame.size.width, emailLabel.frame.origin.y + emailLabel.frame.size.height))
        fourthLine.stroke()
   
        let fifthLine = UIBezierPath()
        fifthLine.lineWidth = regularLineWidth
        fifthLine.moveToPoint(CGPointMake(birthday.frame.origin.x, birthday.frame.origin.y + birthday.frame.size.height))
        fifthLine.addLineToPoint(CGPointMake(birthday.frame.origin.x + emailLabel.frame.size.width, birthday.frame.origin.y + birthday.frame.size.height))
        fifthLine.stroke()
        
        let sixthLine = UIBezierPath()
        sixthLine.lineWidth = regularLineWidth
        sixthLine.moveToPoint(CGPointMake(maleLabel.frame.origin.x, maleLabel.frame.origin.y + maleLabel.frame.size.height))
        sixthLine.addLineToPoint(CGPointMake(maleLabel.frame.origin.x + emailLabel.frame.size.width, maleLabel.frame.origin.y + maleLabel.frame.size.height))
        sixthLine.stroke()
        
    }
    
    
    
}