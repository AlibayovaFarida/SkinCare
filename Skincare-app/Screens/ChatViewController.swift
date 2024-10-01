//
//  ChatViewController.swift
//  Skincare-app
//
//  Created by Umman on 01.10.24.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ChatViewController: MessagesViewController {
    
    var messages: [MessageType] = []
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 14)
        label.textColor = .customDarkBlue
        label.textAlignment = .center
        return label
    }()
    
    private let bottomLine: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messagesCollectionView.isScrollEnabled = false
        
        loadStaticMessages()
        setupNavigationBar()
        setupInputBarPlaceholder()
        setupHeaderLabel()
        setupSendButtonIcon()
        let topInset: CGFloat = 70
        messagesCollectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        
        view.addSubview(bottomLine)
        setupBottomLineConstraints()
    }
    
    private func setupBottomLineConstraints() {
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupSendButtonIcon() {
        let sendButton = messageInputBar.sendButton
        
        sendButton.setImage(UIImage(named: "sendButton"), for: .normal)
        sendButton.setTitle("", for: .normal)
        
        sendButton.contentHorizontalAlignment = .fill
    }
    
    private func setupInputBarPlaceholder() {
        let inputBar = messageInputBar
        inputBar.inputTextView.placeholder = "Sizin mesajiınız..."
        inputBar.inputTextView.font = UIFont(name: "Montserrat-Medium", size: 14)
    }
    
    private func setupNavigationBar() {
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back-button"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "youngMan")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let onlineIndicator = UIView()
        onlineIndicator.backgroundColor = .green
        onlineIndicator.layer.cornerRadius = 6
        onlineIndicator.clipsToBounds = true
        onlineIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Dr. Stanford"
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Sizin şəxsi həkiminiz"
        subtitleLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        subtitleLabel.textColor = .black
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let titleStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.spacing = 4
        
        let imageContainerView = UIView()
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(onlineIndicator)
        
        let stackView = UIStackView(arrangedSubviews: [backButton, imageView, titleStackView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        stackView.addArrangedSubview(imageContainerView)
        
        let customBackButtonItem = UIBarButtonItem(customView: stackView)
        self.navigationItem.leftBarButtonItem = customBackButtonItem
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        onlineIndicator.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.trailing.equalTo(imageView.snp.trailing)
            make.bottom.equalTo(imageView.snp.bottom)
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.width.equalTo(imageView)
            make.height.equalTo(imageView)
        }
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupHeaderLabel() {
        headerLabel.text = "Bugün, 31 Avqust"
        view.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func loadStaticMessages() {
        let sender = Sender(senderId: "123", displayName: "John")
        
        let message1Text = "Salam. Mən Stanford, sizin həkiminizəm. Bu gün sizə necə kömək edə bilərəm?"
        let attributedMessage1 = createAttributedMessage(text: message1Text, fontSize: 14, color: UIColor.customDarkBlue)
        
        let message2Text = "Salam. Dərim son günlərdə yağlanmağa başlayıb səbəbi nə ola bilər?"
        let attributedMessage2 = createAttributedMessage(text: message2Text, fontSize: 14, color: UIColor.customDarkBlue)
        
        let message1 = Message(sender: sender, messageId: "1", sentDate: Date(), kind: attributedMessage1)
        let message2 = Message(sender: currentSender as! Sender, messageId: "2", sentDate: Date(), kind: attributedMessage2)
        
        messages = [message1, message2]
        messagesCollectionView.reloadData()
    }
    
    private func createAttributedMessage(text: String, fontSize: CGFloat, color: UIColor) -> MessageKind {
        let font = UIFont(name: "Montserrat-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return .attributedText(attributedString)
    }
}

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var currentSender: any MessageKit.SenderType {
        return Sender(senderId: "self", displayName: "Me")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if message.sender.senderId == currentSender.senderId {
            return UIColor.customLightGreen
        } else {
            return UIColor.chatBubbleBlue
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: any MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        var avatarFrame = avatarView.frame
        avatarFrame.origin.y -= 50
        avatarView.frame = avatarFrame
        
        if isFromCurrentSender(message: message) {
            
            avatarView.image = UIImage(named: "userImage")
        }
        
        else {
            
            avatarView.image = UIImage(named: "youngMan")
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        if isFromCurrentSender(message: message) {
            
            return .bubbleTail(.topRight, .pointedEdge)
        } else {
            
            return .bubbleTail(.topLeft, .pointedEdge)
        }
    }
}

