//
//  ChatCollectionViewCell.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var doubleCheckImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
    
    func configure(match: UserMatch) {
        userImageView.image = match.destinateUser.image
        userNameLabel.text = match.destinateUser.name
        messageLabel.text = match.messages.last?.content
        messageTimeLabel.text = match.messages.last?.date.humanReadableDate
        doubleCheckImageView.isHidden = match.messages.last?.isIncoming == true
    }
}
