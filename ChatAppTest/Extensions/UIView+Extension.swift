//
//  UIView+Extension.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit
extension UIView {
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}
