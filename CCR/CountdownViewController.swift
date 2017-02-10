//
//  CountdownViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/10/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class CountdownViewController: UIViewController {
    
    var numOfMin = 25
//    var numOfSec = 25 * 60
    var numOfSec = 1500
    var timer = Timer()

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func clearBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        if(numOfSec > 0){
            let minutes = String(numOfSec / 60)
            let seconds = String(numOfSec % 60)
            timeLabel.text = minutes + ":" + seconds
            numOfSec -= 1
        }
    }
    
    
    @IBAction func pauseBtnTapped(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playBtnTapped), userInfo: nil, repeats: true)
        
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
