//
//  PetsListVC.swift
//  GDC
//
//  Created by Mac on 15/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit

class PetsListVC: UIViewController {
    var imageDataArr = [Data]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var petsListVM = PetsListVM(fetchImageRequestData: FetchImageRequestData(networkManager: NetworkManager()))
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func loadPets(_ sender: Any) {
        petsListVM.fetchPetsImage(sender: self,completion: {[weak self] (data, error) in
            guard let imageData = data else { return nil }
            self?.imageDataArr = imageData
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
            return nil
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
