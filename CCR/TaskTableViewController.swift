//
//  TaskTableViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class TaskTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var timer = Timer()
    var counter = 0
    var timerIsOn = false
    
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var countingLabel: UILabel!
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        
        if !timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            timerIsOn = true
        }
        
    }

    @IBAction func pauseBtnPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        timer.invalidate()
        counter = 0
        countingLabel.text = "\(counter)"
        timerIsOn = false
    }
    
    func updateCounter() {
        counter += 1
        countingLabel.text = "\(counter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TaskCell
        cell.goalLabel.text = self.store.goals.last?.description
        cell.taskLabel.text = self.store.tasks.last?.description
        cell.starLabel.text = "\(self.store.tasks.last?.rating)/5 🌟"
        return cell
    }


}

