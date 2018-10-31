//
//  MessageImageTableViewCell.swift
//  Pods-RashMessage_Example
//
//  Created by Rachid Mahmoud on 18/10/2018.
//

import UIKit

class MessageImageTableViewCell: UITableViewCell {
    
    //UI variable
    let messageDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let messageImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .lightGray
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 16
        return imageview
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
    
    var message: MugiMessage! {
        didSet {
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
        bottomConstraintMessageImageView.isActive = false
        leadingConstraintMessageImageView.isActive = false
        trailingConstraintMessageImageView.isActive = false
        trailingConstraintMessageDateLabel.isActive = false
        leadingConstraintMessageDateLabel.isActive = false
    }
        
    func configure(valueBottomConstant value: CGFloat) {
        addSubview(messageImageView)
        addSubview(messageDateLabel)
        
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
        } else {
            leadingConstraintMessageImageView.isActive = false
            trailingConstraintMessageImageView.isActive = true
            leadingConstraintMessageDateLabel.isActive = false
            trailingConstraintMessageDateLabel.isActive = true
            messageDateLabel.textAlignment = .right
        }
    }
    
    private func setupConstraints(valueBottomConstant constant: CGFloat) {
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = [
            
            //ImageView constraints
            messageImageView.topAnchor.constraint(equalTo: topAnchor),
            messageImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            messageImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 320),
            
            //Date constraints
            messageDateLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 4),
            messageDateLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50),
            messageDateLabel.heightAnchor.constraint(equalToConstant: 10),
        ]
        
        //Activate constraints
        NSLayoutConstraint.activate(constraint)
        
        //Trailing and leading constraint
        leadingConstraintMessageImageView = messageImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13)
        trailingConstraintMessageImageView = messageImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -13)
        trailingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor)
        leadingConstraintMessageDateLabel = messageDateLabel.trailingAnchor.constraint(equalTo: messageImageView.trailingAnchor)
        
        //Update bottom constant to display correctly the space between message
        bottomConstraintMessageImageView = messageImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constant)
        bottomConstraintMessageImageView.isActive = true
    }
}
