//
//  APIManager.swift
//  emSphere
//
//  Created by Admin on 17/08/18.
//  Copyright © 2018 Amit Patil. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Internet Reachablity Test
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

// no network error obj.
var internetError: APIError {
    let error = APIError()
    error.errorCode = "\(3060)"
    error.errorTitle = "Network error"
    error.errorDescription = "Unable to connect, please check your internet connectivity."
    return error
}

class APIManager {
    
    class func userApi(param: Dictionary<String, Any>,url: String, completion: @escaping(Bool, [String]?, APIError?) -> Void) {

    //internet check
    if !Connectivity.isConnectedToInternet() {
        completion(false,nil,internetError)
        return
    }
        
    // Alamofire.request
    Alamofire.request(url, method: .get, parameters:param  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
        switch response.result {
            
        case .success(let value):
            
            let swiftyJsonVar = JSON(response.result.value!)
            let dic = swiftyJsonVar.dictionary
            let arrayOfDic = dic!["items"]?.arrayValue
            var reopurlArray = [String]()
            
            for dic1 in arrayOfDic! {
                if let repoUrl = dic1["url"].string {
                reopurlArray.append(repoUrl)
                }
            }
            completion(true,reopurlArray, nil)

        case .failure(let encodedError):
            
            let error = APIError(error: encodedError as NSError)
            completion(false,nil,error)
        }
    }
}

class func userDataApi(url: String, completion: @escaping(Bool,User?, APIError?) -> Void) {

    //internet check
    if !Connectivity.isConnectedToInternet() {
        completion(false,nil,internetError)
        return
    }
    
    // Alamofire.request
    Alamofire.request(url, method: .get, parameters:nil  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
        
        switch response.result {
            
        case .success(let value):
            
            let swiftyJsonVar = JSON(response.result.value!)
      
            if  let dic = swiftyJsonVar.dictionary{

                let userObj = User()
                userObj.avatar_url = dic["avatar_url"]?.string ?? ""
                userObj.repos_url = dic["repos_url"]?.string ?? ""
                userObj.location = dic["location"]?.string ?? ""
                userObj.bio = dic["bio"]?.string ?? ""
                userObj.name = dic["name"]?.string ?? ""
                userObj.created_at = dic["created_at"]?.string ?? ""
            
                if (userObj != nil){
                    
                }
                completion(true,userObj, nil)
                
            } else {
              completion(true,nil, nil)
            }

        case .failure(let encodedError):
            print(encodedError)
            let error = APIError(error: encodedError as NSError)
            completion(false,nil,error)
        }
    }
}

 // for getting detail repo url
 class func repoDataApi(url: String, completion: @escaping(Bool,RepoData?, APIError?) -> Void) {

        //internet check
        if !Connectivity.isConnectedToInternet() {
            completion(false,nil,internetError)
            return
        }
    
    Alamofire.request(url, method: .get, parameters:nil  ,encoding: URLEncoding.default, headers: nil).responseJSON{ response in
    switch response.result {
    case .success(let value):
        
    let swiftyJsonVar = JSON(response.result.value!)

    let arrayOfDic = swiftyJsonVar.arrayValue
        for dic in arrayOfDic {
            let repoObj = RepoData()
            repoObj.name = dic["name"].string ?? ""
            repoObj.desc = dic["description"].string ?? ""
            completion(true,repoObj, nil)
        }

    case .failure(let encodedError):
    print(encodedError)
    let error = APIError(error: encodedError as NSError)
    completion(false,nil,error)
    }
    }
}

} // end of class

