//
//  NumberSection.swift
//  RxTableSome
//
//  Created by Ievgen Keba on 1/30/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import Foundation
import RxDataSources
import UIKit

// MARK: Data

struct NumberSection {
    var header: String
    
    var numbers: [IntItem]
    
    init(header: String, numbers: [Item]) {
        self.header = header
        self.numbers = numbers
    }
}

struct IntItem {
    var comment: Comments
    let user: Users
    let cars: Cars
}

struct Comments {
    let id: String
    let user: Users
    let createdAt: String
    let commentText: String
    var numberOfLike: Int
    let cardID: String
    var userDidLike: Bool
}
struct Users {
    let id: String
    let fullName: String
    let email: String
    let profileImage: UIImage
    let cardID: [String]
}
struct Cars {
    let name: String
    let description: String
    let numberOfComments: Int
    let image: UIImage
}

// MARK: Just extensions to say how to determine identity and how to determine is entity updated
extension NumberSection: AnimatableSectionModelType {
    typealias Item = IntItem
    typealias Identity = String
    
    var identity: String {
        return header
    }
    var items: [IntItem] {
        return numbers
    }
    init(original: NumberSection, items: [Item]) {
        self = original
        self.numbers = items
    }
}

extension IntItem: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return comment.id
    }
}
// equatable, this is needed to detect changes
func == (lhs: IntItem, rhs: IntItem) -> Bool {
    return lhs.cars == rhs.cars && lhs.comment == rhs.comment && lhs.user == rhs.user
    
}

extension NumberSection: Equatable {
}
func == (lhs: NumberSection, rhs: NumberSection) -> Bool {
    return lhs.header == rhs.header && lhs.items == rhs.items
}
extension Users: IdentifiableType, Equatable {
    typealias Identity = String
    var identity: String {
        return id
    }
    init(id: String = "", fullName: String = "", cardID: [String] = [String](), profileImage: UIImage = UIImage(named: "account")!, email: String = "") {
        self.id = id
        self.fullName = fullName
        self.cardID = cardID
        self.email = email
        self.profileImage = profileImage
    }
    
}
func == (lhs: Users, rhs: Users) -> Bool {
    return lhs.cardID == rhs.cardID && lhs.email == rhs.email && lhs.fullName == rhs.fullName && lhs.id == rhs.id && lhs.profileImage == rhs.profileImage
}
extension Cars: IdentifiableType, Equatable {
    typealias Identity = String
    var identity: String {
        return name
    }
    init(name: String = "", description: String = "", image: UIImage = UIImage(named: "account")!, numberOfComments: Int = 0) {
        self.description = description
        self.image = image
        self.name = name
        self.numberOfComments = numberOfComments
        
    }
}
func == (lhs: Cars, rhs: Cars) -> Bool {
    return lhs.description == rhs.description && lhs.image == rhs.image && lhs.numberOfComments == rhs.numberOfComments && lhs.name == rhs.name
}
extension Comments: IdentifiableType, Equatable {
    typealias Identity = String
    var identity: String {
        return id
    }
    init(user: Users = Users(id: "", fullName: "", email: "", profileImage: UIImage(named: "account")!, cardID: []), createdAt: String = "", commentText: String = "", numberOfLike: Int = 0, cardID: String = "", id: String = "", userDidLike: Bool = false) {
        self.cardID = cardID
        self.commentText = commentText
        self.createdAt = createdAt
        self.numberOfLike = numberOfLike
        self.user = user
        self.id = id
        self.userDidLike = userDidLike
    }
}
func == (lhs: Comments, rhs: Comments) -> Bool {
    return lhs.cardID == rhs.cardID && lhs.commentText == rhs.commentText && lhs.createdAt == rhs.createdAt && lhs.id == rhs.id && lhs.numberOfLike == rhs.numberOfLike && lhs.user == rhs.user && lhs.userDidLike == rhs.userDidLike
}

