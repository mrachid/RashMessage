//
//  ChatMessage.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import UIKit

public protocol MessageType {
    
    var sender: Sender { get }
    
    var messageId: Int { get }
    
    var createdAt: Date { get }
    
    var kind: MessageKind { get }
    
    var isIncomming: Bool { get }
    
}


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



public protocol MediaItem {

    var url: URL? { get }
    var image: UIImage? { get }
}


private struct MugiMediaItem: MediaItem {

    var url: URL?
    var image: UIImage?

    init(image: UIImage) {
        self.image = image
    }
}



public struct Sender {

    public let id: Int
    public let displayName: String

    public init(id: Int, displayName: String) {
        self.id = id
        self.displayName = displayName
    }
}

public enum MessageKind {
    case text(String)
    case photo(MediaItem)
}

public class MugiMessage {//: MessageType {
    var messageId: Int = 0
    var sender: Sender
    var createdAt: Date
    var kind: MessageKind
    var isIncomming: Bool

    public init(kind: MessageKind, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.createdAt = createdAt
        self.isIncomming = isIncomming
    }

    convenience init(text: String, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, createdAt: createdAt, isIncomming: isIncomming)
    }

    convenience init(image: UIImage, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        let mediaItem = MugiMediaItem(image: image)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, createdAt: createdAt, isIncomming: isIncomming)
    }

}
