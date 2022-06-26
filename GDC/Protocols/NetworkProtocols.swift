//
//  NetworkProtocols.swift
//  GDC
//
//  Created by Mac on 26/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation

protocol NetworkProtocols {
     func fetchSingleImage(config: Configuration, completion:@escaping (_ imageData: [Data]?, _ error: Error?) -> Void?)
    func fetchPetsImage(config: Configuration,completion:@escaping (_ imageData: [Data]?, _ error: Error?) -> Void?)
}
