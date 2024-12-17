//
//  ChatHeaderView.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ChatHeaderView: UICollectionReusableView {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    var date: Date? {
        didSet {
            dateLabel.text = date?.readableDate
            hourLabel.text = date?.readableTime
        }
    }
}
