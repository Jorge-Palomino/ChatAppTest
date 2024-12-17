//
//  ChatFeedViewController.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ChatFeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = ChatFeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.parentViewController = self
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}
