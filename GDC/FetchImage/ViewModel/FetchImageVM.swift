//
//  FetchImageVM.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation

struct FetchImageVM {
    let fetchImageRequestData: FetchImageRequestData
    init(fetchImageRequestData: FetchImageRequestData) {
        self.fetchImageRequestData = fetchImageRequestData
    }
    func fetchImage(comletion:@escaping (_ imageData: Data) -> Void?) {
          self.fetchImageRequestData.fetchImageFromWeb(completion: {(data) in
            comletion(data)
          })
    }
}
