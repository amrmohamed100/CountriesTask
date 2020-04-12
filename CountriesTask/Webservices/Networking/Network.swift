//
//  Network.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

struct Network {
    let request:URLRequestConvertible
    let method:HTTPMethod
    let params:[String:String] = [:]
}
struct RequestError{
    var userMessage:String
    var cause:NSError
}
