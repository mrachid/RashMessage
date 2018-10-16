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
    
    
    
    public var messages = [ChatMessage]() {
        didSet {
            parseMessageIntoSection()
        }
    }
//        ChatMessage(id: 15, text: "Last Message 4", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(172806), isIncomming: true),
//        ChatMessage(id: 7, text: "Message 1", from: nil, avatar: nil, createdAt: Date(), isIncomming: false),
//        ChatMessage(id: 8, text: "Last Message 1", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(172800), isIncomming: false),
//        ChatMessage(id: 9, text: "Message 2", from: nil, avatar: nil, createdAt: Date(), isIncomming: false),
//        ChatMessage(id: 10, text: "New Message 1", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(86400), isIncomming: true),
//        ChatMessage(id: 11, text: "New Message 2", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(86400), isIncomming: true),
//        ChatMessage(id: 12, text: "New Message 3", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(86400), isIncomming: true),
//        ChatMessage(id: 13, text: "Last Message 2", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(172801), isIncomming: true),
//        ChatMessage(id: 14, text: "Message 3", from: nil, avatar: nil, createdAt: Date(), isIncomming: true),
//        ChatMessage(id: 15, text: "New Message 4", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(86401), isIncomming: true),
//        ChatMessage(id: 15, text: "Last Message 3", from: nil, avatar: nil, createdAt: Date().addingTimeInterval(172801), isIncomming: true),
//    ]
    
//    public var chatMessages: [[ChatMessage]] = [[]] {
//        didSet {
//            messageTableView.reloadData()
//        }
//    }

    public var chatMessages: [[ChatMessage]] = [[]] {
        didSet {
//            messageTableView.reloadData()
        }
    }

    private let cellId = "messageCell"
    private var oldMessageIsIncommingChange: Bool?
    private var displayDateMessage = false
    private var dateIsDisplayed = Set<IndexPath>()
    private var messageTextViewBottomContraint: NSLayoutConstraint!
    
    private let messageTableView: UITableView = {
        let messageTableView = UITableView()
        messageTableView.estimatedRowHeight = 100
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
                let nbrSection = self.chatMessages.count - 1
                let lastMessage = self.chatMessages[nbrSection].count - 1
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
    
    public func newMessage(message: ChatMessage) {
        
        let lastIndexGroup = chatMessages.count - 1
        if DateHelper.dateShortFormater.string(from: (chatMessages[lastIndexGroup].first?.createdAt)!) == DateHelper.dateShortFormater.string(from: message.createdAt) {
            chatMessages[lastIndexGroup].append(message)
        } else {
            chatMessages.append([message])
        }
        
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.messageTableView.reloadData()
            self.view.layoutIfNeeded()
        }, completion: {(complete) in
            let nbrSection = self.chatMessages.count - 1
            let lastMessage = self.chatMessages[nbrSection].count - 1
            let index = IndexPath(item: lastMessage, section: nbrSection)
            self.messageTableView.scrollToRow(at: index, at: .bottom, animated: true)
        })

    }
    
    
    
    private func parseMessageIntoSection() {
        
        let messagesSorted = messages.sorted { (msg1, msg2) -> Bool in
            return msg1.createdAt < msg2.createdAt
        }
        
        var groupResult:[String: [ChatMessage]] = [:]
        
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
        
        var all: [[ChatMessage]] = []
        for group in finalResult {
            all.append(group.value)
        }
        
        chatMessages = all
    }
}



extension MessageViewController {
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
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
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, d MMM"
            let dateString = dateFormatter.string(from: firstMessageInSection.createdAt)
            let label = DateHeaderLabel()
            label.text = dateString
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
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageTableViewCell
        var nextMessage: ChatMessage?
        let message = chatMessages[indexPath.section][indexPath.row]
        
        if indexPath.row < chatMessages[indexPath.section].count - 1 {
            nextMessage = chatMessages[indexPath.section][indexPath.row + 1]
        } else {
            nextMessage = nil
        }
        
        if nextMessage != nil {
            if message.isIncomming == nextMessage!.isIncomming {
                cell.configureUI(valueBottomConstant: -35, displayDate: dateIsDisplayed.contains(indexPath))
            } else {
                cell.configureUI(valueBottomConstant: -50, displayDate: dateIsDisplayed.contains(indexPath))
            }
        } else {
            cell.configureUI(valueBottomConstant: -50, displayDate: dateIsDisplayed.contains(indexPath))
        }
        cell.config = config
        cell.chatMessage = message
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if dateIsDisplayed.contains(indexPath) {
            dateIsDisplayed.remove(indexPath)
        } else {
            dateIsDisplayed.insert(indexPath)
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
//    public func scrollToBottom(animated: Bool = false) {
//        let collectionViewContentHeight = messageTableView.contentSize.height//collectionViewLayout.collectionViewContentSize.height
//
//        performBatchUpdates(nil) { _ in
//            self.scrollRectToVisible(CGRect(0.0, collectionViewContentHeight - 1.0, 1.0, 1.0), animated: animated)
//        }
//    }
}

public protocol MessageDelegate {
    func didSuccessAddMessage()
//    func didFailAddMessage()
}

