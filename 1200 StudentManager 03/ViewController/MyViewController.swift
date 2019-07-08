//
//  MyViewController.swift
//  1200 StudentManager 03
//
//  Created by Trương Quang on 7/8/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

protocol addInforStudentToList: class {
    func addInforStudentToListDelegate(with data: InforStudent)
}

class MyViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var address: UITextField!
    
    var inforStudent: InforStudent?
    
    weak var delegate: addInforStudentToList?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillInfor()
        
        imagePicker.delegate = self
        
        image.isUserInteractionEnabled = true
        let tapGestune = UITapGestureRecognizer(target: self, action: #selector(addPhoto))
        image.addGestureRecognizer(tapGestune)
    }
    
    func fillInfor() {
        image.image = inforStudent?.image ?? UIImage(named: "nophoto")
        
        if let inforStudent = inforStudent {
            image.image = inforStudent.image
            name.text = inforStudent.name
            phoneNumber.text = inforStudent.phoneNumber
            address.text = inforStudent.address
        }
        
        image.layer.cornerRadius = image.frame.width / 2
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
        image.layer.masksToBounds = true
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func addPhoto() {
        let alertController = UIAlertController(title: "Choose from", message: nil, preferredStyle: .actionSheet)
        
        // from camera
        let fromCamera = UIAlertAction (title: "From camera", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraCaptureMode = .photo
                self.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                self.showAlert(message: "Divice is not support for camera")
            }
        }
        
        // from library
        let fromLibrary = UIAlertAction(title: "From library", style: .default) { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        // cancel
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(fromCamera)
        alertController.addAction(fromLibrary)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let valueImage = self.image.image ?? UIImage(named: "nophoto")
        guard let name = self.name.text?.trimmingCharacters(in: .whitespacesAndNewlines), let phoneNumber = self.phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        let valueAddress = address.text
        let inforStudent = InforStudent(image: valueImage, name: name, phoneNumber: phoneNumber, address: valueAddress)
        if !name.isEmpty && !phoneNumber.isEmpty {
            delegate?.addInforStudentToListDelegate(with: inforStudent)
        } else {
            showAlert(message: "You must fill name and phone number")
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let choose = info [UIImagePickerController.InfoKey.originalImage] as! UIImage
        image.image = choose
        dismiss(animated: true, completion: nil)
    }
}
