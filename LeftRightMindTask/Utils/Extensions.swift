//
//  Extensions.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import UIKit

/*
 1. All the Common custom function/extensions goes here.
*/

protocol OptionalType {
    associatedtype Wrapped
    func intoOptional() -> Wrapped?
}

extension Optional : OptionalType {
    func intoOptional() -> Wrapped? {
        return self
    }
}


extension Dictionary where Value: OptionalType {
    func filterNil() -> [Key: Value.Wrapped] {
        var result: [Key: Value.Wrapped] = [:]
        for (key, value) in self {
            if let unwrappedValue = value.intoOptional() {
                result[key] = unwrappedValue
            }
        }
        return result
    }
    
    // A dictionary wrapper that unwraps optional values in the dictionary literal
    // that it's created with.
    struct ValueUnwrappingLiteral : ExpressibleByDictionaryLiteral {
        
        typealias WrappedValue = Dictionary.Value
        
        fileprivate let base: [Key : WrappedValue]
        
        init(dictionaryLiteral elements: (Key, WrappedValue?)...) {
            
            var base = [Key : WrappedValue]()
            
            // iterate through the literal's elements, unwrapping the values,
            // and updating the base dictionary with them.
            for case let (key, value?) in elements {
                
                if base.updateValue(value, forKey: key) != nil {
                    // duplicate keys are not permitted.
                    fatalError("Dictionary literal may not contain duplicate keys")
                }
            }
            
            self.base = base
        }
    }
    
    init(unwrappingValues literal: ValueUnwrappingLiteral) {
        self = literal.base // simply get the base of the unwrapping literal.
    }
}

extension CGFloat {
    // return random number
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension CAShapeLayer {
    func drawRoundedRect(rect: CGRect, andColor color: UIColor, filled: Bool) {
        fillColor = filled ? color.cgColor : UIColor.white.cgColor
        strokeColor = color.cgColor
        path = UIBezierPath(roundedRect: rect, cornerRadius: 7).cgPath
    }
    
}

extension UIViewController {
    func flipTheView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                    }
                }
                flipTheView(subviews: subView.subviews)
            }
        }
    }
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

