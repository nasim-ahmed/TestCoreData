//
//  APIService.swift
//  TestCoreData
//
//  Created by Research on 8/23/17.
//  Copyright © 2017 HealthDiary. All rights reserved.
//

import Foundation

class APIService:NSObject {
    
    let query = "nature"
    lazy var endPoint:String = {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(self.query)&nojsoncallback=1#"
    }()
    
    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        
        let urlString = endPoint
        
        guard let url = URL(string: urlString) else { return completion(.Error("Invalid URL, we can't update your feed")) }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }


}

enum Result<T>{
    case Success(T)
    case Error(String)


}
