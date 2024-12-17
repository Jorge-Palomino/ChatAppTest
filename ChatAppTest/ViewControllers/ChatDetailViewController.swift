//
//  ChatDetailViewController.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chatInputView: ChatInputView!
    @IBOutlet weak var chatInputHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatInputBottomConstraint: NSLayoutConstraint!
    
    var viewModel: ChatDetailViewModel = ChatDetailViewModel()
    
    var callback: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.parentViewController = self
        
        userNameLabel.text = viewModel.match?.destinateUser.name
        userImageView.image = viewModel.match?.destinateUser.image
        
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        
        chatInputView.match = viewModel.match
        chatInputView.parent = self
        
        backImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goBack)))
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        collectionView.register(UINib(nibName: ChatHeaderView.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChatHeaderView.className)
        collectionView.register(UINib(nibName: ChatMessageCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ChatMessageCollectionViewCell.className)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        callback?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillChange(_ aNotification: Notification) {
        if let userInfo = aNotification.userInfo, let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           let animationDuration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            
            if ScreenSize.SCREEN_HEIGHT == keyboardFrame.origin.y {
                chatInputBottomConstraint.constant = 0
            }else {
                chatInputBottomConstraint.constant = keyboardFrame.height
            }
            
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func hideKeyboard() {
        Utilities.hideKeyboard()
    }
    
    func sendMessage(with message: String?) {
        let newMessage = MatchMessage.init(content: message ?? "", senderId: User.id, date: Date())
        viewModel.match?.messages.append(newMessage)
        
        doSendMessageAnimation()
        
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.collectionView.scrollToBottom()
        })
    }
    
    private func doSendMessageAnimation() {
        viewModel.isAnimating = true
        
        chatInputView.inputContainerView.backgroundColor = Colours.pink
        chatInputView.inputTextField.textColor = .white
        chatInputView.inputContainerView.layer.borderWidth = 0
        
        let animationView = chatInputView.inputContainerView.copyView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.clipsToBounds = true
        animationView.layer.cornerRadius = 16
        
        self.view.addSubview(animationView)
        
        let animationLeadingConst = animationView.leadingAnchor.constraint(equalTo: chatInputView.inputContainerView.leadingAnchor)
        let animationTrailingConst = animationView.trailingAnchor.constraint(equalTo: chatInputView.inputContainerView.trailingAnchor)
        let animationBottomConst = animationView.bottomAnchor.constraint(equalTo: chatInputView.inputContainerView.bottomAnchor)
        let animationHeightConst = animationView.heightAnchor.constraint(equalToConstant: chatInputView.inputContainerView.frame.height)
        
        animationLeadingConst.isActive = true
        animationTrailingConst.isActive = true
        animationBottomConst.isActive = true
        animationHeightConst.isActive = true
        
        chatInputView.inputContainerView.backgroundColor = .clear
        chatInputView.inputTextField.textColor = .black
        chatInputView.inputContainerView.layer.borderWidth = 1
        
        self.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            
            UIView.animate(withDuration: 0.5, animations: {
                if let destinateCell = self.collectionView.visibleCells.compactMap({ $0 as? ChatMessageCollectionViewCell}).sorted(by: { $0.message?.date ?? Date() > $1.message?.date ?? Date() }).first {
                    
                    animationLeadingConst.isActive = false
                    animationTrailingConst.isActive = false
                    animationBottomConst.isActive = false
                    animationHeightConst.isActive = false
                    
                    
                    UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
                        let destLeadingConst = animationView.leadingAnchor.constraint(equalTo: destinateCell.bubbleView.leadingAnchor)
                        let destTrailingConst = animationView.trailingAnchor.constraint(equalTo: destinateCell.bubbleView.trailingAnchor)
                        let destBottomConst = animationView.bottomAnchor.constraint(equalTo: destinateCell.bubbleView.bottomAnchor)
                        let destHeightConst = animationView.heightAnchor.constraint(equalToConstant: destinateCell.bubbleView.frame.height)
                        
                        destLeadingConst.isActive = true
                        destTrailingConst.isActive = true
                        destBottomConst.isActive = true
                        destHeightConst.isActive = true
                        
                        self.view.layoutIfNeeded()
                    }, completion: { finished in
                        animationView.removeFromSuperview()
                        self.viewModel.isAnimating = false
                        self.collectionView.reloadData()
                    })
                }
            })
        })
    }
}
