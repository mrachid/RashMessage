//
//  MessageViewController+Extension.swift
//  Pods-RashMessage_Example
//
//  Created by Rachid Mahmoud on 29/10/2018.
//

import UIKit

extension MessageViewController {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return mugiChatMessages.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mugiChatMessages[section].count
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = mugiChatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM"
            let dateString = dateFormatter.string(from: firstMessageInSection.createdAt)
            let label = DateHeaderLabel()
            label.text = dateString
            label.font = UIFont.systemFont(ofSize: 12)
            if let config = config {
                label.backgroundColor = config.headerBackgroundColor
                label.textColor = config.headerTextColor
            }
            label.translatesAutoresizingMaskIntoConstraints = false
            
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView
        }
        
        return nil
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = mugiChatMessages[indexPath.section][indexPath.row]
        switch message.kind {
            case .photo(let media):
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.messageImageCell.rawValue, for: indexPath) as! MessageImageTableViewCell
                cell.messageImageView.image = media.image
                cell.configure(valueBottomConstant: -27)
                cell.config = config
                cell.message = message
                return cell
            
            case .text(_):
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.messageTextCell.rawValue, for: indexPath) as! MessageTextTableViewCell
                var nextMessage: MugiMessage?
                cell.config = config


                if indexPath.row < mugiChatMessages[indexPath.section].count - 1 {
                    nextMessage = mugiChatMessages[indexPath.section][indexPath.row + 1]
                } else {
                    nextMessage = nil
                    cell.displayAvatar = mugiChatMessages[indexPath.section][indexPath.row].isIncomming
                    cell.configure(valueBottomConstant: -35)
                }
                
                cell.displayAvatar = MugiMessageServices.displayAvatarByMessage(firstMessage: mugiChatMessages[indexPath.section][indexPath.row], secondeMessage: nextMessage)
                if nextMessage != nil {
                    if message.isIncomming == nextMessage!.isIncomming {
                        cell.configure(valueBottomConstant: -16)
                    } else {
                        cell.configure(valueBottomConstant: -30)
                    }
                }
                
                cell.message = message
                return cell
        
            case .doc(_): return UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}

public protocol MessageDelegate {
    func didSuccessAddMessage()
    //    func didFailAddMessage()
}


class DateHeaderLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        let width = super.intrinsicContentSize.width + 20
        let height = super.intrinsicContentSize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: width, height: height)
    }
}
