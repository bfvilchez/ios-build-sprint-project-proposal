//
//  AddMemoryViewController.swift
//  Pixels
//
//  Created by brian vilchez on 3/3/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit
import Photos
import CoreImage
import CoreImage.CIFilterBuiltins

class AddMemoryViewController: UIViewController {
    
    @IBOutlet weak var polaroidView: UIView!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var memoryDesciption: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    
    var pixelController:PixelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentMediaOptions()
    }
    
    @IBAction func publishButtonTapped(_ sender: UIButton) {
        guard let image = pickedImage.image, let text = memoryDesciption.text, let name = nameTextField.text, !name.isEmpty else { return }
        pixelController?.createImage(WithName: name, image: image, pictureDescription: text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func photoTapGesture(_ sender: Any) {
        //checkPhotoAuthorization()
        presentMediaOptions()
    }
    
    
    //MARK: - helper methods
//
//    private func checkPhotoAuthorization() {
//        PHPhotoLibrary.requestAuthorization { (status) in
//            switch status {
//            case .notDetermined:
//                print("failed to get permission")
//            case .restricted:
//                print("failed to get permission")
//            case .denied:
//                print("failed to get permission")
//            case .authorized:
//                self.presentMediaOptions()
//            @unknown default:
//                return
//            }
//        }
//    }
//
    private func configureViews() {
        polaroidView.backgroundColor = .white
        nameTextField.isHidden = true
        memoryDesciption.isHidden = true
        publishButton.isHidden = true
    }
    
    // types of media that can be presented.
    private func photoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func camera(){
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func imageFilter() {
        
    }
    
    // presents media options
    private func presentMediaOptions() {
        let alertVC = UIAlertController(title: "Media", message: "choose type of Media", preferredStyle: .alert)
        let camera = UIAlertAction(title: "camera", style: .default) { (_) in
            self.camera()
        }
        let photoLibrary = UIAlertAction(title: "photo Library", style: .default) { (_) in
            self.photoLibrary()
        }
        let cancel = UIAlertAction(title: "cancel", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertVC.addAction(camera)
        alertVC.addAction(photoLibrary)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension AddMemoryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        pickedImage.image = image
        picker.dismiss(animated: true) {
            self.polaroidView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            self.nameTextField.isHidden = false
            self.memoryDesciption.isHidden = false
            self.publishButton.isHidden = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
