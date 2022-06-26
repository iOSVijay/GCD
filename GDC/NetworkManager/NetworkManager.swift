//
//  NetworkManager.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
struct NetworkManager {
    // this class is used for network calls
    
    mutating func fetchImageApi(sender: AnyObject, config: Configuration ,completion: @escaping (_ imageData: [Data]?, _ error: Error?) -> Void? )  {
        
        if let _ = sender as? PetsListVC {
            // dispatch queue is used and group dispatch is used to notify the completion
            self.fetchPetsImage(config: config, completion: completion)
        }
        else {
            // in this method nsoperation is used
            self.fetchSingleImage(config: config, completion: completion)
        }
        
    }
    
   
}


extension NetworkManager: NetworkProtocols {
    
    func fetchSingleImage(config: Configuration, completion:@escaping (_ imageData: [Data]?, _ error: Error?) -> Void?)  {
        
        Log.location(fileName: #file)
        var imageUrl: URL?
        var dogImgData: Data?
        var apierror: Error?
        
        var dog: Dog?
        var imageDataArr: [Data] = [Data]()
        let operationQueue = OperationQueue()
        operationQueue.qualityOfService = .userInteractive
        
        let operationFetchJson = BlockOperation(block: {
            
            Log.queue(action: "fetching json")
            
            let task = URLSession.shared.dataTask(with: config.url) { (data, response, error) in
                guard let unwrappedData = data else {
                    //                    completion(nil, error)
                    apierror = error
                    return
                    
                }
                if (error == nil && unwrappedData.count != 0)
                {
                    let decoder = JSONDecoder()
                    do {
                        let thisDog = try decoder.decode(Dog.self, from: unwrappedData)
                        dog = thisDog
                        //                        completion(response.usersList, error)
                        apierror = error
                    }
                    catch let error {
                        //                        completion(nil, error)
                        apierror = error
                        print("fatal error")
                    }
                }
                
            }
            task.resume()
            
        })
        
        let operationFetchUrl = BlockOperation(block: {
            sleep(5)
            Log.queue(action: "fetching Dog URL")
            guard let dog = dog else {return}
            guard let imageURL = URL(string: dog.imageUrl) else {
                fatalError("dog image url is invalid")
            }
            imageUrl = imageURL
            
        })
        
        operationFetchUrl.addDependency(operationFetchJson)
        let operationFetchImage = BlockOperation(block: {
            sleep(5)
            Log.queue(action: "fetching image data")
            guard let imageUrl = imageUrl else {return}
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                fatalError("could not get dog image data")
            }
            dogImgData = imageData
        })
        operationFetchImage.addDependency(operationFetchUrl)
        
        
        let completionBlock = {
            sleep(5)
            print("all task done+++++++")
            Log.queue(action: "completion")
            guard let dogImgData = dogImgData else {
                return
            }
            imageDataArr.append(dogImgData)
            completion(imageDataArr, apierror)
        }
        let completionOperation = BlockOperation(block: {
            completionBlock()
        })
        completionOperation.addDependency(operationFetchImage)
        operationQueue.addOperations([operationFetchJson,operationFetchUrl,operationFetchImage,completionOperation], waitUntilFinished: false)
        
    }
    
    func fetchPetsImage(config: Configuration,completion: @escaping (_ imageData: [Data]?, _ error: Error?) -> Void? )  {
        
        let queue = DispatchQueue.init(label: "downloadPetImage", qos: .userInteractive)
        var imageDataArr = [Data]()
        let dispatchGroup = DispatchGroup()
        
        for _ in 0...20 {
            
            queue.async(group: dispatchGroup, qos: .userInteractive){
                
                
                let decoder = JSONDecoder()
                Log.queue(action: "fetching json")
                guard let imageJSON = try? Data(contentsOf: config.url) else {
                    fatalError("could not get data from json url")
                }
                
                guard let thisDog = try? decoder.decode(Dog.self, from: imageJSON) else {
                    fatalError("there must be problem decoding ...")
                }
                
                Log.queue(action: "fetching Dog URL")
                guard let imageURL = URL(string: thisDog.imageUrl) else {
                    fatalError("dog image url is invalid")
                }
                
                Log.queue(action: "fetching image data")
                guard let imageData = try? Data(contentsOf: imageURL) else {
                    fatalError("could not get dog image data")
                }
                imageDataArr.append(imageData)
                
            }
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            
            print("all task done+++++++")
            Log.queue(action: "completion")
            completion(imageDataArr, nil)
        })
    }
}
