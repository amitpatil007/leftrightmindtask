//
//  ViewUtils.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
import PKHUD

/*
 1. All the UIView related common custom function goes here.
 */

extension ACFloatingTextfield {
    func setupTheme(_ placeholder: String) {
        self.placeholder = placeholder
        self.placeHolderColor = UIColor.white
        self.textColor = UIColor.white
        self.selectedPlaceHolderColor = UIColor.floatLoginLabel()
        self.lineColor = UIColor.black
        self.selectedLineColor = UIColor.colorAccent()
        self.font = UIFont(name: "roboto.regular", size: 15.0)
    }
}

extension UILabel {
    func customisedAttributedString(_ text: String, range1: Int, color1: UIColor, font1: UIFont, range2: Int, color2: UIColor, font2: UIFont  ) {
        let customisedString = NSMutableAttributedString(string: text)
        customisedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color1, range:NSRange(location: 0, length: range1))
        customisedString.addAttribute(NSAttributedStringKey.font, value:font1 , range: NSRange(location: range1, length: range1))
        customisedString.addAttribute(NSAttributedStringKey.foregroundColor, value: color2, range:NSRange(location: range1, length: range2))
        customisedString.addAttribute(NSAttributedStringKey.font, value:font2 , range: NSRange(location: range1, length: range2))
        self.attributedText = customisedString
    }
    
}

extension UITextField {
    func customisedPlaceholder(_ placeholder: String) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.gray, range:NSRange(location: 0, length: placeholder.count))
        customisedPlaceholder.addAttribute(NSAttributedStringKey.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        // Add attribute//UIFont.systemFont(ofSize: 14)
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func customisedPlaceholder(_ placeholder: String, placholderColor: UIColor) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedStringKey.foregroundColor, value: placholderColor, range:NSRange(location: 0, length: placeholder.count))
        customisedPlaceholder.addAttribute(NSAttributedStringKey.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        // Add attribute//UIFont.systemFont(ofSize: 14)
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func customisedPlaceholder(_ placeholder: String, primaryColor: UIColor, secondaryColor: UIColor) {
        let customisedPlaceholder = NSMutableAttributedString(string: placeholder)
        customisedPlaceholder.addAttribute(NSAttributedStringKey.foregroundColor, value: primaryColor, range:NSRange(location: 0, length: placeholder.count - 1))
        customisedPlaceholder.addAttribute(NSAttributedStringKey.foregroundColor, value: secondaryColor, range:NSRange(location: placeholder.count - 1, length: 1))
        customisedPlaceholder.addAttribute(NSAttributedStringKey.font, value:UIFont.init(name: Font.appRegularFont, size: 16)! , range: NSRange(location: 0, length: placeholder.count))
        self.attributedPlaceholder = customisedPlaceholder
    }
    
    func setRightView(_ icon: UIImage){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = CGPoint(x: (view.frame.size.width - 10)/2, y: view.frame.size.height/2)
        imageView.image = icon
        imageView.contentMode = .center
        view.addSubview(imageView)
        self.rightViewMode = .always
        self.rightView = view
    }
    
    //set right view
    func setLeftView(_ icon: UIImage) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 35))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = CGPoint(x: (view.frame.size.width)/2, y: view.frame.size.height/2)
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        self.leftViewMode = .always
        self.leftView = view
    }
}

extension UIView {
    
    // set color to status bar
    func setStatusBarBackgroundColor(color: UIColor) {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
            else {
                return
        }
        statusBar.backgroundColor = color
    }
    
    func makeCircular() {
        self.layer.cornerRadius = 0.5*self.bounds.size.width
        self.clipsToBounds = true
    }

    // make filled circular view
    func addFilledCircle(fillColor: UIColor, outlineColor:UIColor) {
        let circleLayer = CAShapeLayer()
        let width = Double(self.bounds.size.width);
        let height = Double(self.bounds.size.height);
        circleLayer.bounds = CGRect(x: 2.0, y: 2.0, width: width-2.0, height: height-2.0)
        circleLayer.position = CGPoint(x: width/2 - 2, y: height/2 - 2);
        
        let rect = CGRect(x: 4.0, y: 4.0, width: width-4.0, height: height-4.0)
        let path = UIBezierPath.init(ovalIn: rect)
        circleLayer.path = path.cgPath
        circleLayer.fillColor = fillColor.cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = outlineColor.cgColor
        self.layer.addSublayer(circleLayer)
    }
    
    // make round corner
    func roundCorners(corners:UIRectCorner,cornerRadii: CGSize) {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii:cornerRadii).cgPath
        self.layer.mask = rectShape
    }
    
    // Error Toast
    func showErrorMessage(message: String) {
        let error = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        error.configureTheme(.error)
        error.titleLabel?.isHidden = true
        error.button?.isHidden = true
        error.configureContent(body: message)
        SwiftMessages.show(config: config, view: error)
    }
    
    // show loading overlay over current view
    func showLoading(message:String = "") {
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
        HUD.show(.progress)
    }
    
    // dissmiss loading view from current view
    func dissmissLoading (isSuccess:Bool = true) {
        HUD.hide()
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
}

extension UIButton {
    func set(fontSize: CGFloat) {
        if let titleLabel = titleLabel {
            titleLabel.font = UIFont(name: titleLabel.font.fontName, size: fontSize)
        }
    }
}
