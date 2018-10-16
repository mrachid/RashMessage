//
//  ViewController.swift
//  RashMessage
//
//  Created by mrachid on 09/10/2018.
//  Copyright (c) 2018 mrachid. All rights reserved.
//

import UIKit
import RashMessage

class ViewController: MessageViewController {
    
    let titi = [
        ChatMessage(id: 1, text: "NON 1", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: true),
        ChatMessage(id: 1, text: "NON 2", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: true),
        ChatMessage(id: 1, text: "NON 3", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: true),
        ChatMessage(id: 1, text: "NON 4", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: true),
    ]
    let toto = [
        ChatMessage(id: 1, text: "Ceci est mon premier message", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "13/08/2018"), isIncomming: true),
        ChatMessage(id: 2, text: "Ceci est mon second message, et je vais ecrire beaucoup plus de chose afin de voir le nombre de ligne affiché", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "13/08/2018"), isIncomming: false),
        ChatMessage(id: 3, text: "Et voici mon 3eme message avec un petit smiley!! 😀", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "14/08/2018"), isIncomming: false),
        ChatMessage(id: 4, text: "Nice!!!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "14/08/2018"), isIncomming: false),
        ChatMessage(id: 5, text: "Message qui doit s'afficher sur le coté gauche du chat avec un fond blanc", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "14/08/2018"), isIncomming: true),
        ChatMessage(id: 6, text: "Troisieme section de message", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "15/08/2018"), isIncomming: false),
        ChatMessage(id: 7, text: "Voici le premier message ecrit dans la 4eme section", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: false),
        ChatMessage(id: 8, text: "Bienvenue à l'équipe de charlatan", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: false),
        ChatMessage(id: 9, text: "Je vous souhaite d'heureuse fete et plein de bonne chose et oui j'écrit des choses qui on un sens pour des test mouahahhaa!!!!!!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: false),
        ChatMessage(id: 10, text: "Mouaiiis..sdfsdfsdf..!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "fdsfdsfdsf....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "Mouaiiissdfsdfsdfdsfdsfdsfdsf....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "fmldsjfldsjflkjsdnflkjdsnflkjdsnflkjndslfkjdslkjfbndslkjhf....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "sfdlmnsdf....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "mslfjmlksdjfmsdjfmlkdsjflmkds....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "Mouasdmfklndsmlkfjsdmlkfjmsdljfmldskjfmldsjfmlsdjfmlkdsjfmldsjfmlsdjfsdffjmsdfjiiis....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "16/08/2018"), isIncomming: true),
        ChatMessage(id: 10, text: "fdsfdsfdsfdsfdsfsdfsdfldshjflsdjhfkjsdhflkjshdflkqsdhflksdhflkqsjhfl....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: false),
        ChatMessage(id: 10, text: "dfslkjlsdkjfkldsjfkldsjfkljdsklfjds....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: false),
        ChatMessage(id: 10, text: "Modsfdslkfdslkfjdskfjkldsjfklsdjflkjdslkfjdslkfjlksdnfljksdnfljksdnflksdjflkjsdfuaiiis....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "17/08/2018"), isIncomming: false),
        ChatMessage(id: 10, text: "sdlkfjlsdkfjsdlkfjsdlkfjsd....!", from: nil, avatar: nil, createdAt: Date.dateFromCustomString(customString: "18/08/2018"), isIncomming: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        config = setupConfigChat()
        messages = toto
    }
    
    @IBAction func addMessageTest(_ sender: Any) {
        let randomIndex = Int(arc4random_uniform(UInt32(titi.count)))
        newMessage(message: titi[randomIndex])
        
    }
    
    private func setupConfigChat() -> MessageConfiguration {
        var options = MessageConfiguration()
        options.sendButtonText = "Send"
        options.sendButtonTextColor = UIColor.red
        options.sendButtonBackgroundColor = UIColor.gray
        options.sendButtonIsImage = false
        
        options.placeholderTextView = "Write message ..."
        options.backgroundTextView = UIColor.red
        options.borderTextView = UIColor.blue.cgColor
        options.textColorTextView = UIColor.blue
        
        options.isLargeTitle = true
        options.titlePage = "Message"
        options.chatBackgroundColor = UIColor.red
        
        options.messageBackgroundColorIsComming = UIColor.white
        options.messageBorderColorIsComming = UIColor.gray
        options.messageTextColorIsComming = UIColor.black
        
        options.messageBackgroundColorIsNotComming = UIColor.gray
        options.messageBorderColorIsNotComming = UIColor.gray
        options.messageTextColorIsNotComming = UIColor.black
        
        options.messageTextDateColor = UIColor.lightGray
        
        options.headerTextColor = UIColor.gray
        options.headerBackgroundColor = UIColor.red
        
        return options
    }
    
}

