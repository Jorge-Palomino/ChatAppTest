//
//  NSObject+Extension.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
