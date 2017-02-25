//
//  SetTaskViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/23/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class SetTaskViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let store = DataStore.sharedInstance
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        if taskTextField.text == "" {
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
            newTask.description = taskTextField.text //captures the task description
            self.store.goals.last?.Task = newTask //associates this task with a goal
            self.store.tasks.append(newTask) //adds it to the task array
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! TabBarController
        
        print("HEY I AM BEING CALLED")
    }
    
    func showTabBarVC() {
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTabBarID") as! TabBarController
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 8
    }

}
