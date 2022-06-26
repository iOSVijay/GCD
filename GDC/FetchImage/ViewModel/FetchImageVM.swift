//
//  FetchImageVM.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation

struct FetchImageVM {
    var fetchImageRequestData: FetchImageRequestData
    init(fetchImageRequestData: FetchImageRequestData) {
        self.fetchImageRequestData = fetchImageRequestData
    }
    mutating func fetchImage(sender: AnyObject,comletion:@escaping (_ imageData: [Data]?, _ error: Error?) -> Void?) {
        self.fetchImageRequestData.fetchImageFromWeb(sender: sender,completion: {(data, error) in
            comletion(data, error)
          })
    }
    
    // for concept clearance
    func optinalWrapping(str: String?) -> String{
        return str ?? "unknown"
    }
}
