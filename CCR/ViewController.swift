//
//  ViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    var timerIsOn = false
    
    @IBOutlet weak var countingLabel: UILabel!
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        
//        if !timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
//            timerIsOn = true
//        }
        
    }

    @IBAction func pauseBtnPressed(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        timer.invalidate()
        counter = 0
        countingLabel.text = "\(counter)"
//        timerIsOn = false
    }
    
    func updateCounter() {
        counter += 1
        countingLabel.text = "\(counter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }



}

