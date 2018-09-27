//
//  MessageConfiguration.swift
//  Pods-RashMessage_Example
//
//  Created by Rachid Mahmoud on 25/09/18.
//

import UIKit

public struct MessageConfiguration {
    
    public init(){}
    
    public var sendButtonText: String = "Send"
    public var sendButtonTextColor: UIColor = UIColor(red: 221/255, green: 94/255, blue: 100/255, alpha: 1)
    public var sendButtonBackgroundColor: UIColor = .clear
    public var sendButtonIsImage: Bool = false
    
    public var placeholderTextView: String = "Write message ..."
    public var backgroundTextView: UIColor = .white
    public var borderTextView: CGColor = UIColor(white: 0.8, alpha: 1).cgColor
    public var textColorTextView: UIColor = .darkGray
    
    public var isLargeTitle: Bool = true
    public var titlePage: String = "Message"
    public var chatBackgroundColor: UIColor = .white
    
    public var messageBackgroundColorIsComming: UIColor = UIColor(white: 0.95, alpha: 1)
    public var messageBorderColorIsComming: UIColor = .clear
    public var messageTextColorIsComming: UIColor = .darkGray
    
    public var messageBackgroundColorIsNotComming: UIColor = UIColor(red: 221/255, green: 94/255, blue: 100/255, alpha: 1)
    public var messageBorderColorIsNotComming: UIColor = .clear
    public var messageTextColorIsNotComming: UIColor = .white
    
    public var messageTextDateColor: UIColor = .lightGray
    
    public var headerTextColor: UIColor = UIColor(red: 221/255, green: 94/255, blue: 100/255, alpha: 1)
    public var headerBackgroundColor: UIColor = .white
    
}
