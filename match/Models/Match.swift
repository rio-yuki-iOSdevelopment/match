//
//  Match.swift
//  match
//
//  Created by 樋口裕貴 on 2021/09/17.
//

import UIKit
import Firebase

class Match: NSObject {

    let members:[String]
    let memberNames:[String]
    let memberProfileImages:[String]
    let createdAt: Timestamp
    
    var documentId: String?
    var partnerUser: User?
    
    init(dic: [String: Any]) {
        self.members = dic["members"] as? [String] ?? [String]()
        self.memberNames = dic["memeberNames"] as? [String] ?? [String]()
        self.memberProfileImages = dic["memebersProfileImages "] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
}
