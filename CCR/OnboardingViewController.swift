//
//  OnboardingViewController.swift
//  CCR
//
//  Created by Erica Millado on 3/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource {

    @IBOutlet weak var onboardingView: OnboardingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOnboardingView()
    }
    
    func configureOnboardingView() {
        //add data source to our onboardingdata view
        onboardingView.dataSource = self
    }
    
    //tells how many onboarding screens you want; can also indicate this in .plist
    func onboardingItemsCount() -> Int {
//        return 3
        return 1
    }
    
    //enables us to configure each onboarding item
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColor1 = UIColor.white
        let backgroundColor2 = Constants.aqua
        let backgroundColor3 = Constants.red
        let titleFont = UIFont(name: "OpenSans-Bold", size: 30)!
        let descriptionFont = UIFont(name: "OpenSans-SemiBold", size: 16)!
        
        // (imageName: String, title: String, description: String, iconName: String, color: UIColor, titleColor: UIColor, descriptionColor: UIColor, titleFont: UIFont, descriptionFont: UIFont)
        
        return [("Goal Filled-100red", "Set a Goal", "Think of major project you want to work on.  It can be a new app idea or a side project.  Example: MAKE A PERSONAL WEBSITE.", "", backgroundColor1, UIColor.black, UIColor.black, titleFont, descriptionFont)][index]
        
        [("Timer Filled-100", "Do a 25 Min. Sprint", "For your goal, decide on ONE task you need to work on to accomplish your goal.  Example: CREATE WIREFRAMES FOR WEBSITE.", "", backgroundColor2, UIColor.white, UIColor.white, titleFont, descriptionFont)]
        
    }

}
