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
    
//    var timeRemaining = 1500.0
//    var totalTime = 1500.0
    var timeRemaining = 5.0
    var totalTime = 5.0
//    var breakTimeRemaining = 300.0
//    var totalBreakTime = 300.0
    var breakTimeRemaining = 5.0
    var totalBreakTime = 5.0
//    var longBreakTimeRemaining = 1200.0
//    var totalLongBreakTime = 1200.0
    var longBreakTimeRemaining = 10.00
    var totalLongBreakTime = 10.0
    var timerIsOn = false
    var timer = Timer()
    var buttonSound = AVAudioPlayer()
    var isOnBreak = false
    var isOnLongBreak = false
    
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        if !isOnBreak {
            timer.invalidate()
            timeRemaining = 1500
            totalTime = 1500
            timeLabel.text = "25:00"
            timerIsOn = false
            playBtn.isEnabled = true
        } else if isOnBreak {
            timer.invalidate()
            breakTimeRemaining = 300
            totalBreakTime = 300
            breakTimeLabel.text = "5:00"
            timerIsOn = false
            playBtn.isEnabled = true
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: Any) {
        if !isOnBreak {
            timer.invalidate()
            timerIsOn = false
            playBtn.isEnabled = true
        } else if isOnBreak {
            timer.invalidate()
            timerIsOn = false
            playBtn.isEnabled = true
        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        //regular interval
        if !timerIsOn && !isOnBreak {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
            playBtn.isEnabled = false
            //5 minute break interval
        } else if !timerIsOn && isOnBreak {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerRunning), userInfo: nil, repeats: true)
            playBtn.isEnabled = false
            //20 minute break interval
        } else if !timerIsOn && isOnLongBreak {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(longBreakTimerRunning), userInfo: nil, repeats: true)
            playBtn.isEnabled = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInitialViews()
        setupTimerBell()
    }
    
    func timerRunning() {
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
    
    func longBreakTimerRunning() {
        longBreakTimeRemaining -= 1
        progressView.setProgress(Float(longBreakTimeRemaining)/Float(totalLongBreakTime), animated: false)
        let minutesLeft = Int(longBreakTimeRemaining) / 60 % 60
        let secondsLeft = Int(longBreakTimeRemaining) % 60
        breakTimeLabel.text = "\(minutesLeft):\(secondsLeft)"
        timerIsOn = false
        manageTimerEnd(seconds: longBreakTimeRemaining)
    }
    
    func manageTimerEnd(seconds: Double) {
        // a break for the first, second and third intervals: 0 seconds, not on a break and the interval is 1 or 2
        if seconds == 0 && !isOnBreak && self.store.intervalCount < 4 {
            timer.invalidate() //turn off the timer
            timerIsOn = false //set the timer to off
            timeLabel.text = "Time to take a break!" //update the label
            buttonSound.play() //play a bell
            showPopUp() //show the rating popup
            setupBreakTimer() //format the timer
            breakTimeLabel.text = "5:00"
            isOnBreak = true //change the status to be "on a break"
            playBtn.isEnabled = true
            //change these times
            breakTimeRemaining = 5.00 //resets the break time for the next break
            totalBreakTime = 5.00
            self.store.intervalCount += 1 //counts up to the next interval
            print("interval count is less than or equal to 4: \(self.store.intervalCount)")
        // a long break for the 4th interval; 0 seconds, not on a LONG break, and the interval count is exactly 4
        } else if seconds == 0 && !isOnLongBreak && self.store.intervalCount == 4 {
            self.store.intervalCount = 0
            print("interval count has been reset to 0")
            timer.invalidate()
            timerIsOn = false
            timeLabel.text = "Time to take a long break!"
            buttonSound.play()
            showPopUp()
            setupBreakTimer()
            breakTimeLabel.text = "20:00"
            isOnBreak = true
            isOnLongBreak = true
            playBtn.isEnabled = true
            //change these times
            breakTimeRemaining = 10.00
            totalBreakTime = 10.00
        } else if seconds == 0 && (isOnBreak || isOnLongBreak) {
            isOnBreak = false
            isOnLongBreak = false
            timer.invalidate()
            timerIsOn = false
            timeLabel.text = "25:00"
            self.performSegue(withIdentifier: "toTaskCheck", sender: self)
//            showTaskCheckVC()
            playBtn.isEnabled = true
            buttonSound.play()
            breakTimeLabel.isHidden = true
            timeLabel.isHidden = false
            resetBtn.tintColor = Constants.fuschia
            playBtn.tintColor = Constants.fuschia
            pauseBtn.tintColor = Constants.fuschia
            //change these times
            timeRemaining = 5.0
            totalTime = 5.0
            
            //delete this
            //showNewGoalVC()
        } 

    }
    
    func setupBreakTimer() {
        breakTimeLabel.isHidden = false
        timeLabel.isHidden = true
        progressView.trackTintColor = Constants.aqua
        progressView.layer.cornerRadius = 3
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! TaskCheckViewController
    }
    
    func showPopUp() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
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
        goalLabel.text = self.store.tasks.last?.description
        breakTimeLabel.isHidden = true
        resetBtn.layer.borderColor = Constants.red.cgColor
        resetBtn.layer.cornerRadius = 8
        resetBtn.layer.borderWidth = 1
        progressView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_2) * 2)
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
