//
//  CommentCell.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/8/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var commentTextLbl: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    let dis = DisposeBag()
    
    var comment: IntItem? {
        didSet{
            userNameLbl.text = comment?.comment.user.fullName
            createdAtLbl.text = comment?.comment.createdAt
            commentTextLbl.text = comment?.comment.commentText
            userImageView.image = comment?.comment.user.profileImage
            
            userImageView.layer.cornerRadius = userImageView.bounds.width/2
            userImageView.clipsToBounds = true
            likeButton.setTitle("❤️ \(comment!.comment.numberOfLike) likes", for: .normal)
            
            likeButton.rx.tap.subscribe(onNext: {
                if self.comment!.comment.userDidLike {
                    self.likeButton.tintColor = UIColor.red
                } else {
                    self.likeButton.tintColor = UIColor.lightGray
                }
            }).addDisposableTo(dis)
        }
    }
    
    @IBAction func likesBtn(_ sender: UIButton) {
        comment?.comment.userDidLike = !(comment?.comment.userDidLike)!
        if (comment?.comment.userDidLike)! {
            comment?.comment.numberOfLike += 1
        } else {
            comment?.comment.numberOfLike -= 1
        }
        likeButton.setTitle("❤️ \(comment!.comment.numberOfLike) likes", for: .normal)
    }
}
