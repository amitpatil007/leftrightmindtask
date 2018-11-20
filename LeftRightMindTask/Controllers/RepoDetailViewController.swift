//
//  RepoDetailViewController.swift
//  
//
//  Created by Admin on 11/07/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import UIKit

class RepoDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var barButtonTitle1: UIBarButtonItem!
    @IBOutlet var barButtonTitle2: UIBarButtonItem!
    
    var repoUrl = ""
    var navTitle = ""
    var repoDataArray = [RepoData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
    
        self.getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navItem.title = navTitle
        navBar.barTintColor = #colorLiteral(red: 0.1058823529, green: 0.1215686275, blue: 0.2274509804, alpha: 1)
        navBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navBar.isTranslucent = false
        navBar.isOpaque = true
        navBar.layer.masksToBounds = false

        navBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navBar.layer.shadowOpacity = 0.2
        navBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        navBar.layer.shadowRadius = 2
        
        
    }

    
    // Api call
    func getUserData(){
        
        if (self.repoUrl != nil){
            self.view.showLoading()
            APIManager.repoDataApi(url: repoUrl, completion: { (apiSuccess, repoObj, apiErrror) in
                    self.view.dissmissLoading()
                    if ((repoObj) != nil){
                        
                        self.repoDataArray.append(repoObj!)
                    }
                    self.tableView.reloadData()
            })

        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        let alertCon = UIAlertController(title: "LOGOUT", message: "Do you want to logout from the app", preferredStyle: .alert)
        alertCon.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alertCon.addAction(UIAlertAction(title: "Logout", style: .default) {_ in
            self.setUpHomeScreen()
        })
        self.present(alertCon, animated: true, completion: nil)
    }
    
    func setUpHomeScreen() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let loginViewController = UIStoryboard.Main().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        appDelegate.window?.rootViewController = NavigationBarUtils.setupNavigationController(viewController: loginViewController)
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:RepoDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RepoDetailTableViewCell") as! RepoDetailTableViewCell
        let repoObj = self.repoDataArray[indexPath.row]
        cell.nameLabel.text = repoObj.name
        cell.descLabel.text = repoObj.desc
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }

  
}

class RepoDetailTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

}


