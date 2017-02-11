//
//  NewCommentVC.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/9/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewCommentVC: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var closer: UIBarButtonItem!
    @IBOutlet weak var add: UIBarButtonItem!
    
    let dis = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.becomeFirstResponder()
        commentTextView.text = ""
        
        closer.rx.tap.bindNext {
            self.commentTextView.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
            }.addDisposableTo(dis)
        
        add.rx.tap.bindNext {
            self.commentTextView.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
            }.addDisposableTo(dis)
        
        NotificationCenter.default.rx.notification(.UIKeyboardWillHide)
            .subscribe(onNext: { _ in
                self.commentTextView.contentInset = UIEdgeInsets.zero
                self.commentTextView.scrollIndicatorInsets = UIEdgeInsets.zero
            }).addDisposableTo(dis)
        
        NotificationCenter.default.rx.notification(.UIKeyboardWillShow)
            .subscribe(onNext: {notification in
                let userInfo = notification.userInfo ?? [:]
                let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
                self.commentTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height + 20.0), right: 0)
                self.commentTextView.scrollIndicatorInsets = self.commentTextView.contentInset
            }).addDisposableTo(dis)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
