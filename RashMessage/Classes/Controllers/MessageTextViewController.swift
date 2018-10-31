//
//  MessageViewController.swift
//  Pods-RashMessage_Example
//
//  Created by Mahmoud RACHID on 10/09/18.
//

import UIKit


enum cellIdentifier: String {
    case messageTextCell = "MessageTextCell"
    case messageImageCell = "MessageImageCell"
}

open class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
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
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        return view
    }()
    
    private let messageTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = UIFont.preferredFont(forTextStyle:  UIFont.TextStyle.body)
        view.textContainerInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        view.isScrollEnabled = false
        return view
    }()
    
    private let sendButton: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return view
    }()
    
    private let sendItemButton: UIButton = {
        let view = UIButton()
        view.setImage(ImagesHelper.loadImage(name: "add"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        return view
    }()
    
    public var config: MessageConfiguration? {
        didSet {
            setupConfigMessage()
        }
    }
    
    public var mugiMessages = [MugiMessage]() {
        didSet {
            mugiChatMessages = MugiMessageServices.parseMessageIntoSection(mugiMessages: mugiMessages)
        }
    }
    
    public var mugiChatMessages: [[MugiMessage]] = [[]]
    public var dateIsDisplayed = Set<IndexPath>()
    private var oldMessageIsIncommingChange: Bool?
    private var displayDateMessage = false
    private var messageTextViewBottomContraint: NSLayoutConstraint!
    
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
        messageTableView.separatorStyle = .none
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupDefault() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        view.backgroundColor = .white
        
        textViewDidChange(messageTextView)
    }
    
    private func setupRegister() {
        messageTableView.register(MessageTextTableViewCell.self, forCellReuseIdentifier: cellIdentifier.messageTextCell.rawValue)
        messageTableView.register(MessageImageTableViewCell.self, forCellReuseIdentifier: cellIdentifier.messageImageCell.rawValue)
    }
    
    private func setupSubviews() {
        view.addSubview(messageTableView)
        view.addSubview(messageTextBackgroundView)
        view.addSubview(messageTextBorderView)
        view.addSubview(messageTextView)
        view.addSubview(sendButton)
        view.addSubview(sendItemButton)
    }
    
    private func setupConstraints() {
        
        messageTableView.translatesAutoresizingMaskIntoConstraints = false
        messageTextBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextBorderView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendItemButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            //Text Border
            messageTextBorderView.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 5),
            messageTextBorderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            messageTextBorderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            messageTextBorderView.topAnchor.constraint(equalTo: messageTextView.topAnchor, constant: -5),
            
            //TextView
            messageTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            messageTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            messageTextView.heightAnchor.constraint(equalToConstant: 32),
            
            //Button
            sendButton.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 4),
            sendButton.leadingAnchor.constraint(equalTo: messageTextView.safeAreaLayoutGuide.trailingAnchor, constant: 10),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            
            sendItemButton.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor, constant: 4),
            sendItemButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sendItemButton.trailingAnchor.constraint(equalTo: messageTextView.leadingAnchor),
            sendItemButton.heightAnchor.constraint(equalToConstant: 40),
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
        let size = CGSize(width: textView.frame.width, height: .infinity)
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
}
