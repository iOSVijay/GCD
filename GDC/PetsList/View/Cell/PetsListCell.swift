//
//  PetsListCell.swift
//  GDC
//
//  Created by Mac on 15/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class PetsListCell: UICollectionViewCell {
    
    @IBOutlet weak var petImage: UIImageView!
    
    func setUpCell(imageData: Data)  {
        self.petImage.image = UIImage(data: imageData)
    }
}
