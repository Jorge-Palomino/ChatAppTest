//
//  UserMatch.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

struct UserMatch {
    let id: String
    var destinateUser: UserProfile
    var date: Date
    var messages: [MatchMessage]
    
    init(destinateUser: UserProfile, date: Date, messages: [MatchMessage] = []) {
        self.id = UUID().uuidString
        self.destinateUser = destinateUser
        self.date = date
        self.messages = messages
    }
    
    func getSalute(incoming: Bool, after date: Date) -> MatchMessage {
        let message = MatchMessage(content: Utilities.saluteMsgs.randomElement() ?? "👋🏼", senderId: incoming ? destinateUser.id : User.id, date: date.adding(minutes: Int(arc4random_uniform(120))))
        return message
    }
    
    func getSaluteReply(incoming: Bool, after date: Date) -> MatchMessage {
        let message = MatchMessage(content: Utilities.saluteReplies.randomElement() ?? "👋🏼", senderId: incoming ? destinateUser.id : User.id, date: date.adding(minutes: Int(arc4random_uniform(120))))
        return message
    }
    
    func getLongMsg(incoming: Bool, after date: Date) -> MatchMessage {
        let message = MatchMessage(content: Utilities.longMessages.randomElement() ?? "👋🏼", senderId: incoming ? destinateUser.id : User.id, date: date.adding(minutes: Int(arc4random_uniform(120))))
        return message
    }
    
    func getReallyLongMsg(incoming: Bool, after date: Date) -> MatchMessage {
        let message = MatchMessage(content: Utilities.reallyLongMessages.randomElement() ?? "👋🏼", senderId: incoming ? destinateUser.id : User.id, date: date.adding(minutes: Int(arc4random_uniform(120))))
        return message
    }
}
