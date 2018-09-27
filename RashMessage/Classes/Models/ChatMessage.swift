//
//  ChatMessage.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import Foundation

open class ChatMessage {
    var id: Int
    var text: String
    var from: String?
    var avatar: String?
    var createdAt: Date
    var isIncomming: Bool

    public init(id: Int, text: String, from: String?, avatar: String?, createdAt: Date, isIncomming: Bool) {
        self.id = id
        self.text = text
        self.from = from
        self.avatar = avatar
        self.createdAt = createdAt
        self.isIncomming = isIncomming
    }
}
