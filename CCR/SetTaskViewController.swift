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
        if taskTextField.text != "" {
            let newTask = Task()
            //THIS IS WHERE THE TASK DESCRIPTION IS SET
            newTask.description = taskTextField.text! //captures the task description
            //FIRST SAVE OF TASK HERE
            self.store.addAndSaveTaskData(task: newTask)
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        } else {
            showMissingTaskAlert()
        }
    }
    
    func showMissingTaskAlert() {
        let noGoalAlert = UIAlertController(title: "Missing a Task", message: "", preferredStyle: .alert)
        let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 18)! ]
        let attributedTitle = NSMutableAttributedString(string: "You Must Enter a Task", attributes: titleFont)
        noGoalAlert.setValue(attributedTitle, forKey: "attributedTitle")
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        noGoalAlert.addAction(okAction)
        noGoalAlert.view.tintColor = Constants.red
        present(noGoalAlert, animated: true, completion: nil)
    }
    
    func showTabBarVC() {
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbTabBarID") as! TabBarController
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 8
        //I load the data here b/c this is our first view controller
        self.store.loadTaskData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! TabBarController
        
    }

}
