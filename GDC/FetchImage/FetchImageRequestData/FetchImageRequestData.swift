//
//  FetchImageRequestData.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
protocol buildUrl {
    func getUrl<T>(from inputData: T?) -> URL?
}

struct FetchImageRequestData {
    var netwrokManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.netwrokManager = networkManager
    }
    
    mutating func fetchImageFromWeb(sender: AnyObject,completion:@escaping (_ imgaeData: [Data]) -> Void?)  {
        guard let config = getConfig() else {
            return
        }
        self.netwrokManager.fetchImageApi(sender: sender,config: config, completion: {(data) in
            completion(data)
         })
    }
    
    private func getConfig() -> Configuration? {
       
        guard let url = getUrl(from: "") else {
            return nil
        }
        let config = Configuration(url: url)
        return config
    }
}

extension FetchImageRequestData: buildUrl {
    func getUrl<T>(from inputData: T?) -> URL? {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = ApiEndpoints.scheme
        urlComponent.host = ApiEndpoints.host
        urlComponent.path = ApiEndpoints.path
       return urlComponent.url
    }
    
    
}
