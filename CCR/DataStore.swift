//
//  DataStore.swift
//  CCR
//
//  Created by Erica Millado on 2/13/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

class DataStore {
    static let sharedInstance = DataStore()
    private init() {}
    
    //delete this task array
//    var tasks: [Task] = []
    var goals: [Goal] = []
    
    var intervalCount = 0
    
    var userIsOnBreak = false
    
    
}
