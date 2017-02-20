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
            var newInterval = Interval()
            switch rating {
            case 5:
                newInterval.rating = 5
                print("user chose 5 star")
            case 2:
                newInterval.rating = 2
                print("user chose 2 stars")
            case 3:
                newInterval.rating = 3
                print("user chose 3 stars")
            case 4:
                newInterval.rating = 4
                print("user chose 4 stars")
            default:
                newInterval.rating = 1
                print("user chose 1 stars")
            }
            self.store.intervals.append(newInterval)
            print("array count is \(self.store.intervals.count)")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
