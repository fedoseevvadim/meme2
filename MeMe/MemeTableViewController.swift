//
//  MemeTableViewController.swift
//  MeMe
//
//  Created by Вадим Федосеев on 11.09.2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memeStruct: [MemeStruct.Memes]!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.title = AppModel.titleTableViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memeStruct = appDelegate.memes
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memeStruct.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: AppModel.detailVC) as!  MemeDetailViewController
        detailController.memeStruct = self.memeStruct[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppModel.memeCell)!
        let meme = self.memeStruct[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = meme.topText + " - " + meme.bottomText
        cell.imageView?.image = meme.memeImage
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {

            memeStruct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memeStruct = appDelegate.memes
        tableView.reloadData()
        
        
    }
    
}
