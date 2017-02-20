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
    
    var intervals: [Interval] = []
    
    func getQuote(completion: @escaping (String?, String?)-> Void) {
        APIClient.getQUOTEJSON { (quoteJSON) in
            let contents = quoteJSON?["contents"] as? [String: Any]
            let quotes = contents?["quotes"] as? [[String: Any]]
            let firstQuote = quotes?[0]
            let quoteString = firstQuote?["quote"] as? String
            let author = firstQuote?["author"] as? String
            completion(quoteString, author)
        }
    }
}
