//
//  TaskCheckViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/22/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class TaskCheckViewController: UIViewController {

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var currentGoalLabel: UILabel!
    
    let store = DataStore.sharedInstance
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        print("yes button tapped")
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func noButtonTapped(_ sender: Any) {
        print("no button tapped")
        self.showSetGoalVC()
        self.performSegue(withIdentifier: "toBrandNewTask", sender: self)
    }
    
    //user clicked "no" and needs to set a new task
    func showSetGoalVC() {
        let goalCheckVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newTaskID") as! SetNewTaskViewController
        self.present(goalCheckVC, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! SetNewTaskViewController
        print("Hey I am being called")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
//        noButton.layer.borderWidth = 1
        noButton.layer.cornerRadius = 8
        yesButton.layer.borderColor = Constants.red.cgColor
        yesButton.layer.borderWidth = 1
        yesButton.layer.cornerRadius = 8
        currentGoalLabel.text = self.store.tasks.last?.description
        currentGoalLabel.layer.cornerRadius = 3
        
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
