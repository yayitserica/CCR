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
    
    //creates a path to where we are storing our data
    var filePath: String {
        let manager = FileManager.default //FileManager manages file and folders in your app
        //documentDirectory is the recommended place to store things
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first //this returns an array of urls and we get the first url
        return url!.appendingPathComponent("Data").path //this returns a url path component (create a new path component and put our data on this path)
    }
    
    private func saveData(task: Task) {
        self.store.tasks.append(task)
        //this finds our encode (saves) function, passes this to our goals class and finds the "encode" function, then encodes the values for the keys and it will save it to our filepath
        NSKeyedArchiver.archiveRootObject(self.store.tasks, toFile: filePath)
    }
    
    private func loadData() {
        //check if we can get our data as a Task array and if so, we assign it to our tasks array
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Task] {
            self.store.tasks = ourData
        }
    }
    
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
            newTask.description = taskTextField.text! //captures the task description
            self.saveData(task: newTask)
            //delete this maybe
//            self.store.tasks.append(newTask) //WONDERING IF THIS WILL WORK
            print("the number of tasks for this given goal is \(self.store.tasks.count)")
            self.performSegue(withIdentifier: "toTabBar", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! TabBarController
        
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
