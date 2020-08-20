////
////  APIHandler.swift
////  Kayak
////
////  Created by Xanthus Software Solutions on 13/08/20.
////  Copyright © 2020 Xanthus. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import MBProgressHUD
//
///// All web service call integration is implemented in APIHandler class. **NOTE:** Use only with singleton object. i.e. **APIHandler.sharedInstance**
//class APIHandler {
//    
//    // Returns the shared API Handler object for the process.
//    static let sharedInstance = APIHandler()
//    var firebaseToken = ""
//    var usingSocialMediaSignIn = false
//    
//    typealias CallbackType = (_ success: Bool, _ responseDict: [String: Any], _ error: Error?) -> Void
//    typealias CallbackType2 = (_ success: Bool, _ responseArray: [Any], _ error: Error?) -> Void
//    
//    struct Constants {
//        
//        //API Names
//        //=========
//        
//        #if DEBUG
//            fileprivate static let baseURL = "http://114.143.114.142:8084/APIV3/"//"http://114.143.114.142:8084/APIV1/"//"http://114.143.114.142:8084/API/"//"http://blufind.com/kayakwebapi/"
//        #else
//            fileprivate static let baseURL = "http://114.143.114.142:8084/APIV3/"//"http://blufind.com/kayakwebapi/"
//        #endif
//        
//        static let SocialMediaSignIn = "Login/SocialMediaSignIn"
//        static let SocialMediaSignVerifyOTP = "Login/SocialMediaSignVerifyOTP"
//        static let SendSocialMediaSignInOTP = "Login/SendSocialMediaSignInOTP"
//        static let ValidateSocialMediaUser = "Login/ValidateSocialMediaUser"
//        static let ClearCart = "/LandingDetails/ClearCart"
//        static let VerfiyItemsInCart = "LandingDetails/VerfiyHoldedItems"
//        static let GetCartDetails = "LandingDetails/GetCartDetails?UserID="
//        static let Logout = "Login/Logout"
//        static let GetIssueTypeListForPopup = "History/GetIssueTypeList?IsPopup=true"
//        static let CancelTransaction = "RequestLocker/CancelTransaction"
//        static let SaveReportIssueFromPopUp = "History/SaveReportIssueFromPopUp"
//        static let CancelItem = "RequestLocker/CancelItem"
//        static let SetFireBaseToken = "Login/SetFireBaseToken"
//        static let RemoveFromCart = "LandingDetails/AddToUnHold"
//        static let ItemCheckOut = "LandingDetails/ItemCheckOut"
//        static let AddToCart = "LandingDetails/AddToHold"
//        static let GetItemDetails = "LandingDetails/GetItemDetails"
//        static let FetchLocationList = "LandingDetails/GetLocationList"
//        static let RentalDetail = "History/RentalDetail?OrderNumber="
//        static let RentalHistory = "History/RentalHistory?UserId="
//        static let ReportHistory = "History/ReportHistory?UserId="
//        static let SaveReportIssue = "History/SaveReportIssue"
//        static let GetLockerList = "History/GetLockerList?LocationID="
//        static let GetIssueTypeList = "History/GetIssueTypeList"
//        static let GetLocationList = "History/GetLocationList"
//        static let ItemCheckIn = "CheckIn/ItemCheckIn"
//        static let GetCheckinLocation = "CheckIn/GetCheckinLocation"
//        static let GetCheckedInItems = "CheckIn/GetCheckedInItems"
//        static let GetUserProfileDetail = "Register/GetUserProfileDetail?UserID="
//        static let AddUserCardDetails = "Payment/AddUserCardDetails"
//        static let DeleteProfile = "Payment/DeleteProfile?UserId="
//        static let ViewUserCardDetails = "Payment/ViewUserCardDetails?UserId="
//        static let NotificationHistory = "History/NotificationHistory?UserId="
//        static let GetItemTypeList = "LandingDetails/GetItemTypeList"
//        static let SendLoginOTP = "Login/SendLoginOTP"
//        static let UpdateProfile = "Register/UpdateProfile"
//        static let SendSignUpOTP = "Register/SendSignUpOTP"
//        static let SignUpVerifyOTP = "Register/SignUpVerifyOTP"
//        static let SignUp = "Register/SignUp"
//        static let Login = "Login/SignIn"
//        
//        //Messages
//        //========
//        
//        static let AlertTitle = "Rent Me"
//        static let OkButton = "OK"
//    }
//    
//    
//    struct UserDefaultsKey {
//        static let UserName = "Username"
//        static let Password = "Password"
//        static let IsLoggedIn = "IsLoggedIn"
//        static let LoginModel = "Login_Model"
//    }
//    
//    
//    func doAPIPostCallForMethod(_ url: String, parameters: [String : Any]?, vc: UIViewController, callback: @escaping CallbackType) {
//        
//        MBProgressHUD.showAdded(to: vc.view, animated: true)
//        let url = "\(Constants.baseURL)\(url)"
//        let methodType = Alamofire.HTTPMethod.post
//        let encoding = JSONEncoding.prettyPrinted //Alamofire.ParameterEncoding.JSON
//        var headers = ["Authorization" : ""]
////        if let loginModel = APIHandler.sharedInstance.loginModel{
////            headers = ["Authorization" : loginModel.token]
////        }
//        
//        print("URL========>", url, "\nParameters=======>", parameters)
//        
//        Alamofire.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            MBProgressHUD.hide(for: vc.view, animated: true)
//            switch response.result {
//            case .success:
//                if let value = response.result.value, !(value as AnyObject).isKind(of: NSNull.self) {
//                    let mainDict = value as! [String: Any]
//                    print("The response=====>",mainDict)
//                    callback(true, mainDict, nil)
//                }
//            case .failure(let error):
//                if let errorResponse = String.init(data: response.data!, encoding: .utf8){
//                    let encodedString = errorResponse.data(using: .utf8, allowLossyConversion: false)
//                    do{
//                        if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: encodedString!){
//                            print("Error Model====>", errorModel)
//                            callback(true, ["ResultStatus": false], nil)
////                            Utilities.alertWithoutButtonAction(alertTitle: APIHandler.Constants.AlertTitle, alertMessage: errorModel.resultMessage, messageOnButton: APIHandler.Constants.OkButton, passViewController: vc)
//                        }else{
//                            Utilities.alertWithoutButtonAction(alertTitle: APIHandler.Constants.AlertTitle, alertMessage: error.localizedDescription, messageOnButton: APIHandler.Constants.OkButton, passViewController: vc)
//                        }
//                        
//                    }
//                }
//                print("Failed: \(error)")
//                //                callback(false, nil, error)
//                
//            }
//        }
//    }
//    
//    func doAPIPostCallForSocialMedia(_ url: String, parameters: [String : Any]?, vc: UIViewController, callback: @escaping CallbackType) {
//        
//        MBProgressHUD.showAdded(to: vc.view, animated: true)
//        let url = "\(Constants.baseURL)\(url)"
//        let methodType = Alamofire.HTTPMethod.post
//        let encoding = JSONEncoding.prettyPrinted //Alamofire.ParameterEncoding.JSON
//        var headers = ["Authorization" : ""]
////        if let loginModel = APIHandler.sharedInstance.loginModel{
////            headers = ["Authorization" : loginModel.token]
////        }
//        
//        print("URL========>", url, "\nParameters=======>", parameters)
//        
//        Alamofire.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            MBProgressHUD.hide(for: vc.view, animated: true)
//            switch response.result {
//            case .success:
//                if let value = response.result.value, !(value as AnyObject).isKind(of: NSNull.self) {
//                    let mainDict = value as! [String: Any]
//                    print("The response=====>",mainDict)
//                    callback(true, mainDict, nil)
//                }
//            case .failure(let error):
//                if let errorResponse = String.init(data: response.data!, encoding: .utf8){
//                    let encodedString = errorResponse.data(using: .utf8, allowLossyConversion: false)
//                    do{
//                        if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: encodedString!){
//                            print("Error Model====>", errorModel)
////                            callback(false,)
//                        }else{
//                            Utilities.alertWithoutButtonAction(alertTitle: APIHandler.Constants.AlertTitle, alertMessage: error.localizedDescription, messageOnButton: APIHandler.Constants.OkButton, passViewController: vc)
//                        }
//                        
//                    }
//                }
//                print("Failed: \(error)")
//                //                callback(false, nil, error)
//                
//            }
//        }
//    }
//    
//    func doAPIGetCallForMethod(_ url: String, view: UIView, callback: @escaping CallbackType) {
//        
//        MBProgressHUD.showAdded(to: view, animated: true)
//        let methodType = Alamofire.HTTPMethod.get
//        let encoding = JSONEncoding.default //Alamofire.ParameterEncoding.JSON
//        var headers = ["Authorization" : ""]
////        if let loginModel = APIHandler.sharedInstance.loginModel{
////            headers = ["Authorization" : loginModel.token]
////        }
//        let url = "\(Constants.baseURL)\(url)"
//        print("URL========>", url)
//        Alamofire.request(url, method: methodType, parameters: nil, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            
//            MBProgressHUD.hide(for: view, animated: true)
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let mainDict = value as! [String: Any]
//                    print("The response=====>",mainDict)
//                    callback(true, mainDict, nil)
//                }
//            case .failure(let error):
//                print("Failed: \(error)")
////                callback(false, nil, error)
//            }
//        }
//    }
//    
//    func doAPIPostCallForMethod2(_ url: String, view: UIView, parameters: [String : AnyObject]?, callback: @escaping CallbackType2) {
//        
//        MBProgressHUD.showAdded(to: view, animated: true)
//        let url = "\(Constants.baseURL)\(url)"
//        let methodType = Alamofire.HTTPMethod.post
//        let encoding = JSONEncoding.prettyPrinted //Alamofire.ParameterEncoding.JSON
//        var headers = ["Authorization" : ""]
////        if let loginModel = APIHandler.sharedInstance.loginModel{
////            headers = ["Authorization" : loginModel.token]
////        }
//        Alamofire.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            
//            MBProgressHUD.hide(for: view, animated: true)
//
//            switch response.result {
//            case .success:
//                if let value = response.result.value {
//                    let mainDict = value as! [Any]
//                    print("The response=====>",mainDict)
//                    callback(true, mainDict, nil)
//                }
//            case .failure(let error):
//                print("Failed: \(error)")
//                //                callback(false, nil, error)
//                
//            }
//        }
//    }
//    
//    func pushNotificationActionMethod(_ url: String, parameters: [String : Any]?, callback: @escaping CallbackType) {
//        
//        let url = "\(Constants.baseURL)\(url)"
//        let methodType = Alamofire.HTTPMethod.post
//        let encoding = JSONEncoding.prettyPrinted //Alamofire.ParameterEncoding.JSON
//        var headers = ["Authorization" : ""]
////        if let loginModel = APIHandler.sharedInstance.loginModel{
////            headers = ["Authorization" : loginModel.token]
////        }
//        
//        print("URL========>", url, "\nParameters=======>", parameters)
//        
//        Alamofire.request(url, method: methodType, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
//            switch response.result {
//            case .success:
//                if let value = response.result.value, !(value as AnyObject).isKind(of: NSNull.self) {
//                    let mainDict = value as! [String: Any]
//                    print("The response=====>",mainDict)
//                    callback(true, mainDict, nil)
//                }
//            case .failure(let error):
//                if let errorResponse = String.init(data: response.data!, encoding: .utf8){
//                    let encodedString = errorResponse.data(using: .utf8, allowLossyConversion: false)
//                    do{
//                        if let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: encodedString!){
//                            print("Error Model====?", errorModel)
//                        }else{
//                            print("Push Notification API failed:",error.localizedDescription)
//                        }
//                        
//                    }
//                }
//                print("Failed: \(error)")
//                //                callback(false, nil, error)
//                
//            }
//        }
//    }
//}
//
