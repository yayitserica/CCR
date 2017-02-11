//
//  CountdownViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var timeRemaining = 1500
    var timer = Timer()
    var timerIsOn = false
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        timer.invalidate()
        timeRemaining = 1500
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        timeLabel.text = "25:00"
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        
        timeRemaining = 1500
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
        
    }
    
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        timer.invalidate()
    }
    
    func timerRunning() {
        timeRemaining -= 1
        
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
//        timeLabel.text = "Time Left: \(timeRemaining)"
        timeLabel.text = "\(minutesLeft):\(secondsLeft)"
        
        if timeRemaining == 0 {
            timer.invalidate()
            timeLabel.text = "Time's Up!"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
