//
//  MessageViewController.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import UIKit

open class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    public var config: MessageConfiguration? {
        didSet {
            setupConfigMessage()
        }
    }
    
    public var mugiMessages = [MugiMessage]() {
        didSet {
            parseMessageIntoSection()
        }
    }
    
    public var mugiChatMessages: [[MugiMessage]] = [[]]


    private let cellId = "messageCell"
    private var oldMessageIsIncommingChange: Bool?
    private var displayDateMessage = false
    private var dateIsDisplayed = Set<IndexPath>()
    private var messageTextViewBottomContraint: NSLayoutConstraint!
    
    private let messageTableView: UITableView = {
        let messageTableView = UITableView()
        messageTableView.estimatedRowHeight = 160
        messageTableView.estimatedSectionHeaderHeight = 100
        return messageTableView
    }()
    
    private let messageTextBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let messageTextBorderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        return view
    }()
    
    private let messageTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = UIFont.preferredFont(forTextStyle:  UIFont.TextStyle.body)
        view.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        return view
    }()
    
    private let sendButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return view
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        setupRegister()
        setupSubviews()
        setupConstraints()
        setupDelegates()
        if config == nil {
            config = MessageConfiguration()
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupDefault() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        view.backgroundColor = .white
        messageTableView.separatorStyle = .none
        messageTextView.isScrollEnabled = false
        textViewDidChange(messageTextView)
    }
    
    private func setupRegister() {
        messageTableView.register(MessageTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setupSubviews() {
        view.addSubview(messageTableView)
        view.addSubview(messageTextBackgroundView)
        view.addSubview(messageTextBorderView)
        view.addSubview(messageTextView)
        view.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        
        messageTableView.translatesAutoresizingMaskIntoConstraints = false
        messageTextBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextBorderView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        //TableViewConstrainte
        let bottom = messageTableView.bottomAnchor.constraint(equalTo: messageTextBackgroundView.topAnchor)
        let top = messageTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length)
        let leading = messageTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailing = messageTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, trailing, leading])
        
        let constraintsInputTextView = [
            
            //Background1
            messageTextBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messageTextBackgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageTextBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            messageTextBackgroundView.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: -16),
            
            //Background2
            messageTextBorderView.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 5),
            messageTextBorderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            messageTextBorderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            messageTextBorderView.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: -5),
            
            //TextView
            messageTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            messageTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            messageTextView.heightAnchor.constraint(equalToConstant: 32),
            
            //Button
            sendButton.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 4),
            sendButton.leadingAnchor.constraint(equalTo: messageTextView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            ]
        NSLayoutConstraint.activate(constraintsInputTextView)
        
        //Constraint button textView - Use for Keyboard show
        messageTextViewBottomContraint = messageTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        messageTextViewBottomContraint.isActive = true
        
        
    }
    
    private func setupDelegates() {
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextView.delegate = self
    }
    
    private func setupConfigMessage() {
        if let config = config {
            navigationItem.title = config.titlePage
            navigationController?.navigationBar.prefersLargeTitles = config.isLargeTitle
            
            if !config.sendButtonIsImage {
                sendButton.setTitle(config.sendButtonText, for: .normal)
                sendButton.setTitleColor(config.sendButtonTextColor, for: .normal)
            }

            sendButton.backgroundColor = config.sendButtonBackgroundColor
            messageTableView.backgroundColor = config.chatBackgroundColor
            messageTextView.text = config.placeholderTextView
            messageTextView.textColor = config.textColorTextView
            messageTextBorderView.backgroundColor = config.backgroundTextView
            messageTextBorderView.layer.borderColor = config.borderTextView
        }
    }
    
    
    @objc public func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            messageTextViewBottomContraint.constant = -keyboardSize.height - 15
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(complete) in
                let nbrSection = self.mugiChatMessages.count - 1
                let lastMessage = self.mugiChatMessages[nbrSection].count - 1
                let index = IndexPath(item: lastMessage, section: nbrSection)
                self.messageTableView.scrollToRow(at: index, at: .bottom, animated: true)
            })
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 120, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height && estimatedSize.height <= 98 && estimatedSize.height >= 32 {
                constraint.constant = estimatedSize.height
                textView.isScrollEnabled = false
            }
            if estimatedSize.height > 98 {
                textView.isScrollEnabled = true
            }
        }
    }
    
    public func newMessage(message: MugiMessage) {
        
        let lastIndexGroup = mugiChatMessages.count - 1
        if DateHelper.dateShortFormater.string(from: (mugiChatMessages[lastIndexGroup].first?.createdAt)!) == DateHelper.dateShortFormater.string(from: message.createdAt) {
            mugiChatMessages[lastIndexGroup].append(message)
        } else {
            mugiChatMessages.append([message])
        }
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.messageTableView.reloadData()
            self.view.layoutIfNeeded()
        }, completion: {(complete) in
            let nbrSection = self.mugiChatMessages.count - 1
            let lastMessage = self.mugiChatMessages[nbrSection].count - 1
            let index = IndexPath(item: lastMessage, section: nbrSection)
            self.messageTableView.scrollToRow(at: index, at: .bottom, animated: true)
        })

    }

    private func parseMessageIntoSection() {
        
        let messagesSorted = mugiMessages.sorted { (msg1, msg2) -> Bool in
            return msg1.createdAt < msg2.createdAt
        }
        
        var groupResult:[String: [MugiMessage]] = [:]
        
        for message in messagesSorted {
            let date = DateHelper.dateShortFormater.string(from: message.createdAt)
            if groupResult[date] != nil {
                groupResult[date]!.append(message)
            } else {
                groupResult[date] = [message]
            }
        }
        
        let finalResult = groupResult.sorted { (arg0, arg1) -> Bool in
            return arg0.key < arg1.key
        }
        
        var all: [[MugiMessage]] = []
        for group in finalResult {
            all.append(group.value)
        }
        
        mugiChatMessages = all
    }
}



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
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageTableViewCell
        
        
//        switch message.kind {
//        case .photo(_):
//        case .text(_):
//        }
        
        
        
        
        
        var nextMessage: MugiMessage?
        let message = mugiChatMessages[indexPath.section][indexPath.row]
        
        if indexPath.row < mugiChatMessages[indexPath.section].count - 1 {
            nextMessage = mugiChatMessages[indexPath.section][indexPath.row + 1]
        } else {
            nextMessage = nil
            cell.configureUI(valueBottomConstant: -35, displayDate: dateIsDisplayed.contains(indexPath))
        }
        
        
        if nextMessage != nil {
            if message.isIncomming == nextMessage!.isIncomming {
                cell.configureUI(valueBottomConstant: -27, displayDate: dateIsDisplayed.contains(indexPath))
            } else {
                cell.configureUI(valueBottomConstant: -35, displayDate: dateIsDisplayed.contains(indexPath))
            }
        }
        
        cell.config = config
        cell.chatMessage = message
        
        return cell
        
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
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
