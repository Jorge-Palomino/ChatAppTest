//
//  ScrollView+Extension.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit


extension UIScrollView {
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
}
