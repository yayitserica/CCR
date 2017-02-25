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
            self.store.tasks.append(newTask)
            print("a brand new task was added")
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func addNewGoalTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toNewGoal", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! SetGoalViewController
        print("going to a new goal")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewTaskButton.layer.cornerRadius = 8
        addNewTaskButton.layer.borderColor = UIColor.white.cgColor
        addNewTaskButton.layer.borderWidth = 2
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let dest = segue.destination as! TabBarController
//        print("going back to tab bar")
//    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
