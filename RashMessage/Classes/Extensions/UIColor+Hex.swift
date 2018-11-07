//
//  UIColor+Hex.swift
//  Pods-RashMessage_Example
//
//  Created by Rachid Mahmoud on 07/11/2018.
//

import Foundation


extension UIColor {
    
    convenience init(hexa: String) {
        
        let hex = hexa.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanLocation = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
