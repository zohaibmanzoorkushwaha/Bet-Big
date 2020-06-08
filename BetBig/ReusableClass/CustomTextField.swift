//
//  CustomTextField.swift
//  HorizamFirstApp
//
//  Created by Zohaib on 25/03/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

class SATextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor             = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        textColor             = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        backgroundColor       = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        autocorrectionType    = .no
        layer.cornerRadius  = frame.size.height/5
        clipsToBounds         = true
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = #colorLiteral(red: 0.7254417539, green: 0.721131146, blue: 0.7287563682, alpha: 0.8012895976)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        
        
        
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }
}
