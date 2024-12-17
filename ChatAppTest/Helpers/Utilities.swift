//
//  Utilities.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class Utilities {
    
    static let maleNames: [String] = ["Akeem", "Hassan", "Jamal", "Kareem", "Omar"]
    
    static let femaleNames: [String] = ["Aaliyah", "Aisha", "Amina", "Asma", "Zuma"]
    
    static let saluteMsgs: [String] = ["👋🏼", "Heeey", "Hello!", "Hey there 😄", "Holaa!"]
    
    static let saluteReplies: [String] = ["How's your day?", "What are you up to today?", "Any plans for today?", "I like your vibe!", "I'm excited to getting to know you!"]
    
    static let longMessages: [String] = [
        "I've been going out with a couple of friends to play football. I'm dead 💀, what about you?",
        "I wanted to get some coffee with my collegues after work, but it looks like they are busy now. Do you want to hang out?",
        "I've gone to the gym today, done my morning exercise routine and now I am about to start working, what's your plan?",
        "Having a lazy weekend! Just want to chill at home, I haven't been feeling my best for the last couple of days... just need some rest 🥵"
    ]
    
    static let reallyLongMessages: [String] = [
        "I have been thinking whether or not to join the app, but most of my friends are on it and it seems to be working for them so I decided to give it a go. How have you found it so far, any good connections or something that you'd like to share with me? On my end I am still trying my best, I think the right person is waiting for me...",
        "I am not sure what is wrong with me... do you think is there something wrong? I just feel like people are not matching me and if they do they just skip me after two messages so I can't really get to know them. I am trying my best but I am about to give it a pass"
    ]
    
    class func estimateFrameForText(text: String, font: UIFont?, size: CGSize?) -> CGRect {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let leftPadding = window?.safeAreaInsets.left ?? 0
        let rightPadding = window?.safeAreaInsets.right ?? 0
        let size = size ?? CGSize(width: window?.bounds.width ?? UIScreen.main.bounds.width - leftPadding - rightPadding - 40, height: 0)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = font ?? UIFont.systemFont(ofSize: 14, weight: .medium)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: attributes], context: nil)
    }
    
    class func hideKeyboard() {
        UIApplication.shared.windows.first?.endEditing(true)
    }
    
    class func doSoftHaptic() {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .soft)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
