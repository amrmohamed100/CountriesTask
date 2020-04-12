//
//  Currencies.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Currencies : Object, Codable {
    @objc dynamic var code : String?
    @objc dynamic var name : String?
    @objc dynamic var symbol : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case symbol = "symbol"
    }
    
    override class func primaryKey() -> String? {
        return "code"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
    }
}
