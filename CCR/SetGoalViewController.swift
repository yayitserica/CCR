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
        submitButton.layer.borderColor = UIColor.white.cgColor
        submitButton.layer.borderWidth = 2
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if goalTextField.text == "" {
            let noGoalAlert = UIAlertController(title: "Missing a Task", message: "Enter a goal", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            noGoalAlert.addAction(okAction)
            present(noGoalAlert, animated: true, completion: nil)
        } else {
            let newGoal = Goal()
            if let unwrappedText = goalTextField.text {
                newGoal.description = unwrappedText
            }
            self.store.goals.append(newGoal)
            showNewTaskVC()
            self.view.removeFromSuperview()
        }
    }
    
   func showNewTaskVC() {
        let taskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTaskID") as! SetTaskViewController
        self.present(taskVC, animated: true, completion: nil)
    }

}
