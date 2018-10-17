
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
            messageLabel.font = UIFont.systemFont(ofSize: 16)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: chatMessage.createdAt)

            messageDateLabel.text = dateString
            messageDateLabel.textColor = chatMessage.isIncomming ? config.messageTextDateColorIncomming : config.messageTextDateColorIsNotComming
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
//        errorSend.isHidden = true
        
        
        messageLabel.numberOfLines = 0

        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -12),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 25),
            
            messageDateLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 4),
            messageDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            messageDateLabel.heightAnchor.constraint(equalToConstant: 10),
            
            errorSend.widthAnchor.constraint(equalToConstant: 20),
            errorSend.heightAnchor.constraint(equalToConstant: 20),
            errorSend.centerYAnchor.constraint(equalTo: bubbleBackgroundView.centerYAnchor, constant: 0)
            
        ]
        
        NSLayoutConstraint.activate(constraints)

        trailingConstraintErrorSend = errorSend.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -10)
        leadingConstraintErrorSend = errorSend.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 10)
        leadingConstraintMessageLabel = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
        trailingConstraintMessageLabel = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        trailingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor)
        leadingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor)
        bottomConstraintMessageLabel = messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: valueBottomConstant)
        bottomConstraintMessageLabel.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
}
