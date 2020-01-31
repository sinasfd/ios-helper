//
//  SinaTextField.swift
//  bonizfood
//
//  Created by sina salehifard on 8/7/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit

@IBDesignable  class SinaTextField: UITextField {

    @IBInspectable  var borderWidth:Int = 0 {
        didSet{
                checkState()
        }
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       checkState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        checkState()
    }
    private func checkState(){
        if borderWidth > 0{
             self.layer.borderWidth = CGFloat(borderWidth)
        }else{
             self.borderStyle = UITextBorderStyle.none
        }
 

    }

}
