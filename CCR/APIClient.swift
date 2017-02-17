//
//  APIClient.swift
//  CCR
//
//  Created by Erica Millado on 2/13/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

class APIClient {
    class func getQUOTEJSON(completion: @escaping ([String: Any]?)-> Void) {
        let url = URL(string: "http://quotes.rest/qod.json?category=inspire")
        guard let unwrappedURL = url else { print("Error unwrapping url"); return }
        let session = URLSession.shared
        let datatask = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let unwrappedData = data else { print("Error unwrapping data"); return }
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any]
                completion(responseJSON)
            } catch {
                print(error.localizedDescription)
            }
        }
        datatask.resume()
    }
}
