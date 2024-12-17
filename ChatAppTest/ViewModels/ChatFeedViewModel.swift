//
//  ChatFeedViewModel.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit

class ChatFeedViewModel: NSObject {
    
    let chatHeight: CGFloat = 70
    var parentViewController: ChatFeedViewController?
    
}
extension ChatFeedViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return User.matches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.className, for: indexPath) as! ChatCollectionViewCell
        
        let match = User.matches[indexPath.item]
        cell.configure(match: match)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: chatHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = ViewControllers.ChatDetailViewController()
        controller.viewModel.match = User.matches[indexPath.item]
        controller.callback = {
            if let match = controller.viewModel.match {
                User.matches[indexPath.item] = match
            }
            PersistentDataManager.shared.sortUserMatches()
            collectionView.reloadData()
        }
        
        parentViewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
