//
//  LoginViewController.swift
//  
//
//  Created by Admin on 16/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    //MARK:- Properties
    var loginDetails: [String: Any]? = nil

    //MARK: - IBOutlets
    @IBOutlet var emailTextField: ACFloatingTextfield!
    @IBOutlet var passwordTextField: ACFloatingTextfield!
    @IBOutlet var rembrMeCheckBoxBtn: UIButton!
    @IBOutlet var rememberMeBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        NavigationBarUtils.setTransperentNavigationBar(navigationController: self.navigationController!)
        
        loginDetails = UserProfile.getRemeberMe()
        print("login array :",loginDetails)
        
        self.setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginBtn.roundCorners(corners: .allCorners, cornerRadii: CGSize(width: loginBtn.frame.size.height/2, height: loginBtn.frame.size.height/2))
    }

    //MARK: Functions and Related callbacks
    func setupView() {
        
        emailTextField.setupTheme("Username")
        emailTextField.isContainLeftIcon = true
        emailTextField.setLeftView(#imageLiteral(resourceName: "icon_user"))
        
        passwordTextField.setupTheme("Password")
        passwordTextField.isContainLeftIcon = true
        passwordTextField.setLeftView(#imageLiteral(resourceName: "icon_password"))
        passwordTextField.isSecureTextEntry = true
        
        rembrMeCheckBoxBtn.setImage(#imageLiteral(resourceName: "unchecked-unfilled"), for: .selected)

        guard let loginData = loginDetails else {
            print("loginDetails")
            return
        }

        emailTextField.text = loginData["email"] as? String
        passwordTextField.text = loginData["password"] as? String
        rembrMeCheckBoxBtn.isSelected = true
        rembrMeCheckBoxBtn.setImage(#imageLiteral(resourceName: "checkbox-filled"), for: .selected)
        
    }

    //MARK: Remember Me IBActions
    @IBAction func rememberMeAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            rembrMeCheckBoxBtn.isSelected = false
            rembrMeCheckBoxBtn.setImage(#imageLiteral(resourceName: "unchecked-unfilled"), for: .normal)
        }
        else {
            sender.isSelected = true
            rembrMeCheckBoxBtn.isSelected = true
            rembrMeCheckBoxBtn.setImage(#imageLiteral(resourceName: "checkbox-filled"), for: .selected)
        }

    }

    //MARK: Login IBActions
    @IBAction func loginAction(_ sender: UIButton) {
        
        if !validate(){
            
            if emailTextField.text?.validEmail == true {
                
                if rembrMeCheckBoxBtn.isSelected {
                    let loginDetails: [String: Any] = ["email": emailTextField.text!, "password": passwordTextField.text!]
                    print(loginDetails)
                    UserProfile.saveRememberMe(userInfo: loginDetails)
                    
                } else {
                    if UserDefaults.standard.value(forKey: "LOGIN_DATA") != nil {
                        UserDefaults.standard.removeObject(forKey: "LOGIN_DATA")
                    }
                    UserDefaults.standard.synchronize()
                }
                
                let defaults = UserDefaults.standard
                defaults.bool(forKey: "isRegistered")
                let userListView = UIStoryboard.Main().instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
                self.present(userListView, animated: true, completion: nil)
                
            } else {
                emailTextField.showErrorWithText(errorText: "")
                self.view.showErrorMessage(message: "Please enter valid email.")
            }

        }


    }
    
    //validate
    func validate() -> Bool {
        
        if emailTextField.text == "" {
            emailTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter email.")
            return true
        }else if passwordTextField.text == ""{
            passwordTextField.showErrorWithText(errorText: "")
            self.view.showErrorMessage(message: "Please enter password.")
            return true
        }
        return false
    }
    
}
