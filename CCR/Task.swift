//
//  Interval.swift
//  CCR
//
//  Created by Erica Millado on 2/20/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

//class Task {
//    var rating: String?
////    var description: String? 
//    var description: String = ""
//    
//}

class Task: NSObject, NSCoding {
    
    struct Keys {
        //static variables don't require us to make a Keys object to access these 2 properties below
        static let Rating = "rating"
        static let Description = "description"
    }
    
    private var _rating = ""
    private var _description = ""
    
    override init() {}
    
    //our own initializer
    init(rating: String, description: String) {
        self._rating = rating
        self._description = description
    }
    
    //init that takes the nscoder decoder and is going to decode (load) our object
    required init(coder decoder: NSCoder) {
        //if this object exists, cast it as a string
        if let ratingObj = decoder.decodeObject(forKey: Keys.Rating) as? String {
            _rating = ratingObj
        }
        if let descriptionObj = decoder.decodeObject(forKey: Keys.Description) as? String {
            _description = descriptionObj
        }
    }
    
    //this is going to encode (save)
    func encode(with coder: NSCoder) {
        coder.encode(_rating, forKey: Keys.Rating)
        coder.encode(_description, forKey: Keys.Description)
    }
    
    var rating: String {
        get {
            return _rating
        }
        set {
            _rating = newValue
        }
    }
    
    override var description: String {
        get {
            return _description
        }
        set {
            _description = newValue
        }
    }
    
}



























