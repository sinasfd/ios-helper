//
//  RedButton.swift
//  bonizfood
//
//  Created by sina salehifard on 8/7/18.
//  Copyright © 2018 ofogheshahr. All rights reserved.
//

import UIKit

@IBDesignable class SinaButton: UIButton {

    @IBInspectable var cornnerRadius:Int = 20 {
        didSet{
            checkState()
        }
    }
    
    @IBInspectable var borderWidth:Int = 1 {
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
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

