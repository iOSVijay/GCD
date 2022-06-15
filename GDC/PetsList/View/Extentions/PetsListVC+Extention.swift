//
//  PetsListVC+Extention.swift
//  GDC
//
//  Created by Mac on 15/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import Foundation
import UIKit
extension PetsListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellIdentifier, for: indexPath as IndexPath) as! PetsListCell
        
        cell.setUpCell(imageData: imageDataArr[indexPath.row])
        return cell
    }
    
    
}
