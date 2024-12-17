//
//  UserProfile.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class UserProfile: NSObject {
    let id: String
    var name: String
    var gender: Gender
    var image: UIImage
    var matches: [UserMatch]
    
    init(gender: Gender, i: Int) {
        self.id = UUID().uuidString
        self.matches = []
        self.gender = gender
        if gender == .male {
            self.name = Utilities.maleNames[i]
            self.image = UIImage(named: "males_\(i)") ?? Images.defaultMale ?? .init()
        }else {
            self.name = Utilities.femaleNames[i]
            self.image = UIImage(named: "females_\(i)") ?? Images.defaultFemale ?? .init()
        }
    }
}

enum Gender: CaseIterable {
    case male
    case female
}
