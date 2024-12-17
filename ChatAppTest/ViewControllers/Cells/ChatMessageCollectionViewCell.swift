//
//  ChatMessageCollectionViewCell.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ChatMessageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleTopConstraint: NSLayoutConstraint!
    
    var message: MatchMessage? {
        didSet {
            messageLabel.text = message?.content
            let isIncoming = message?.isIncoming ?? false
            messageLabel.textColor = isIncoming ? .black : .white
            bubbleView.backgroundColor = isIncoming ? UIColor.lightGray : Colours.pink
            
            bubbleLeadingConstraint.constant = isIncoming ? 10 : ScreenSize.SCREEN_WIDTH * 2 / 7
            bubbleTrailingConstraint.constant = isIncoming ? ScreenSize.SCREEN_WIDTH * 2 / 7 : 10

            if let content = message?.content {
                let estimateSize = Utilities.estimateFrameForText(text: content, font: !content.containsOnlyEmoji ? .systemFont(ofSize: 14) : .systemFont(ofSize: 35), size: CGSize(width: self.frame.width -  ScreenSize.SCREEN_WIDTH * 2 / 7 - 20, height: .infinity))

                if estimateSize.height < 17 || content.containsOnlyEmoji {
                    // Single line message
                    if isIncoming {
                        bubbleTrailingConstraint.constant = self.frame.width - 30 - estimateSize.width
                    }else {
                        bubbleLeadingConstraint.constant = self.frame.width - 30 - estimateSize.width
                    }
                }
                
                if content.containsOnlyEmoji {
                    // Msg with only emojis
                    messageLabel.font = .systemFont(ofSize: 35)
                    bubbleView.backgroundColor = .clear
                }else {
                    messageLabel.font = .systemFont(ofSize: 14)
                    bubbleView.backgroundColor = isIncoming ? UIColor.lightGray : Colours.pink
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.clipsToBounds = true
        bubbleView.layer.cornerRadius = 16
    }
    
    func configureTopPadding(sections: [[MatchMessage]], indexPath: IndexPath) {
        
        let currentMsg = sections[indexPath.section][indexPath.item]
        let content = currentMsg.content
        
        var lessThanTwentySec = false
        if indexPath.item != 0 {
            let previousMsg = sections[indexPath.section][indexPath.item - 1]
            if currentMsg.isIncoming == previousMsg.isIncoming &&
                previousMsg.date.distance(to: currentMsg.date).seconds <= 20 {
                lessThanTwentySec = true
            }
        }
        bubbleTopConstraint.constant = !lessThanTwentySec ? 10 : 4
    }
}
