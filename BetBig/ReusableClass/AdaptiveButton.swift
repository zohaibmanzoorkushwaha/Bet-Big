//
//  AdaptiveButton.swift
//  BWS
//
//  Created by Muaaz Ahmed on 25/02/2019.
//  Copyright © 2019 Muaaz Ahmed All rights reserved.
//

import Foundation
import UIKit

class AdaptiveButton: UIButton {

//    @IBInspectable public var cornerRadiosValue: Float = 0.0
//    @IBInspectable public var isClipsToBounds: Bool = true
    
    required init(coder aDecoder: NSCoder) {
    
        
        
        super.init(coder: aDecoder)!
        // titleLabel Required due to property of Uibutton
//       self.layer.cornerRadius = CGFloat(cornerRadiosValue)
//        self.clipsToBounds = isClipsToBounds
        //////////
        let deviceWidth = UIScreen.main.bounds.width
        if (deviceWidth == 320) {
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize)! * 0.83)
        }
            
        else if (deviceWidth == 375){
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize)! * 1.02)
        }
      
        else if (deviceWidth == 414) {
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize)! * 1.16)
        }
        else if (deviceWidth == 420){
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize)! * 1.4)
        }
    }
    
    
    
}
