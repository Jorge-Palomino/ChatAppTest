//
//  PersistentDataManager.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class PersistentDataManager {
    
    static let shared = PersistentDataManager()
    
    var maleUsers: [UserProfile]?
    
    var femaleUsers: [UserProfile]?
    
    private init(){}
    
    func loadUsers() {
        self.maleUsers = []
        self.femaleUsers = []
        loadMales()
        loadFemales()
    }
    
    private func loadMales() {
        for i in 0..<Utilities.maleNames.count {
            self.maleUsers?.append(UserProfile(gender: .male, i: i))
        }
    }
    
    private func loadFemales() {
        for i in 0..<Utilities.femaleNames.count {
            self.femaleUsers?.append(UserProfile(gender: .female, i: i))
        }
    }
    
    func loadChats() {
        for user in (User.gender == .male ? self.femaleUsers : self.maleUsers) ?? [] {
            let matchDate = Date.randomBetween(start: Date().twoDayAgo, end: Date())
            var match = UserMatch(destinateUser: user, date: matchDate)
            
            let randomMsgCount = Int(arc4random_uniform(5))
            
            let incomingFirstMsg = Bool.random()
            let firstMsg = match.getSalute(incoming: incomingFirstMsg, after: matchDate)
            let secondMsg = match.getSalute(incoming: !incomingFirstMsg, after: firstMsg.date)
            let thirdMsg = match.getSaluteReply(incoming: incomingFirstMsg, after: secondMsg.date)
            
            if randomMsgCount == 0 {
                match.messages = [firstMsg]
            }else if randomMsgCount == 1 {
                match.messages = [firstMsg, secondMsg]
            }else if randomMsgCount == 2 {
                match.messages = [firstMsg, secondMsg, thirdMsg]
            }else if randomMsgCount == 3 {
                let fourthMessage = match.getLongMsg(incoming: !incomingFirstMsg, after: thirdMsg.date)
                match.messages = [firstMsg, secondMsg, thirdMsg, fourthMessage]
            }else {
                let fourthMessage = match.getReallyLongMsg(incoming: !incomingFirstMsg, after: thirdMsg.date)
                match.messages = [firstMsg, secondMsg, thirdMsg, fourthMessage]
            }
            User.matches.append(match)
        }
        sortUserMatches()
    }
    
    func sortUserMatches() {
        User.matches.sort(by: { $0.messages.last?.date ?? Date() > $1.messages.last?.date ?? Date() })
    }
}
