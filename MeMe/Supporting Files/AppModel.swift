//
//  AppModel.swift
//  MeMe
//
//  Created by Vadim on 27/08/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit


struct AppModel {
    
    static let topTextField             = "TOP"
    static let bottomTextFiled          = "BOTTOM"
    static let titleCollection          = "Saved Memes"
    static let titleTableViewController = "Saved Memes"
    
    static let memeCell = "MemeCell"
    static let detailVC  = "DetailViewController"
    
    struct alert {
        
        static let alertTitle   = "Discard"
        static let alertMessage = "Are you sure you want to discard your changes?"
    }
    
    static let memeTextAttributes:[String: Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -3.0]
    
}
