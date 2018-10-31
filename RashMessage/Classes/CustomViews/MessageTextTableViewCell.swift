
//
//  MessageTextTableViewCell.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import UIKit

class MessageTextTableViewCell: UITableViewCell {
    
    let messageDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let bubbleBackgroundView: UIView = {
        let bubble = UIView()
        bubble.layer.borderWidth = 1
        bubble.layer.cornerRadius = 16
        return bubble
    }()
    
    let messageTextView: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.systemFont(ofSize: 16)
        textview.backgroundColor = .clear
        textview.isScrollEnabled = false
        textview.isEditable = false
        textview.isSelectable = true
        textview.dataDetectorTypes = .all
        return textview
    }()
    
    let errorSend: UIButton = {
        let btn = UIButton()
        btn.setImage(ImagesHelper.loadImage(name: "exclamation"), for: .normal)
        return btn
    }()
    
    var config: MessageConfiguration!

    var leadingConstraintMessageTextView: NSLayoutConstraint!
    var trailingConstraintMessageTextView: NSLayoutConstraint!
    var leadingConstraintMessageDateLabel: NSLayoutConstraint!
    var trailingConstraintMessageDateLabel: NSLayoutConstraint!
    var bottomConstraintMessageTextView: NSLayoutConstraint!
    var trailingConstraintErrorSend: NSLayoutConstraint!
    var leadingConstraintErrorSend: NSLayoutConstraint!
    
    var message: MugiMessage! {
        didSet {
            
            switch message.kind {
                case .text(let text): messageTextView.text = text
                default: break
            }
            
            messageTextView.textColor = message.isIncomming ? config.messageTextColorIsComming : config.messageTextColorIsNotComming
            bubbleBackgroundView.backgroundColor = message.isIncomming ? config.messageBackgroundColorIsComming : config.messageBackgroundColorIsNotComming
            bubbleBackgroundView.layer.borderColor = message.isIncomming ? config.messageBorderColorIsComming.cgColor : config.messageBorderColorIsNotComming.cgColor
            messageDateLabel.text = DateHelper.dateTimeShortFormater.string(from: message.createdAt)
            messageDateLabel.textColor = message.isIncomming ? config.messageTextDateColorIncomming : config.messageTextDateColorIsNotComming
        
            activaterConstraints()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Init cell with default configuration
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trailingConstraintMessageTextView.isActive = false
        leadingConstraintMessageTextView.isActive = false
        leadingConstraintMessageDateLabel.isActive = false
        trailingConstraintMessageDateLabel.isActive = false
        bottomConstraintMessageTextView.isActive = false
        trailingConstraintErrorSend.isActive = false
        leadingConstraintErrorSend.isActive = false
    }
    
    func configure(valueBottomConstant value: CGFloat) {
        addSubview(bubbleBackgroundView)
        addSubview(messageTextView)
        addSubview(messageDateLabel)
        addSubview(errorSend)
        
        setupConstraints(valueBottomConstant: value)
    }
    
    private func activaterConstraints() {
        
        //Active or deactivate some constraint for display message at right or left
        if message.isIncomming {
            leadingConstraintMessageTextView.isActive = true
            trailingConstraintMessageTextView.isActive = false
            leadingConstraintMessageDateLabel.isActive = true
            trailingConstraintMessageDateLabel.isActive = false
            trailingConstraintErrorSend.isActive = false
            leadingConstraintErrorSend.isActive = true
            messageDateLabel.textAlignment = .left
        } else {
            leadingConstraintMessageTextView.isActive = false
            trailingConstraintMessageTextView.isActive = true
            leadingConstraintMessageDateLabel.isActive = false
            trailingConstraintMessageDateLabel.isActive = true
            trailingConstraintErrorSend.isActive = true
            leadingConstraintErrorSend.isActive = false
            messageDateLabel.textAlignment = .right
        }
    }
    
    private func setupConstraints(valueBottomConstant value: CGFloat) {
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        errorSend.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            
            //Message text constraint
            messageTextView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            messageTextView.widthAnchor.constraint(lessThanOrEqualToConstant: 260),
            messageTextView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            //Bubble message text background constraint
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: -6),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageTextView.leadingAnchor, constant: -12),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor, constant: 12),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 25),
            
            //message date constraint
            messageDateLabel.topAnchor.constraint(equalTo: messageTextView.bottomAnchor),
            messageDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            messageDateLabel.heightAnchor.constraint(equalToConstant: 10),
            
            //error button constraint
            errorSend.widthAnchor.constraint(equalToConstant: 20),
            errorSend.heightAnchor.constraint(equalToConstant: 20),
            errorSend.centerYAnchor.constraint(equalTo: bubbleBackgroundView.centerYAnchor, constant: 0)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        //Trailing and leading constraint
        trailingConstraintErrorSend = errorSend.trailingAnchor.constraint(equalTo: bubbleBackgroundView.leadingAnchor, constant: -10)
        leadingConstraintErrorSend = errorSend.leadingAnchor.constraint(equalTo: bubbleBackgroundView.trailingAnchor, constant: 10)
        leadingConstraintMessageTextView = messageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
        trailingConstraintMessageTextView = messageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        trailingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor)
        leadingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageTextView.trailingAnchor)

        //Update bottom constant to display correctly the space between message
        bottomConstraintMessageTextView = messageTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: value)
        bottomConstraintMessageTextView.isActive = true
    }
}
