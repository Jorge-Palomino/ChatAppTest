//
//  ChatInputView.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit

@IBDesignable
class ChatInputView: IBDesignableBase {
    
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var inputTextField: UITextView!
    @IBOutlet weak var sendImageView: UIImageView!
    
    let inputTextViewMaxHeight: CGFloat = 80
    var lastTextViewValue: String = ""
    
    var parent: ChatDetailViewController?
    var match: UserMatch? {
        didSet {
            inputTextField.placeholder = "Message \(match?.destinateUser.name ?? "")"
            sendImageView.tintColor = .lightGray
            inputTextField.isScrollEnabled = false
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sendImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendMessage)))
    }
    
    override func setAppearance() {
        super.setAppearance()
        inputTextField.delegate = self
        inputTextField.showsVerticalScrollIndicator = true
        
        inputContainerView.layer.borderWidth = 1
        inputContainerView.layer.borderColor = UIColor.darkGray.cgColor
        
        inputContainerView.clipsToBounds = true
        inputContainerView.layer.cornerRadius = 16
    }
    
    @objc func sendMessage() {
        if !inputTextField.text.isEmpty {
            Utilities.doSoftHaptic()
            
            parent?.sendMessage(with: inputTextField.text)
            
            inputTextField.text = ""
            textViewDidChange(inputTextField)
        }
    }
    
}
extension ChatInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: self.inputTextField.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.layoutManager.allowsNonContiguousLayout = true

        if estimatedSize.height <= inputTextViewMaxHeight {
            textView.contentSize.height = estimatedSize.height
        }
        
        self.parent?.chatInputHeightConstraint.constant = estimatedSize.height + 20
        
        if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
        
        // Only animate and change value if input was empty and now it's not or opposite
        if lastTextViewValue.trimmingCharacters(in: .whitespaces).isEmpty && !textView.text.trimmingCharacters(in: .whitespaces).isEmpty || !lastTextViewValue.trimmingCharacters(in: .whitespaces).isEmpty && textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
            UIView.transition(with: sendImageView, duration: 0.20, options: .transitionFlipFromBottom, animations: {
                if textView.text != nil && !textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
                    self.sendImageView.tintColor = .black
                }else {
                    self.sendImageView.tintColor = .lightGray
                }
                textView.layoutIfNeeded()
            }, completion: nil)
        }
        
        lastTextViewValue = textView.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
