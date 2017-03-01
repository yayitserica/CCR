//
//  PopUpViewController.swift
//  CCR
//
//  Created by Erica Millado on 2/18/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import Cosmos

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var takeBreakLabel: UIButton!
    @IBOutlet weak var starringView: CosmosView!
    
    let store = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takeBreakLabel.layer.borderColor = Constants.red.cgColor
        takeBreakLabel.layer.borderWidth = 1
        takeBreakLabel.layer.cornerRadius = 8
        showAnimate()
        
        starringView.didFinishTouchingCosmos = { rating in
            switch rating {
            case 5:
                self.store.tasks.last?.rating = "🌟🌟🌟🌟🌟"
            case 2:
                self.store.tasks.last?.rating = "🌟🌟"
            case 3:
                self.store.tasks.last?.rating = "🌟🌟🌟"
            case 4:
                self.store.tasks.last?.rating = "🌟🌟🌟🌟"
            case 1:
                self.store.tasks.last?.rating = "🌟"
            default:
                self.store.tasks.last?.rating = "no rating yet"
            }
            print("array count of rated tasks is \(self.store.tasks.count)\n")
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        removeAnimate()
    }

    func showAnimate() {
        //makes the view bigger
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        //gets smaller
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            //makes it go from smaller to bigger
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0
        }) { (success) in
            if success {
                //once finishes, it removes from view
                self.store.userIsOnBreak = true
                self.performSegue(withIdentifier: "showTabBar", sender: self)
            }
        }
    }

}
