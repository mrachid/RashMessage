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
    
    let simpleDataText = [
        "It's ok for me",
        "lol, is a joke right? tell the truth",
        "1-800-555-0000",
        "One Infinite Loop Cupertino, CA 95014 This is some extra text that should not be detected.",
        "This is an example of the date detector 11/11/2017. April 1st is April Fools Day. Next Friday is not Friday the 13th.",
        "https://github.com/SD10",
        "Check out this awesome UI library for Chat",
        "My favorite things in life don’t cost any money. It’s really clear that the most precious resource we all have is time.",
        """
            You know, this iPhone, as a matter of fact, the engine in here is made in America.
            And not only are the engines in here made in America, but engines are made in America and are exported.
            The glass on this phone is made in Kentucky. And so we've been working for years on doing more and more in the United States.
            """,
        """
            Remembering that I'll be dead soon is the most important tool I've ever encountered to help me make the big choices in life.
            Because almost everything - all external expectations, all pride, all fear of embarrassment or failure -
            these things just fall away in the face of death, leaving only what is truly important.
            """,
        "I think if you do something and it turns out pretty good, then you should go do something else wonderful, not dwell on it for too long. Just figure out what’s next.",
        "Price is rarely the most important thing. A cheap product might sell some units. Somebody gets it home and they feel great when they pay the money, but then they get it home and use it and the joy is gone."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        config = setupConfigChat()
        mugiMessages = [
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
            
            
            
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "ludovico_einaudi")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "SJ")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "TC")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "ludovico_einaudi")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "SJ")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "ludovico_einaudi")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "SJ")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
//            MugiMessage(image: UIImage(named: "TC")! , sender: Sender(id: 1, displayName: "Mahmoud"), messageId: 1, createdAt: Date(), isIncomming: randomBool()),
        ]
        
        

    
    }
    
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    @IBAction func addMessageTest(_ sender: Any) {
        newMessage(message:  MugiMessage(text: simpleDataText[(Int(arc4random_uniform(UInt32(11))))], sender: Sender(id: 1, displayName: "Mahmoud", avatar: UIImage(named: "SJ")!), messageId: 1, createdAt: Date(), isIncomming: randomBool()))
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
        
        options.messageTextDateColorIsNotComming = UIColor.lightGray
        
        options.headerTextColor = UIColor.gray
        options.headerBackgroundColor = UIColor.red
        
        return options
    }
    
}

