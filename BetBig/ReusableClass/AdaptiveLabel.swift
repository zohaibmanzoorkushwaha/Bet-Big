//
//  AdaptiveLabel.swift
//  BWS
//
//  Created by Abuzar Manzoor on 11/02/2019.
//  Copyright © 2019 Abuzar Manzoor. All rights reserved.
//

import UIKit

class AdaptiveLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        // titleLabel Required due to property of Uibutton
        let deviceWidth = UIScreen.main.bounds.width
        if (deviceWidth == 320) {
            self.font = self.font.withSize(self.font.pointSize * 0.83)
        }
        else if (deviceWidth == 414) {
            self.font = self.font.withSize(self.font.pointSize * 1.08)
        }
        else if (deviceWidth > 700 ){
            self.font = self.font.withSize(self.font.pointSize * 1.08)
        }else if (deviceWidth < 500){
            self.font = self.font.withSize(self.font.pointSize * 0.83)
        }
    }
}
