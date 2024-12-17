//
//  MatchMessage.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

struct MatchMessage {
    var id: String
    var content: String
    var date: Date
    var isIncoming: Bool
    
    init(content: String, senderId: String, date: Date) {
        self.id = UUID().uuidString
        self.content = content
        self.date = date
        self.isIncoming = senderId != User.id
    }
    
    init(){
        self.id = UUID().uuidString
        self.content = ""
        self.date = Date()
        self.isIncoming = true
    }
}
