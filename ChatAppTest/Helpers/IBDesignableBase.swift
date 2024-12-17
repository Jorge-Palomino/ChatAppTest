//
//  IBDesignableBase.swift
//  test
//
//  Created by Jorge Palomino on 17/08/2023.
//

import UIKit

class IBDesignableBase: UIView {
    
// ##################################################################################################
// NB: All subclasses that inherit from this class MUST have the same name as the name of their corresponding .xib file
// ##################################################################################################
    
    
    //MARK: - -= Initiliasers =-
    
    var contentView:UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.xibSetup()
    }
    
    func xibSetup() {
        
        //Load view from xib file if not already loaded
        if (self.contentView == nil) {
            guard let view = self.loadViewFromNib() else {
                return
            }
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.backgroundColor = .clear
            self.addSubview(view)
            self.contentView = view
        }
        
        self.setAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setAppearance()
    }
    
    func setAppearance() {
        //subviews to implement for styling
    }
    
    //Note that "self.className" means the .xib file must have the same name as this class
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.className, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}

