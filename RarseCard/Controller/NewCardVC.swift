//
//  NewCardVC.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/10/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewCardVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var cardDescription: UITextView!
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var closeBtn: UIBarButtonItem!
    @IBOutlet weak var addCard: UIBarButtonItem!
    
    let dis = DisposeBag()
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardTextField.becomeFirstResponder()
        cardTextField.delegate = self
        
        cardDescription.rx.didBeginEditing.bindNext {self.cardDescription.text = ""}.addDisposableTo(dis)
        cardDescription.rx.didEndEditing.bindNext {
            if self.cardDescription.text.isEmpty {
                self.cardDescription.text = "Description"
            }
            }.addDisposableTo(dis)
        
        closeBtn.rx.tap.bindNext {
            if self.cardTextField.isFirstResponder {
                self.cardTextField.resignFirstResponder()
            } else if self.cardDescription.isFirstResponder {
                self.cardDescription.resignFirstResponder()
            }
            self.dismiss(animated: true, completion: nil)
            }.addDisposableTo(dis)
        
        addCard.rx.tap.bindNext {
            
            if self.cardTextField.isFirstResponder {
                self.cardTextField.resignFirstResponder()
            } else if self.cardDescription.isFirstResponder {
                self.cardDescription.resignFirstResponder()
            }
            self.dismiss(animated: true, completion: nil)
            }.addDisposableTo(dis)
        
        // push selectImageBtn
        selectImageBtn.rx.tap.asObservable().subscribe(onNext: {
            DefaultWireframe.sharedInstance.promptFor("Where do u want to get your pic from?", controller: self, cancelAction: "Cancel", actions: ["Photo From Library", "Photo From Camera"]).subscribe(onNext: { pic in
                switch pic {
                case "Photo From Library":
                    self.imagePicker.sourceType = .photoLibrary
                    self.present(self.imagePicker, animated: true, completion: nil)
                case "Photo From Camera":
                    self.imagePicker.sourceType = .camera
                    self.present(self.imagePicker, animated: true, completion: nil)
                default: break
                }
            }).addDisposableTo(self.dis)
        }).addDisposableTo(dis)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension NewCardVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !textField.text!.isEmpty {
            cardTextField.becomeFirstResponder()
        } else if cardTextField.text!.isEmpty {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension NewCardVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
