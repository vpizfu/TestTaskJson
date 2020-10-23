//
//  Downloader.swift
//  TestTaskJson
//
//  Created by Roma on 10/22/20.
//  Copyright © 2020 Roma. All rights reserved.
//

import Foundation
import UIKit

class Downloader: NSObject {
    
    //MARK: - Image Downloader
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage, URL) -> ()) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                completion(UIImage(data: data)!, url)
            }
        }
    }
}
