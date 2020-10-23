//
//  Object.swift
//  TestTaskJson
//
//  Created by Roma on 10/16/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import Foundation

struct Object: Decodable {
    
    struct Progress: Codable {
        var current: Int
        var total: Int
    }
    
    struct Images: Codable {
        var id: String
        var uri: String?
        var url: String?
    }
    
    struct Owner: Codable {
        var id: String
        var first_name: String
        var last_name: String
        var photo_url: URL
        var email: String?
    }
    
    struct Addresses: Decodable {
        var id: String?
        var city: String
        var state: String
        var zipcode: String
        var latitude: StringOrDouble
        var longitude: StringOrDouble
        
        enum StringOrDouble: Decodable {
            
            case string(String)
            case double(Double)
            
            init(from decoder: Decoder) throws {
                if let double = try? decoder.singleValueContainer().decode(Double.self) {
                    self = .double(double)
                    return
                }
                if let string = try? decoder.singleValueContainer().decode(String.self) {
                    self = .string(string)
                    return
                }
                throw Error.couldNotFindStringOrInt
            }
            enum Error: Swift.Error {
                case couldNotFindStringOrInt
            }
        }
        
    }
    
    var progress: Progress
    var images: [Images]
    var owner: Owner
    var addresses: [Addresses]
    
    var id: String
    var vin: String
    var license_plate: String?
    var license_plate_state: String?
    var mileage: Int
    var phone: String
    var price: Int
    var short_url: URL?
    var created_at:String
    var updated_at: String
    var transmission: String
    var title: String
    var make: String
    var model: String
    var year: Int
    var trim: String
}

