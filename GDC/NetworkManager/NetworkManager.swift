//
//  NetworkManager.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
struct NetworkManager {
    
    func fetchImageApi(config: Configuration ,completion: @escaping (_ imageData: Data) -> Void? )  {
        Log.location(fileName: #file)
        DispatchQueue.global(qos: .userInteractive).async {
        
            let decoder = JSONDecoder()
            Log.queue(action: "fetching json")
            guard let imageJSON = try? Data(contentsOf: config.url) else {
                fatalError("could not get data from json url")
            }
            
            guard let thisDog = try? decoder.decode(Dog.self, from: imageJSON) else {
                fatalError("there must be problem decoding ...")
            }
            
            guard let imageURL = URL(string: thisDog.imageUrl) else {
                fatalError("dog image url is invalid")
            }
            Log.queue(action: "fetching image data")
            guard let imageData = try? Data(contentsOf: imageURL) else {
                fatalError("could not get dog image data")
            }
            
            sleep(3)
            completion(imageData)
        }
    }
}
