//
//  SetGoalViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/21/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class SetGoalViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var goalTextField: UITextField!
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 8
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if goalTextField.text == "" {
            let noGoalAlert = UIAlertController(title: "You Must Enter a Goal", message: "", preferredStyle: .alert)
            
            let titleFont: [String : AnyObject] = [ NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 18)! ]
            let attributedTitle = NSMutableAttributedString(string: "You Must Enter a Goal", attributes: titleFont)
            noGoalAlert.setValue(attributedTitle, forKey: "attributedTitle")
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            noGoalAlert.addAction(okAction)
            present(noGoalAlert, animated: true, completion: nil)
            noGoalAlert.view.tintColor = Constants.red
            
        } else {
            
            //TODO: - write in perform segue here
            
            let newGoal = Goal()
            if let unwrappedText = goalTextField.text {
                newGoal.description = unwrappedText
            }
            self.store.goals.append(newGoal)
            
            self.performSegue(withIdentifier: "toSetTask", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! SetTaskViewController
        
        print("HEY I AM BEING CALLED")
    }
    
   func showNewTaskVC() {
        let taskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTaskID") as! SetTaskViewController
        self.present(taskVC, animated: true, completion: nil)
    }

}
