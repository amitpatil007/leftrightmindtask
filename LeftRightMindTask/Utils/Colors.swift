//
//  Colors.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import UIKit

/*
 1. All the color constants goes here.
*/

extension UIColor {
    
    convenience init(hexString: String) {
        
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        
        switch hex.count {
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
    
    static func colorPrimary() -> UIColor {
        return UIColor(hexString: "#3F51B5")
    }
    
    static func colorPrimaryDark() -> UIColor {
        return UIColor(hexString: "#1b1f3a")
    }
    
    static func colorAccent() -> UIColor {
        return UIColor(hexString: "#64637c")
    }
    
    static func whiteColor() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    static func floatLoginLabel() -> UIColor {
        return UIColor(hexString: "#bbc3ce")
    }
    
    static func dialogLoginUP() -> UIColor {
        return UIColor(hexString: "#4c526a")
    }
    
    static func dialogColor() -> UIColor {
        return UIColor(hexString: "#4c526a")
    }
    
    static func blackColor() -> UIColor {
        return UIColor(hexString: "#000000")
    }
    
    static func textBackclr() -> UIColor {
        return UIColor(hexString: "#7f85a9")
    }
    
    static func pinkColor() -> UIColor {
        return UIColor(hexString: "#ced0da")
    }
    
    static func textColorPrimary() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    static func windowBackground() -> UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    
    static func navigationBarColor() -> UIColor {
        return UIColor(hexString: "#000000")
    }
    
    static func managerAttendanceLeaveBG() -> UIColor {
        return UIColor(hexString: "#f3f3f3")
    }
    
    static func managerAttendanceLeaveBGBtn() -> UIColor {
        return UIColor(hexString: "#cfd5f9")
    }
    
    static func summer() -> UIColor {
        return UIColor(hexString: "#414768")
    }
    
    static func fall() -> UIColor {
        return UIColor(hexString: "#44d8d27e")
    }
    
    static func winter() -> UIColor {
        return UIColor(hexString: "#44a1c1da")
    }
    
    static func spring() -> UIColor {
        return UIColor(hexString: "#448da64b")
    }
    
    static func today() -> UIColor {
        return UIColor(hexString: "#4b82ff")
    }
    
    static func greyedOut() -> UIColor {
        return UIColor(hexString: "#c7c7c7")
    }
    
    static func radioButtonColor() -> UIColor {
        return UIColor(hexString: "#4d516a")
    }
    
    static func pinkColorColor() -> UIColor {
        return UIColor(hexString: "#df3ec0")
    }
    
    // <!--leave application-->
    static func radioButtonTint() -> UIColor {
        return UIColor(hexString: "#292d47")
    }
    
    static func textColorHint() -> UIColor {
        return UIColor(hexString: "#4d5065")
    }
    
    static func approverHirarchyColor() -> UIColor {
        return UIColor(hexString: "#7fd36c")
    }
    
    static func backgroundApp() -> UIColor {
        return UIColor(hexString: "#f1f1f1")
    }
    
    // <!--    out duty-->
    static func backgroundTint() -> UIColor {
        return UIColor(hexString: "#757786")
    }
    
    static func lightGray() -> UIColor {
        return UIColor(hexString: "#e7e7e7")
    }
    
    static func redColor() -> UIColor {
        return UIColor(hexString: "#ff0000")
    }
    
    static func calenderColor() -> UIColor {
        return UIColor(hexString: "#2E86C1")
    }
    
    
}
