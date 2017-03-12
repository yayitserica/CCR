//
//  TaskTableViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class TaskTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let store = DataStore.sharedInstance
    var deleteTaskIndexPath: IndexPath? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (store.tasks.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TaskCell
        cell.goalLabel.text = self.store.tasks[indexPath.row].description
        cell.starLabel.text = self.store.tasks[indexPath.row].rating
        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "🗑") { (action, indexPath) in
            self.tableView.dataSource?.tableView?(self.tableView, commit: .delete, forRowAt: indexPath)
            return
        }
        deleteButton.backgroundColor = Constants.grey
        return [deleteButton]
    }
    
    //this delegate method causes the buttons to appear on swipe (when I swipe left to delete the cell)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //1 - we evaluate the editing style from the method's parameter list and compare it to the .delete editing style to know that the delete button was tapped
        if editingStyle == .delete {
            //2 - store the index path in a class-viewable variable so we can use it later on when we handle the deletion
            deleteTaskIndexPath = indexPath
            
            let taskToDelete = self.store.tasks[indexPath.row]
            confirmDelete(task: taskToDelete)
//            if let taskToDelete = self.store.tasks[indexPath.row] {
//                //3 - call the confirmeDelete function
//                confirmDelete(task: taskToDelete)
//            }
            
        }
    }
    
    //4 - this method confirms that the user really wants to delete a particular task they've initiated the delete action on
    func confirmDelete(task: Task) {
//        guard let taskDescription = task.description else { return }
        let alert = UIAlertController(title: "Delete Task", message: "", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteTask)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteTask)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 18)! ]
        let attributedTitle = NSMutableAttributedString(string: "Are you sure you want to permanently delete '\(task.description)'?", attributes: titleFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        
        //support display in ipad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height)/2.0, width: 1.0, height: 1.0)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteTask(alertAction: UIAlertAction!) {
        
        if let indexPath = deleteTaskIndexPath {
            //.beginUpdates signals the start of UI updates to the tableview
            tableView.beginUpdates()
            //removes the task from the data source using the deleteTaskIndexPath we set in the alert controller step
            self.store.tasks.remove(at: indexPath.row)
            print("The task array count for this current goal is now \(self.store.tasks.count)")
            //note that indexPath is wrapped in an array: [indexPath]
            //removes the task from the UI
            tableView.deleteRows(at: [indexPath], with: .automatic) //you can delete several rows at a time
            //resets the deletePlanetIndexPath variable to nil
            deleteTaskIndexPath = nil
            //this completes the UI updates
            tableView.endUpdates()
        }
    }
    
    func cancelDeleteTask(alertAction: UIAlertAction!) {
        deleteTaskIndexPath = nil
    }

}

