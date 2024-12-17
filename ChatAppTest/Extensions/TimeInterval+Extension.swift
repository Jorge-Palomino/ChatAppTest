//
//  TimeInterval+Extension.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit
extension TimeInterval {
    
    var seconds: Int {
        return Int(self) % 60
    }
    
    var hours: Int {
        return Int(self) / 3600
    }
    
}
