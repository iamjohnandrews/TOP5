//
//  SignUp2VC.swift
//  TOP5
//
//  Created by John Andrews on 10/25/15.
//  Copyright © 2015 John Andrews. All rights reserved.
//

import Foundation
import UIKit

class SignUp2VC: UIViewController {

    @IBOutlet weak var tellMoreLabel: UILabel!

    @IBOutlet weak var relationshipLabel: UILabel!

    @IBOutlet weak var ethnicityLabel: UILabel!
    
    @IBOutlet weak var sexOLabel: UILabel!
    
    @IBOutlet weak var singleLabel: UIButton!
    @IBOutlet weak var committedLabel: UIButton!
    @IBOutlet weak var marriedLabel: UIButton!
    @IBOutlet weak var divorcedLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        tellMoreLabel.preferredMaxLayoutWidth = self.view.bounds.width
        relationshipLabel.preferredMaxLayoutWidth = self.view.bounds.width
        ethnicityLabel.preferredMaxLayoutWidth = self.view.bounds.width
        sexOLabel.preferredMaxLayoutWidth = self.view.bounds.width
        
        addAutoLayoutConstraints()
    }
    
    func addAutoLayoutConstraints() {
        tellMoreLabel.translatesAutoresizingMaskIntoConstraints = false
        relationshipLabel.translatesAutoresizingMaskIntoConstraints = false
        ethnicityLabel.translatesAutoresizingMaskIntoConstraints = false
        sexOLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let viewDict = ["tellMoreLabel": tellMoreLabel, "relationshipLabel": relationshipLabel, "ethnicityLabel": ethnicityLabel, "sexOLabel": sexOLabel]
        
        let tellMoreLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[tellMoreLabel]|", options: .AlignAllCenterX, metrics: nil, views: viewDict)
        self.view.addConstraints(tellMoreLabelHConstrinats)
        
        let relationshipLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[relationshipLabel]|", options: .AlignAllCenterX, metrics: nil, views: viewDict)
        self.view.addConstraints(relationshipLabelHConstrinats)
        
        let ethnicityLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[ethnicityLabel]|", options: .AlignAllCenterX, metrics: nil, views: viewDict)
        self.view.addConstraints(ethnicityLabelHConstrinats)
        
        let sexOLabelHConstrinats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[sexOLabel]|", options: .AlignAllCenterX, metrics: nil, views: viewDict)
        self.view.addConstraints(sexOLabelHConstrinats)
        
        let relationshipViewDict = ["singleLabel": singleLabel, "committedLabel": committedLabel, "marriedLabel": marriedLabel, "divorcedLabel": divorcedLabel]
        
        
     
        
//        let vContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-distanceFromNavBar-[tellMoreLabel]-60-[relationshipLabel]-vDistanceBTWLabels-[ethnicityLabel]-distanceFromNavBar-[sexOLabel]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: metrics, views: viewDict)
//        self.view.addConstraints(vContraint)
        
    }
    
    
    // MARK: Actions
    @IBAction func sexOButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func ethnicityButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func relationshipButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
    }
}
