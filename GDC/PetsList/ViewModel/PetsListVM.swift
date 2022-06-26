//
//  PetsListVM.swift
//  GDC
//
//  Created by Mac on 15/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
struct PetsListVM {
    // this class will fetch pets image using dispatch queue and dispatch group
    var fetchImageRequestData: FetchImageRequestData
    init(fetchImageRequestData: FetchImageRequestData) {
        self.fetchImageRequestData = fetchImageRequestData
    }
    mutating func fetchPetsImage(sender: AnyObject,completion: @escaping (_ imageData: [Data]?, _ error: Error?) -> Void? )  {
        
        self.fetchImageRequestData.fetchImageFromWeb(sender: sender, completion: { (data, error) in
            completion(data, error)
        })
    }
}
