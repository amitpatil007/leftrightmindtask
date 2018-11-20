//
//  UserListViewController.swift
//  
//
//  Created by Admin on 17/11/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate{

    var expandedRows = Set<Int>()
    var userArray = [User]()
    var filteredArray = [User]()
    var searchActive : Bool = false
    let inputFormatter = DateFormatter()

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        searchBar.placeholder = "Github Users"
        searchBar.delegate = self
        self.searchBar.returnKeyType = UIReturnKeyType.default

        self.getUserData()
    }
    
    // Api call
    func getUserData(){

        let parameters = ["q": "location:india", "sort": "stars", "order": "desc", "page": "1","p er_page":"100"]
        
        self.view.showLoading()
        APIManager.userApi(param: parameters, url: "https://api.github.com/search/users") { (success,reopUrlArr, error) in
            self.view.dissmissLoading()
            if let repoUrlArray =  reopUrlArr{
                for url in repoUrlArray {
                    APIManager.userDataApi(url: url, completion: { (apiSuccess, userObj, apiErrror) in
                        if ((userObj) != nil){
                            self.userArray.append(userObj!)
                        }
                        self.tableView.reloadData()
                })

             }
                
            }
        }
    }

    @IBAction func expandButtonAction(_ sender: UIButton) {
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if (sender.isSelected == true){
            print("Expandedd")
            sender.isSelected = false
            guard let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell
                else { return }

            self.expandedRows.remove(indexPath.row)

            cell.isExpanded = false

            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
        else{
            
            sender.isSelected = true
            print("Collapsed")

            guard let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell
                else { return }

            switch cell.isExpanded
            {
            case true:
                self.expandedRows.remove(indexPath.row)
            case false:
                self.expandedRows.insert(indexPath.row)
            }
            cell.isExpanded = !cell.isExpanded
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }


    }
    
    // TableView DataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (searchActive && self.searchBar.text != "") {
            return self.filteredArray.count
        }else {
        return self.userArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell

        var userObj = User()

        if (self.searchActive && self.searchBar.text != "") {
            userObj = filteredArray[indexPath.row]
        }
        else{
            
            self.userArray.sort() { $0.name < $1.name }
            userObj = self.userArray[indexPath.row]
        }
       
        cell.nameLabel.text = userObj.name
        cell.bioLabel.text = userObj.bio
        cell.locationLabel.text = userObj.location
        
        let dateStr = String(userObj.created_at.prefix(10))
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: dateStr)
        inputFormatter.dateFormat = "MM/dd/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        
        cell.createdAtLabel.text = resultString
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        cell.exapandButton.tag = indexPath.row
        cell.profileImageView.image = #imageLiteral(resourceName: "avatar-placeholder")
        
        if ((userObj.profileImage) != nil){
            cell.profileImageView.image = userObj.profileImage
        }else {

            DispatchQueue.global().async {
                Alamofire.request(userObj.avatar_url).responseImage { response in
                    debugPrint(response.result)
                    if let image = response.result.value {
                        userObj.profileImage = image
                        DispatchQueue.main.async {
                            cell.profileImageView.image = image
                        }
                    }
                }
            }

        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
    
    // TableView Delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let userObj = self.userArray[indexPath.row]
        let repoVc = UIStoryboard.Main().instantiateViewController(withIdentifier: "RepoDetailViewController") as! RepoDetailViewController
        repoVc.repoUrl = userObj.repos_url
        repoVc.navTitle = userObj.name
        self.present(repoVc, animated: true, completion: nil)
       
    }
 
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            searchActive = false
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.characters.count > 0{
            searchActive = true
        }else{
            searchActive = false
        }
        
        filteredArray = userArray.filter({ (aObject:User) -> Bool in
            return (aObject.name.lowercased().range(of: searchText.lowercased()) != nil)//
        })

        self.tableView.reloadData()
    }

}


class UserTableViewCell: UITableViewCell {
    
    @IBOutlet var exapandButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet weak var exapandableView: UIView!
    @IBOutlet weak var exapandableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var createdAtLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var bioLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeCircular()
    }

    var isExpanded:Bool = false
    {
        didSet
        {
            if !isExpanded {
                self.exapandableViewHeightConstraint.constant = 0.0
                
            } else {
                self.exapandableViewHeightConstraint.constant = 80.0
            }
        }
    }
    
}


