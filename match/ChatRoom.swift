//
//  ChatRoom.swift
//  match
//
//  Created by 樋口裕貴 on 2021/08/31.
//

import Foundation
import Firebase

class ChatRoom {
    
    let latestMessageId:String
    let members:[String]
    let createdAt: Timestamp
    
    var latestMessage: Message?
    var documentId: String?
    var partnerUser: User?
    
    init(dic: [String: Any]) {
        self.latestMessageId = dic["latestMessageId"] as? String ?? ""
        self.members = dic["members"] as? [String] ?? [String]()
        self.createdAt = dic["createdAt"] as? Timestamp ?? Timestamp()
    }
    
}
