//
//  MemeCollectionViewController.swift
//  MeMe
//
//  Created by Вадим Федосеев on 08.09.2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var memesStruct: [MemeStruct.Memes]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = AppModel.titleCollection
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.memesStruct = appDelegate.memes
        
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memesStruct.count
    }
    
    func setUpTextFields(textField: UITextField, withText text: String) {
        
        textField.text = text
        textField.defaultTextAttributes = AppModel.memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self as? UITextFieldDelegate
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppModel.memeCell, for: indexPath) as! TableMemeCell
        let meme = self.memesStruct[(indexPath as NSIndexPath).row]
        
        //setUpTextFields(textField: cell.TopText, withText: meme.topText as String)
        //setUpTextFields(textField: cell.BottomText, withText: meme.bottomText as String)
        
        cell.ImageView?.image   = meme.memeImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: AppModel.detailVC) as! MemeDetailViewController

        detailController.memeStruct = memesStruct[(indexPath as NSIndexPath).row]
        
        navigationController!.pushViewController(detailController, animated: true)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memesStruct = appDelegate.memes
        collectionView?.reloadData()
        
    }
}


extension MemeCollectionViewController: UITextFieldDelegate {
    
    func setUpTextFields(textField: UITextField, string: String) {
        
        textField.defaultTextAttributes = AppModel.memeTextAttributes
        textField.text = string
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self;
        
    }
    
}
