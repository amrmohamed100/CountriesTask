//
//  CountryApiManger.swift
//  vod
//
//  Created by Amr Mohamed on 2/9/20.
//  Copyright © 2020 KARIM. All rights reserved.
//

import UIKit
import Alamofire


//Home Screen API's
enum CountryApiManger: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try Urls.base.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    //Plan API with plan id.
    case country(name:String)
    
    //specify method type for each api.
    var method:HTTPMethod{
        switch self {
        case .country:
            return .get
        }
    }
    //specify web path for each api
    var path:String{
        switch self {
        case .country(let name):
            return "/name/\(name)"
        }
    }
    
}
