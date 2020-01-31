//
//  sinaStarBase.swift
//  bonizfood
//
//  Created by sina salehifard on 8/13/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit

@IBDesignable class SinaUiView: UIView {

    @IBInspectable var cornnerRadius:Int = 20 {
        didSet{
            checkState()
        }
    }
    
    @IBInspectable var borderWidth:Int = 0 {
        didSet{
            checkState()
        }
    }
    @IBInspectable var borderColor:String = "#aaaaaa" {
        didSet{
            checkState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializer()
        //fatalError("init(coder:) has not been implemented")
    }
    private func initializer(){
        checkState()
    }
    private func checkState(){
        self.layer.cornerRadius = CGFloat(cornnerRadius)
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = UIColor(hexString: borderColor).cgColor
    }

}
