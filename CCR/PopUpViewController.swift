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
        takeBreakLabel.layer.borderColor = UIColor.white.cgColor
        takeBreakLabel.layer.borderWidth = 2
        takeBreakLabel.layer.cornerRadius = 8
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        showAnimate()
        
        
        starringView.didFinishTouchingCosmos = { rating in
            switch rating {
            case 5:
                self.store.intervals.last?.rating = 5
            case 2:
                self.store.intervals.last?.rating = 2
            case 3:
                self.store.intervals.last?.rating = 3
            case 4:
                self.store.intervals.last?.rating = 4
            default:
                self.store.intervals.last?.rating = 1
            }
            print("array count is still \(self.store.intervals.count)\n")
            
            if let unwrappedInterval = self.store.intervals.last {
//                print("The most recent interval is \(unwrappedInterval.goal) and \(unwrappedInterval.rating)\n")
//                dump(self.store.intervals)
            }
            
        }
    }
    
    @IBAction func closePopUp(_ sender: Any) {
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
                self.view.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGoalCheck" {
            if let destinationVC = segue.destination as? SetGoalViewController {
//                print("Have segued to creating a new goal VC")
            }
        }
    }
    

}
