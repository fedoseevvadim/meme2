//
//  MemeDetailViewController.swift
//  MeMe
//
//  Created by Вадим Федосеев on 12.09.2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var memeStruct: MemeStruct.Memes!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.detailImage!.image = self.memeStruct.memeImage
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
}
