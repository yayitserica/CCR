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
        
//        return [("Goal Filled-100", "Timer Filled-100", "Todo List-100")]
        return [("Goal Filled-100red", "Set a Goal", "Think of major project you want to work on.  It can be a new app idea or a side project.  Example: MAKE A PERSONAL WEBSITE.", "", backgroundColor1, UIColor.black, UIColor.black, titleFont, descriptionFont)][index]
        
        
    }

}
