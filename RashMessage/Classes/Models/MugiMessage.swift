//
//  MugiMessage.swift
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

public protocol MediaItem {

    var url: URL? { get }
    var image: UIImage? { get }
}

private struct MugiMediaItem: MediaItem {

    var url: URL?
    var image: UIImage?

    init(image: UIImage?) {
        self.image = image
    }
}

public protocol DocItem {
    
    var url: URL? { get }
    var name: String? { get }
}

private struct MugiDocItem: DocItem {
    
    var url: URL?
    var name: String?
    
    init(url: URL?, name: String) {
        self.url = url
        self.name = name
    }
}

public struct Sender {

    public let id: Int
    public let displayName: String
    public let avatar: UIImage?

    public init(id: Int, displayName: String, avatar: UIImage?) {
        self.id = id
        self.displayName = displayName
        self.avatar = avatar
    }
}

public enum MessageKind {
    case text(String)
    case photo(MediaItem)
    case doc(DocItem)
}

public class MugiMessage {
    var messageId: Int = 0
    var sender: Sender
    var createdAt: Date
    var kind: MessageKind
    var isIncomming: Bool

    private init(kind: MessageKind, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.createdAt = createdAt
        self.isIncomming = isIncomming
    }

    public convenience init(text: String, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, createdAt: createdAt, isIncomming: isIncomming)
    }

    public convenience init(image: UIImage?, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        let mediaItem = MugiMediaItem(image: image)
        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, createdAt: createdAt, isIncomming: isIncomming)
    }

    public convenience init(url: URL?, name: String, sender: Sender, messageId: Int, createdAt: Date, isIncomming: Bool) {
        let docItem = MugiDocItem(url: url, name: name)
        self.init(kind: .doc(docItem), sender: sender, messageId: messageId, createdAt: createdAt, isIncomming: isIncomming)
    }

}
