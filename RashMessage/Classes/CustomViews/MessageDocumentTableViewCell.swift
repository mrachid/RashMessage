//
//  MessageDocumentTableViewCell.swift
//  Stephex
//
//  Created by Rachid Mahmoud on 19/11/2018.
//  Copyright © 2018 Bryan D'HAESELEER. All rights reserved.
//

import UIKit

class MessageDocumentTableViewCell: UITableViewCell {
    var constraintAvatar: [NSLayoutConstraint] = []


    //UI variable
    let avatar: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .red
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 16
        return imageview
    }()
    
    let docTextView: UILabel = {
        let textview = UILabel()
        textview.font = UIFont.systemFont(ofSize: 16)
        return textview
    }()
    
    let messageDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let bubbleView: UIView = {
        let bubbleView = UIView()
        bubbleView.backgroundColor = .yellow
        bubbleView.clipsToBounds = true
        bubbleView.layer.cornerRadius = 16
        return bubbleView
    }()
    
    let errorSend: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    //Constraint variable
    var leadingConstraintMessageImageView: NSLayoutConstraint!
    var trailingConstraintMessageImageView: NSLayoutConstraint!
    var bottomConstraintMessageImageView: NSLayoutConstraint!
    var leadingConstraintMessageDateLabel: NSLayoutConstraint!
    var trailingConstraintMessageDateLabel: NSLayoutConstraint!
    var config: MessageConfiguration!
    
    var displayAvatar: Bool!

    
    var message: MugiMessage! {
        didSet {
            switch message.kind {
            case .doc(let doc):
                docTextView.attributedText = addAttributForAttachement(str: doc.name!)
            default: break
            }
            
            docTextView.textColor = message.isIncomming ? config.messageTextColorIsComming : config.messageTextColorIsNotComming
            bubbleView.backgroundColor = message.isIncomming ? config.messageBackgroundColorIsComming : config.messageBackgroundColorIsNotComming
            bubbleView.layer.borderColor = message.isIncomming ? config.messageBorderColorIsComming.cgColor : config.messageBorderColorIsNotComming.cgColor

            messageDateLabel.text = DateHelper.dateTimeShortFormater.string(from: message.createdAt)
            messageDateLabel.textColor = message.isIncomming ? config.messageTextDateColorIncomming : config.messageTextDateColorIsNotComming
            if config.displayAvatar {
                avatar.image = message.sender.avatar
            }
            activaterConstraints()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
        bottomConstraintMessageImageView.isActive = false
        leadingConstraintMessageImageView.isActive = false
        trailingConstraintMessageImageView.isActive = false
        trailingConstraintMessageDateLabel.isActive = false
        leadingConstraintMessageDateLabel.isActive = false
        if config.displayAvatar {
            avatar.removeFromSuperview()
            NSLayoutConstraint.deactivate(constraintAvatar)
        }
    }
    
    func configure(valueBottomConstant value: CGFloat) {
        addSubview(bubbleView)
        addSubview(messageDateLabel)
        addSubview(docTextView)
        
        setupConstraints(valueBottomConstant: value)
    }
    
    private func activaterConstraints() {
        
        //Active or deactivate some constraint for display message at right or left
        if message.isIncomming {
            leadingConstraintMessageImageView.isActive = true
            trailingConstraintMessageImageView.isActive = false
            leadingConstraintMessageDateLabel.isActive = true
            trailingConstraintMessageDateLabel.isActive = false
            messageDateLabel.textAlignment = .left
            if displayAvatar && config.displayAvatar {
                addAvatar()
                NSLayoutConstraint.activate(constraintAvatar)
            }
        } else {
            leadingConstraintMessageImageView.isActive = false
            trailingConstraintMessageImageView.isActive = true
            leadingConstraintMessageDateLabel.isActive = false
            trailingConstraintMessageDateLabel.isActive = true
            messageDateLabel.textAlignment = .right
        }
    }
    
    private func setupConstraints(valueBottomConstant constant: CGFloat) {
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        messageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        docTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = [
            
            //ImageView constraints
            bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            bubbleView.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            bubbleView.heightAnchor.constraint(equalToConstant: 32),
            
            docTextView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5),
            docTextView.leadingAnchor.constraint(lessThanOrEqualTo: bubbleView.leadingAnchor, constant: 5),
            docTextView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -5),
            docTextView.trailingAnchor.constraint(lessThanOrEqualTo: bubbleView.trailingAnchor, constant: -5),
            
            //Date constraints
            messageDateLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 4),
            messageDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            messageDateLabel.heightAnchor.constraint(equalToConstant: 10),
            ]
        
        //Activate constraints
        NSLayoutConstraint.activate(constraint)
        
        //Trailing and leading constraint
        leadingConstraintMessageImageView = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: displayAvatar ? 45 : 5)
        trailingConstraintMessageImageView = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        trailingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor)
        leadingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor)
        
        //Update bottom constant to display correctly the space between message
        bottomConstraintMessageImageView = bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant)
        bottomConstraintMessageImageView.isActive = true
    }
    
    
    private func addAttributForAttachement(str: String) -> NSMutableAttributedString {
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let iconsSize = CGRect(x: 0, y: -1, width: 15, height: 15)
        let emojisCollection = [UIImage(named: "link")]
        let attributedString = NSMutableAttributedString(string: " " + str, attributes: underlineAttribute)
        let attachment = NSTextAttachment()
        attributedString.append(NSMutableAttributedString(string: "  "))
        attachment.bounds = iconsSize
        attachment.image = emojisCollection[0]
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.append(NSMutableAttributedString(string: " "))
        
        return attributedString
    }
    
    private func addAvatar() {
        addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        constraintAvatar =
            [
                avatar.widthAnchor.constraint(equalToConstant: 32),
                avatar.heightAnchor.constraint(equalToConstant: 32),
                avatar.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 0),
                avatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
        ]
    }
}
