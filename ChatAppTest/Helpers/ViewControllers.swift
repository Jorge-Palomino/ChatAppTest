//
//  ViewControllers.swift
//  test
//
//  Created by Jorge Palomino on 16/08/2023.
//

import UIKit

class ViewControllers {
    //MARK: - -= Popups =-
    
    class func ChatDetailViewController() -> ChatDetailViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
    }
}
