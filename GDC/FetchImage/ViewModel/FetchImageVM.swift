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
    mutating func fetchImage(sender: AnyObject,comletion:@escaping (_ imageData: [Data]) -> Void?) {
        self.fetchImageRequestData.fetchImageFromWeb(sender: sender,completion: {(data) in
            comletion(data)
          })
    }
}
