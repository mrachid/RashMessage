
//
//  MessageTableViewCell.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let messageDateLabel = UILabel()
    let bubbleBackgroundView = UIView()
    let errorSend = UIButton()
    var config: MessageConfiguration!

    var leadingConstraintMessageLabel: NSLayoutConstraint!
    var trailingConstraintMessageLabel: NSLayoutConstraint!
    var leadingConstraintMessageDateLabel: NSLayoutConstraint!
    var trailingConstraintMessageDateLabel: NSLayoutConstraint!
    var bottomConstraintMessageLabel: NSLayoutConstraint!
    
    var trailingConstraintErrorSend: NSLayoutConstraint!
    var leadingConstraintErrorSend: NSLayoutConstraint!
    
    var chatMessage: ChatMessage! {
        didSet {

            bubbleBackgroundView.backgroundColor = chatMessage.isIncomming ? config.messageBackgroundColorIsComming : config.messageBackgroundColorIsNotComming
            bubbleBackgroundView.layer.borderColor = chatMessage.isIncomming ? config.messageBorderColorIsComming.cgColor : config.messageBorderColorIsNotComming.cgColor
            bubbleBackgroundView.layer.borderWidth = 1
            messageLabel.textColor = chatMessage.isIncomming ? config.messageTextColorIsComming : config.messageTextColorIsNotComming
            messageLabel.text = chatMessage.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM"
            let dateString = dateFormatter.string(from: chatMessage.createdAt)

            messageDateLabel.text = dateString
            messageDateLabel.textColor = config.messageTextDateColor
            messageDateLabel.font = UIFont.systemFont(ofSize: 12)
            backgroundColor = .clear
            bubbleBackgroundView.layer.cornerRadius = 16
            
            if chatMessage.isIncomming {
                leadingConstraintMessageLabel.isActive = true
                trailingConstraintMessageLabel.isActive = false
                
                leadingConstraintMessageDateLabel.isActive = true
                trailingConstraintMessageDateLabel.isActive = false
                
                trailingConstraintErrorSend.isActive = false
                leadingConstraintErrorSend.isActive = true
                
                messageDateLabel.textAlignment = .left
            } else {
                leadingConstraintMessageLabel.isActive = false
                trailingConstraintMessageLabel.isActive = true
                
                leadingConstraintMessageDateLabel.isActive = false
                trailingConstraintMessageDateLabel.isActive = true
                
                trailingConstraintErrorSend.isActive = true
                leadingConstraintErrorSend.isActive = false
                
                messageDateLabel.textAlignment = .right
            }
        }

    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trailingConstraintMessageLabel.isActive = false
        leadingConstraintMessageLabel.isActive = false
        leadingConstraintMessageDateLabel.isActive = false
        trailingConstraintMessageDateLabel.isActive = false
        bottomConstraintMessageLabel.isActive = false
        trailingConstraintErrorSend.isActive = false
        leadingConstraintErrorSend.isActive = false
        
    }
    
    func configureUI(valueBottomConstant: CGFloat, displayDate: Bool) {
        self.selectionStyle = .none  
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        errorSend.translatesAutoresizingMaskIntoConstraints = false
        errorSend.setImage(ImagesHelper.loadImage(name: "exclamation"), for: .normal)
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        addSubview(messageDateLabel)
        addSubview(errorSend)
        errorSend.isHidden = true
        
        
        messageLabel.numberOfLines = 0
        
        if displayDate {
            bottomConstraintMessageLabel = messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42)
            messageDateLabel.alpha = 1
        } else {
            bottomConstraintMessageLabel = messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: valueBottomConstant)
            messageDateLabel.alpha = 0
        }
        
        bottomConstraintMessageLabel.isActive = true
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            
            messageDateLabel.topAnchor.constraint(equalTo: bubbleBackgroundView.bottomAnchor),
            messageDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            
            errorSend.widthAnchor.constraint(equalToConstant: 20),
            errorSend.heightAnchor.constraint(equalToConstant: 20),
            errorSend.centerYAnchor.constraint(equalTo: bubbleBackgroundView.centerYAnchor, constant: 0)
            
            ]
        
        NSLayoutConstraint.activate(constraints)
       
        
        trailingConstraintErrorSend = errorSend.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -10)
        leadingConstraintErrorSend = errorSend.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 10)
        
        
        leadingConstraintMessageLabel = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraintMessageLabel = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        leadingConstraintMessageDateLabel = messageDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trailingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
