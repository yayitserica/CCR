//
//  SetNewTaskViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/23/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class SetNewTaskViewController: UIViewController {

    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var addNewTaskButton: UIButton!
    
    let store = DataStore.sharedInstance
    
    @IBAction func addNewTaskTapped(_ sender: Any) {
        
        if newTaskTextField.text == "" {
            let noGoalAlert = UIAlertController(title: "Missing a Task", message: "", preferredStyle: .alert)
            let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 18)! ]
            let attributedTitle = NSMutableAttributedString(string: "You Must Enter a Task", attributes: titleFont)
            noGoalAlert.setValue(attributedTitle, forKey: "attributedTitle")
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            noGoalAlert.addAction(okAction)
            present(noGoalAlert, animated: true, completion: nil)
            noGoalAlert.view.tintColor = Constants.red
            
        } else {
            let newTask = Task()
            if let unwrappedText = newTaskTextField.text {
                newTask.description = unwrappedText
            }
            //SECOND SAVE OF TASK
            self.store.addAndSaveTaskData(task: newTask)
            print("a brand new task was added")
            self.performSegue(withIdentifier: "toTabBarController", sender: self)
        }
    }

    @IBAction func addNewGoalTapped(_ sender: Any) {
         self.performSegue(withIdentifier: "toNewGoal", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewTaskButton.layer.cornerRadius = 8
        addNewTaskButton.layer.borderColor = UIColor.white.cgColor
        addNewTaskButton.layer.borderWidth = 2
    }

}
