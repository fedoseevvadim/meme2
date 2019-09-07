//
//  MemeMeViewController.swift
//  MeMe
//
//  Created by Vadim on 14/08/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit

class MemeMeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: IBoutlets
    //@IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var navBar: UIToolbar!
    
    
    // MARK: Functions
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpTextFields(textField: topTextField, string: AppModel.topTextField)
        setUpTextFields(textField: bottomTextField, string: AppModel.bottomTextFiled)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        initView()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    //MARK: Keyboards Related Methods
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
        
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextField.isFirstResponder {
            
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        view.frame.origin.y = 0
    }
    
    // MARK: UIImagePickerController Functions
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        presentImagePickerWith(sourceType: UIImagePickerControllerSourceType.camera)
    }
    
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        
        //To pick an image from Photos Albums
        presentImagePickerWith(sourceType: UIImagePickerControllerSourceType.photoLibrary)
        
    }
    
    
    // MARK: UIImagePickerController Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // To select an image and set it to imageView
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imagePickerView.image = image
            self.view.layoutIfNeeded()
            //            setZoomScaleForImage(scrollViewSize: scrollView.bounds.size)
            //            scrollView.zoomScale = scrollView.minimumZoomScale
            //            centerImage()
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // To dismiss imagePicker when cancel button is clicked
        dismiss(animated: true, completion: nil)
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion:nil)
        
    }
    
    func initView() {
        
        // enable or disable the share button
        if let _ = imagePickerView.image {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
        // Enable or disable camera bar button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
    }
    
}

extension MemeMeViewController: UITextFieldDelegate {
    
    func setUpTextFields(textField: UITextField, string: String) {
        
        textField.defaultTextAttributes = AppModel.memeTextAttributes
        textField.text = string
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self;
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == topTextField && textField.text == AppModel.topTextField {
            textField.text = ""
        } else if textField == bottomTextField && textField.text == AppModel.bottomTextFiled {
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Allows the user to use the return key to hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //To set default text if textfields text is empty
        if textField == topTextField && textField.text!.isEmpty {
            
            textField.text = AppModel.topTextField
            
        } else if textField == bottomTextField && textField.text!.isEmpty {
            
            textField.text = AppModel.bottomTextFiled
        }
    }
    
    //MARK: Generating meme Objects
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = MemeStruct.Memes(topText: topTextField.text!, bottomText: bottomTextField.text!,  image: imagePickerView.image, memeImage: memedImage)
        
        (UIApplication.shared.delegate as!
            AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        showHideNavBar(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        showHideNavBar(false)
        
        return memedImage
        
    }
    
    func showHideNavBar (_ showHide: Bool) {
        navBar.isHidden = showHide
        toolBar.isHidden = showHide
    }
    
    //MARK: Top Bar Button Actions
    
    @IBAction func shareAction (_ sender: AnyObject) {
        
        let memedImage = generateMemedImage()
        
        let shareActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        shareActivityViewController.completionWithItemsHandler = { activity, completed, items, error in
            
            if completed {
                
                //save the image
                self.save(memedImage: memedImage)
                
                //Dismiss the shareActivityViewController
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
        present(shareActivityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //    @IBAction func cancelAction (_ sender: AnyObject) {
    //
    //        if imagePickerView.image != nil {
    //
    //            let alert = UIAlertController(title: AppModel.alert.alertTitle , message: AppModel.alert.alertMessage, preferredStyle: .alert)
    //
    //            let yes = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
    //
    //                self.imagePickerView.image = nil
    //                self.topTextField.text = AppModel.topTextField
    //                self.bottomTextField.text = AppModel.bottomTextFiled
    //                self.shareButton.isEnabled = false
    //            }
    //
    //            let no  = UIAlertAction(title: "No", style: .default, handler: nil)
    //
    //            alert.addAction(yes)
    //            alert.addAction(no)
    //
    //            self.present(alert, animated: true, completion: nil)
    //        }
    //    }
    
}
