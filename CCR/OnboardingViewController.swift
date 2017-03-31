//
//  OnboardingViewController.swift
//  CCR
//
//  Created by Erica Millado on 3/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {

    @IBOutlet weak var onboardingView: OnboardingView!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnboardingView()
        getStartedButton.layer.cornerRadius = 5
        getStartedButton.layer.borderColor = UIColor.white.cgColor
        getStartedButton.layer.borderWidth = 2
    }
    
    func configureOnboardingView() {
        //add data source to our onboardingdata view
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    //tells how many onboarding screens you want; can also indicate this in .plist
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    //enables us to configure each onboarding item
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColor1 = UIColor.lightGray
        let backgroundColor2 = Constants.aqua
        let backgroundColor3 = Constants.red
        let titleFont = UIFont(name: "OpenSans-Bold", size: 30)!
        let reflectProgressFont = UIFont(name: "OpenSans-Bold", size: 25)!
        let descriptionFont = UIFont(name: "OpenSans-SemiBold", size: 17)!
        
        // (imageName: String, title: String, description: String, iconName: String, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)
        
        return [("Goal Filled-100red", "Set a Goal", "Think of major project you want to work on.  It can be a new app idea or a side project.\nExample: MAKE A PERSONAL WEBSITE.", "", backgroundColor1, UIColor.black, UIColor.black, titleFont, descriptionFont),
                ("Timer Filled-100", "Do a 25 Min. Sprint", "For your goal, decide on ONE task you need to work on to accomplish your goal.\nExample: CREATE WIREFRAMES FOR WEBSITE.", "", backgroundColor2, UIColor.white, UIColor.white, titleFont, descriptionFont),
                ("Todo List-100", "Reflect on your Progress", "You'll rate each task interval you complete and be able see your progress over time.", "", backgroundColor3, UIColor.white, UIColor.white, reflectProgressFont
                    , descriptionFont)][index]
    }
    
//    Tells the delegate the PaperOnboarding is about to draw a item for a particular row. Use this method for configure items
//    
//    - parameter item:  A OnboardingContentViewItem object that PaperOnboarding is going to use when drawing the row.
//    - parameter index: An curretn index item
//    */
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    //
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            if self.getStartedButton.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                })
            }
        }
    }
    
    //when it's done transitioning to a specific item, we can perform an animation action
    func onboardingDidTransitonToIndex(_ index: Int) {
        //if we get to the 3rd item
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                //reveal the button
                self.getStartedButton.alpha = 1
            })
        }
    }
    
    @IBAction func getStartedBtnTapped(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
}






















