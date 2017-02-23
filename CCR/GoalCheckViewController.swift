//
//  GoalCheckViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/22/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit

class GoalCheckViewController: UIViewController {

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noButton.layer.borderColor = UIColor.white.cgColor
        noButton.layer.borderWidth = 2
        noButton.layer.cornerRadius = 8
        yesButton.layer.borderColor = UIColor.white.cgColor
        yesButton.layer.borderWidth = 2
        yesButton.layer.cornerRadius = 8
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
