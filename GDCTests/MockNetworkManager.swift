//
//  MockNetworkManager.swift
//  GDCTests
//
//  Created by Mac on 26/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
@testable import GDC
class MockNetworkManager {
    
    var shouldReturnError = false
    var fetchSingleImage = false
    var fetchPetsImage = false
    
    enum serverError: Error {
        case errorFetchingSingleImage
        case errorFetchingPetsImage
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let singleImageResponse: [String: Any] = ["message":"https://images.dog.ceo/breeds/terrier-fox/n02095314_2354.jpg","status":"success"]
    
}


extension MockNetworkManager: NetworkProtocols {
    func fetchSingleImage(config: Configuration, completion: @escaping ([Data]?, Error?) -> Void?) {
        
        DispatchQueue.global(qos: .default).async {
            
            if self.shouldReturnError {
                completion(nil, serverError.errorFetchingSingleImage)
            }else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: self.singleImageResponse, options: [])
                    let decoder = JSONDecoder()
                    let thisDog = try decoder.decode(Dog.self, from: jsonData)
                    guard let imageURL = URL(string: thisDog.imageUrl) else {
                        fatalError("dog image url is invalid")
                    }
                    
                    guard let imageData = try? Data(contentsOf: imageURL) else {
                        fatalError("could not get dog image data")
                    }
                    
                    completion([imageData], nil)
                } catch {
                    completion(nil,error)
                }
            }
            
        }
        
    }
    
    func fetchPetsImage(config: Configuration, completion: @escaping ([Data]?, Error?) -> Void?) {
        
    }
    
    
}
