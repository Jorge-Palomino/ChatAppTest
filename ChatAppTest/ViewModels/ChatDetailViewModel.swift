//
//  ChatDetailViewModel.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit

class ChatDetailViewModel: NSObject {
    
    var sections: [[MatchMessage]] = []
    var parentViewController: ChatDetailViewController?
    
    var isAnimating: Bool = false
    
    var match: UserMatch? {
        didSet {
            sections = [[MatchMessage.init()]] // You matched section first
            var previousMsg: MatchMessage?
            var section: [MatchMessage] = []
            for message in match?.messages ?? [] {
                if let previousMsg {
                    if previousMsg.date.distance(to: message.date).hours >= 1 {
                        sections.append(section)
                        section = []
                        section.append(message)
                    }else {
                        section.append(message)
                    }
                }else {
                    section.append(message)
                }
                previousMsg = message
            }
            // Add last message
            if !section.isEmpty {
                sections.append(section)
            }
        }
    }
    
}
extension ChatDetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            // Match section
            return 1
        }
        
        // Msg section
        return self.sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.className, for: indexPath) as! InfoCollectionViewCell
            
            cell.titleLabel.text = "You matched 🎈"
            
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatMessageCollectionViewCell.className, for: indexPath) as! ChatMessageCollectionViewCell
            
            cell.message = sections[indexPath.section][indexPath.item]
            
            cell.configureTopPadding(sections: sections, indexPath: indexPath)
            
            // Hide bubble during animation
            cell.bubbleView.isHidden = isAnimating && indexPath.section == sections.count - 1 && indexPath.item == sections[indexPath.section].count - 1
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }else {
            let currentMsg = sections[indexPath.section][indexPath.item]
            let content = currentMsg.content
            let estimateSize = Utilities.estimateFrameForText(text: content, font: !content.containsOnlyEmoji ? .systemFont(ofSize: 14) : .systemFont(ofSize: 35), size: CGSize(width: collectionView.frame.width -  (ScreenSize.SCREEN_WIDTH * 2 / 7) - 20, height: .infinity))
            
            return CGSize(width: collectionView.frame.width, height: estimateSize.height + 30 + 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ChatHeaderView.className, for: indexPath) as! ChatHeaderView
        
        if indexPath.section == 0 {
            cell.date = match?.date
        }else {
            cell.date = sections[indexPath.section].first?.date
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
