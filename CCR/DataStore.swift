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
    
    var tasks: [Task] = []
    var ratings: [Double] = []
    
    var intervalCount = 0
    
    var userIsOnBreak = false
    
    let manager = FileManager.default //FileManager manages file and folders in your app
    //documentDirectory is the recommended place to store things
    
    //creates a path to where we are storing our data
    var filePath: String {
        
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first //this returns an array of urls and we get the first url
        return url!.appendingPathComponent("TasksData").path //this returns a url path component (create a new path component and put our data on this path)
    }
    
    var ratingsFilePath: String {
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).last //this returns the last url
        return url!.appendingPathComponent("RatingsData").path
    }
    
    func addAndSaveTaskData(task: Task) {
        self.tasks.append(task)
        //this finds our encode (saves) function, passes this to our goals class and finds the "encode" function, then encodes the values for the keys and it will save it to our filepath
        saveTaskData()
    }
    
    func addAndSaveRatingsData(rating: Double) {
        self.ratings.append(rating)
        saveRatingData()
    }
    
    func saveTaskData() {
        NSKeyedArchiver.archiveRootObject(self.tasks, toFile: filePath)
    }
    
    func saveRatingData() {
        NSKeyedArchiver.archiveRootObject(self.ratings, toFile: ratingsFilePath)
    }
    
    func loadTaskData() {
        //check if we can get our data as a Task array and if so, we assign it to our tasks array
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Task] {
            self.tasks = ourData
        }
    }
    
    func loadRatingsData() {
        if let ratingsData = NSKeyedUnarchiver.unarchiveObject(withFile: ratingsFilePath) as? [Double] {
            self.ratings = ratingsData
        }
    }
    
    
    func deleteAndSaveTaskData(at index: Int) {
        self.tasks.remove(at: index)
        NSKeyedArchiver.archiveRootObject(self.tasks, toFile: filePath)
    }
    
    func deleteAndSaveRatingsData(at index: Int) {
        self.ratings.remove(at: index)
        NSKeyedArchiver.archiveRootObject(self.ratings, toFile: ratingsFilePath)
    }
    
    
}
