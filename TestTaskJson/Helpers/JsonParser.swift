//
//  JsonParser.swift
//  TestTaskJson
//
//  Created by Roma on 10/23/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import Foundation

class JsonParser: NSObject {
    
    //MARK: - Json Parser
    func parseJson(url: String, completion: @escaping ( _ objects: [Object]) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let jsonData = jsonString.data(using: .utf8)!
                        let response = try! JSONDecoder().decode([Object].self, from: jsonData)
                        completion(response)
                    }
                }
            }.resume()
        }
    }
}
