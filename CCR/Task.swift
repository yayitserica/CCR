//
//  Interval.swift
//  CCR
//
//  Created by Erica Millado on 2/20/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding {
    
    struct Keys {
        //static variables don't require us to make a Keys object to access these 2 properties below
        static let RatingString = "rating"
        static let Description = "description"
        static let RatingDouble = "ratingDouble"
    }
    
    private var _ratingString = ""
    private var _description = ""
    private var _ratingDouble: Double?
    
    override init() {}
    
    //our own initializer
    init(ratingString: String, description: String, ratingDouble: Double) {
        self._ratingString = ratingString
        self._description = description
        self._ratingDouble = ratingDouble
    }
    
    //init that takes the nscoder decoder and is going to decode (load) our object
    required init(coder decoder: NSCoder) {
        //if this object exists, cast it as a string
        if let ratingObj = decoder.decodeObject(forKey: Keys.RatingString) as? String {
            _ratingString = ratingObj
        }
        if let descriptionObj = decoder.decodeObject(forKey: Keys.Description) as? String {
            _description = descriptionObj
        }
        if let ratingDoubleObj = decoder.decodeObject(forKey: Keys.RatingDouble) as? Double {
            _ratingDouble = ratingDoubleObj
        }
    }
    
    //this is going to encode (save)
    func encode(with coder: NSCoder) {
        coder.encode(_ratingString, forKey: Keys.RatingString)
        coder.encode(_description, forKey: Keys.Description)
        coder.encode(_ratingDouble, forKey: Keys.RatingDouble)
    }
    
    var ratingString: String {
        get {
            return _ratingString
        }
        set {
            _ratingString = newValue
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
    
    var ratingDouble: Double? {
        get {
            return _ratingDouble
        }
        set {
            _ratingDouble = newValue
        }
    }
    
}



























