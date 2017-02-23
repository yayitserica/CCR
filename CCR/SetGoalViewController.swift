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
        
        if goalTextField.text == nil {
            let noGoalAlert = UIAlertController(title: "Missing a Task", message: "Enter ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
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
        let taskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTaskID") as! SetGoalViewController
        self.present(taskVC, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
