//
//  ViewController.swift
//  Instagrid
//
//  Created by Elodie-Anne Parquer on 10/06/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var bottomRightView: UIView!
    
    @IBOutlet var addPictureButtons: [UIButton]!
    
    @IBOutlet var pictureImageViews: [UIImageView]!
    
    @IBOutlet weak var gridView: UIView!
    
    var tag: Int?
    var swipeGesture : UISwipeGestureRecognizer?
    
    // MARK: - Actions
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        layoutButtons.forEach { $0.isSelected = false }
        sender.isSelected = true
        
        switch sender.tag {
        case 0:
          topRightView.isHidden = true
            bottomRightView.isHidden = false
        case 1:
            bottomRightView.isHidden = true
            topRightView.isHidden = false
        case 2 :
            topRightView.isHidden = false
            bottomRightView.isHidden = false
        default:
            break
        }
    }
    
    @IBAction func addPictureButtonTapped(_ sender: UIButton) {
        tag = sender.tag
        choosePictures()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeGesture = UISwipeGestureRecognizer (target: self, action: #selector(shareSwipeAction))
        guard let swipeGesture = swipeGesture else {return}
        gridView.addGestureRecognizer(swipeGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil) 

    }
    
    @objc func setUpSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
           swipeGesture?.direction = .left
        } else {
            swipeGesture?.direction = .up
        }
    }
    
    @objc func shareSwipeAction() {
        print("swipe ok")
    }
    
    
    
    func choosePictures(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let alert = UIAlertController(title: "Choose picture", message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Library Picture", style: .default, handler: { (action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert,animated: true, completion: nil)
        
    }

    @objc func choosePictureWithTap (gesture : UITapGestureRecognizer) {
       tag = gesture.view?.tag
       choosePictures()
        
    }

}

// MARK: - UIImagePickerControllerDelegate
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pictureSelected = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        guard let tag = tag else {return}
        pictureImageViews[tag].image = pictureSelected
        addPictureButtons[tag].isHidden = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePictureWithTap(gesture:)))
        pictureImageViews[tag].addGestureRecognizer(tapGestureRecognizer)
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
