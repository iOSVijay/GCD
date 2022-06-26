//
//  ViewController.swift
//  GDC
//
//  Created by Mac on 14/06/22.
//  Copyright © 2022 Mac. All rights reserved.
//

import UIKit
// In this class we will fetch image.
class FetchImageVC: UIViewController {

    @IBOutlet weak var dogImage: UIImageView!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var increaseBtn: UIButton!
    
    var fetchImageVM = FetchImageVM(fetchImageRequestData: FetchImageRequestData(networkManager: NetworkManager()))
    var count: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // press the button to fetch image
    @IBAction func fetchImage(_ sender: Any) {
        self.fetchImageVM.fetchImage(sender: self,comletion: {[weak self] (data, error) in
                DispatchQueue.main.async {
                    Log.queue(action: "setting image on ui")
                    guard let imageData = data else {return}
                    self?.dogImage.image = UIImage(data: imageData[0])
                }
                
              })
    }
    // press the button to increase count
    @IBAction func increaseCount(_ sender: Any) {
        
        self.count = self.count + 1
        self.countlbl.text = String(self.count)
        
        let name: String? = nil
        print("optional value---- \(self.fetchImageVM.optinalWrapping(str: name))")
    }
    
    deinit {
        print("fetch image VC deallocated")
    }
}

