//
//  NetworkManager.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let decoder  = JSONDecoder()
}

//Generic Network class for calling all web api's
extension NetworkManager{
    
    @discardableResult func request<T:Decodable>(_ request:URLRequestConvertible,
                                                 showLoader:Bool = true,
                                                 parserCallback:((Codable) throws -> (Data))? = nil,
        completion:@escaping (T?, RequestError?) -> Void) -> DataRequest? {
        
        if showLoader{
            //SVProgressHUD.show()
        }
        
        return AF.request(request)
                 .validate()
                 .responseJSON { (response) in
                //SVProgressHUD.dismiss()
                switch response.result {
                    
                case .success:
                   do{
                    let decoder = JSONDecoder()
                    //decoder.fragmentDecodingStrategy = .allow // here
                    let response = try decoder.decode(T.self, from: response.data!)
                    completion(response, nil)
                    print(response)
                    }catch(let error){
//                        //SVProgressHUD.showError(withStatus: error.localizedDescription)

                        return completion(nil,RequestError.init(userMessage: error.localizedDescription,cause: NSError.init(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription])))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    //SVProgressHUD.showError(withStatus: error.localizedDescription)
                    return completion(nil,RequestError.init(userMessage: error.localizedDescription,cause: NSError.init(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription])))
                }
        }
    }
}
class Connectivity {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
