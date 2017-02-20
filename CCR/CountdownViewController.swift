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
    var timeRemaining = 15.0
    var totalTime = 15.0
    var timer = Timer()
    var timerIsOn = false
    var buttonSound = AVAudioPlayer()
    var isOnBreak = false
    
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var breakProgressLabel: UILabel!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBAction func resetTapped(_ sender: Any) {
        timer.invalidate()
        timeRemaining = 1500
        timeLabel.text = "25:00"
        timerIsOn = false
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        progressView.isHidden = false
        if !timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
            timerIsOn = true
        }
    }
    
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        timer.invalidate()
        timerIsOn = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatInitialViews()
        setupTimerBell()
        displayQuote()
    }
    
    func timerRunning() {
        //if the timer isn't a break timer,
        if !isOnBreak {
            timeRemaining -= 1
            let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
            progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
            progressLabel.text = "\(completionPercentage)% done"
            let minutesLeft = Int(timeRemaining) / 60 % 60
            let secondsLeft = Int(timeRemaining) % 60
            timeLabel.text = "\(minutesLeft):\(secondsLeft)"
            
            manageTimerEnd(seconds: timeRemaining)
            isOnBreak = true
        } else if isOnBreak {
            timeRemaining -= 1
            let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
            progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
            progressLabel.text = "\(completionPercentage)% done"
            let minutesLeft = Int(timeRemaining) / 60 % 60
            let secondsLeft = Int(timeRemaining) % 60
            timeLabel.text = "\(minutesLeft):\(secondsLeft)"
            
            manageTimerEnd(seconds: timeRemaining)
            isOnBreak = false

        }
//        timeRemaining -= 1
//        let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
//        progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
//        progressLabel.text = "\(completionPercentage)% done"
//        let minutesLeft = Int(timeRemaining) / 60 % 60
//        let secondsLeft = Int(timeRemaining) % 60
//        timeLabel.text = "\(minutesLeft):\(secondsLeft)"
//        
//        manageTimerEnd(seconds: timeRemaining)
//        isOnBreak = true
    }
    
    func manageTimerEnd(seconds: Double) {
        if seconds == 0 {
            //when the timer ends
            //1 - shut off timer
            //2 - update label
            //3 - play bell
            //4 - show pop up to rate interval
            //5 - initiate break timer
            timer.invalidate()
            timeLabel.text = "Time's Up!"
            buttonSound.play()
            showPopUp()
            setupBreakTimer()
        }

    }
    
    func setupBreakTimer() {
        //1 - reveal the breaktime label
        breakTimeLabel.isHidden = false
        //2 - hide the timeLabel
        timeLabel.isHidden = true
        //3 - reveal the breaktime progress label
        breakProgressLabel.isHidden = false
        //4 - hide the progress label
        progressLabel.isHidden = true
        timeRemaining = 300
        totalTime = 301
        timeRemaining -= 1
        let completionPercentage = Int(((Float(totalTime) - Float(timeRemaining))/Float(totalTime)) * 100)
        progressView.setProgress(Float(timeRemaining)/Float(totalTime), animated: false)
        progressLabel.text = "\(completionPercentage)% done"
        let minutesLeft = Int(timeRemaining) / 60 % 60
        let secondsLeft = Int(timeRemaining) % 60
        timeLabel.text = "\(minutesLeft):\(secondsLeft)"
    }
    
    func showPopUp() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    func displayQuote() {
        self.store.getQuote { (quote, author) in
            guard let unwrappedQuote = quote, let unwrappedAuthor = author else { return }
            self.quoteLabel.text = "\(unwrappedQuote) - \(unwrappedAuthor)"
        }
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
        breakTimeLabel.isHidden = true
        breakProgressLabel.isHidden = true
        resetButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "American Typewriter", size: 18.0) as Any], for: .normal)
        progressView.isHidden = true
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
