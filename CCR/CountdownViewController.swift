//
//  CountdownViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import AVFoundation

class CountdownViewController: UIViewController {
    
    var timeRemaining = 1500.0
    var totalTime = 1500.0
//    var timeRemaining = 5.0
//    var totalTime = 5.0
    var breakTimeRemaining = 300.0
    var totalBreakTime = 300.0
//    var breakTimeRemaining = 5.0
//    var totalBreakTime = 5.0
    var timerIsOn = false
    var timer = Timer()
    var buttonSound = AVAudioPlayer()
    
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var editTaskTextField: UITextField!
    @IBOutlet weak var editTaskSubmitBtn: UIButton!
    @IBOutlet weak var editTaskConstraint: NSLayoutConstraint!
    @IBOutlet weak var editTaskPopUp: UIView!
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        if !self.store.userIsOnBreak {
            timer.invalidate()
            timeRemaining = 1500
            totalTime = 1500
            timeLabel.text = "25:00"
            timerIsOn = false
            playBtn.isEnabled = true
        } else if self.store.userIsOnBreak {
            timer.invalidate()
            breakTimeRemaining = 300
            totalBreakTime = 300
            breakTimeLabel.text = "5:00"
            timerIsOn = false
            playBtn.isEnabled = true
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if !self.store.userIsOnBreak{
            timer.invalidate()
            timerIsOn = false
            playBtn.isEnabled = true
        } else if self.store.userIsOnBreak {
            timer.invalidate()
            timerIsOn = false
            playBtn.isEnabled = true
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
    
        //this is a regular interval
        if !timerIsOn && !self.store.userIsOnBreak {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(regularTimerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
            playBtn.isEnabled = false
        }
        //this is a break interval
        if !timerIsOn && self.store.userIsOnBreak {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
            playBtn.isEnabled = false
        }
    }
    
    func manageTimerEnd(seconds: Double) {
        //regular 25 min interval is ending, stop the timer and show pop up
        if seconds == 0 && !self.store.userIsOnBreak {
            timer.invalidate()
            timerIsOn = false
            self.performSegue(withIdentifier: "toPopUp", sender: self)
        }
        if seconds == 0 && self.store.userIsOnBreak {
            timer.invalidate()
            timerIsOn = false
            self.performSegue(withIdentifier: "toTaskCheck", sender: self)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInitialViews()
        setupTimerBell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //here is when you play a break or not
        actionAfterPopUp()
        actionAfterCheckTask()
    }
    
    func actionAfterPopUp() {
        //formats the view to show "break mode"
        if self.store.userIsOnBreak {
            breakTimeLabel.isHidden = false
            timeLabel.isHidden = true
            progressView.trackTintColor = Constants.aqua
            playBtn.isEnabled = true
        }
    }
    
    func actionAfterCheckTask() {
        if !self.store.userIsOnBreak {
            breakTimeLabel.isHidden = true
            timeLabel.text = "25:00"
            timeLabel.isHidden = false
            progressView.trackTintColor = Constants.red
            playBtn.isEnabled = true
        }
    }
    
    func regularTimerRunning() {
        timeRemaining -= 1
        progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        timeLabel.text = "\(minutesLeft):\(secondsLeft)"
        timerIsOn = false
        manageTimerEnd(seconds: timeRemaining)
    }
    
    func breakTimerRunning() {
        breakTimeRemaining -= 1
        progressView.setProgress(Float(breakTimeRemaining)/Float(totalBreakTime), animated: false)
        let minutesLeft = Int(breakTimeRemaining) / 60 % 60
        let secondsLeft = Int(breakTimeRemaining) % 60
        breakTimeLabel.text = "\(minutesLeft):\(secondsLeft)"
        timerIsOn = false
        manageTimerEnd(seconds: breakTimeRemaining)
    }
    
    func setupTimerBell() {
        do {
            try buttonSound = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "double_ring_from_desk_bell", ofType: "mp3")!))
        } catch {
            print(error.localizedDescription)
            print("Error: There's an error with the audio file named double_ring_from_desk_bell.mp3")
        }
    }
    
    func formatInitialViews() {
        navigationController?.isNavigationBarHidden = true
//        goalLabel.text = self.store.tasks.last?.description
        goalLabel.text = self.store.goals.last?.tasks.last?.description
        breakTimeLabel.isHidden = true
        resetBtn.layer.borderColor = Constants.red.cgColor
        resetBtn.layer.cornerRadius = 8
        resetBtn.layer.borderWidth = 1
        progressView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2) * 2)
        editTaskPopUp.layer.borderColor = Constants.red.cgColor
        editTaskSubmitBtn.layer.borderColor = Constants.red.cgColor
    }

    @IBAction func showEditTaskPopUp(_ sender: Any) {
        editTaskConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3) { 
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func closeEditTaskPopUp(_ sender: Any) {
        //animates the view back off the screen
        editTaskConstraint.constant = -400
        if editTaskTextField.text != "" {
            guard let unwrappedEditedTask = editTaskTextField.text else { return }
            self.store.goals.last?.tasks.last?.description = unwrappedEditedTask
            goalLabel.text = unwrappedEditedTask
        }
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
