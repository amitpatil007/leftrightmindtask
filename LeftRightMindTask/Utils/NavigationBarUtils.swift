//
//  NavigationBarUtils.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import UIKit

class NavigationBarUtils {
    
    // setup navigationController with app custom setting
    public static func setupNavigationController (viewController: UIViewController) -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.navigationBar.shadowImage = UIImage()
                navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1405271888, green: 0.1678775847, blue: 0.292804271, alpha: 1)
                navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                navigationController.navigationBar.isTranslucent = false
                navigationController.navigationBar.isOpaque = true
                navigationController.navigationBar.layer.masksToBounds = false
      
                UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                return navigationController
        }
    
    public static func setupNavigationBar(navigationController:UINavigationController) {
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1405271888, green: 0.1678775847, blue: 0.292804271, alpha: 1)
        navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.layer.masksToBounds = false
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.orange
    }
    
    // setup transperant navigation bar
    public static func setTransperentNavigationBar(navigationController:UINavigationController) {
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
    }
    
    //Get previous view controller of the navigation stack
    public static func previousViewController(navigationController:UINavigationController) -> UIViewController?{
        let lenght = navigationController.viewControllers.count
        let previousViewController: UIViewController? = lenght >= 2 ? navigationController.viewControllers[lenght-2] : nil
        return previousViewController
    }
}
