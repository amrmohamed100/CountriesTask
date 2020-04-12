//
//  Country.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit
class Country : Object, Codable {
    var currencies = List<Currencies>()
    @objc dynamic var name : String?
    @objc dynamic var capital : String?
    @objc dynamic var isFavourite:Bool = false

    enum CodingKeys: String, CodingKey {

        case currencies = "currencies"
        case name = "name"
        case capital = "capital"
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let currencies = try values.decodeIfPresent([Currencies].self, forKey: .currencies)
        self.currencies.append(objectsIn: currencies!)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        capital = try values.decodeIfPresent(String.self, forKey: .capital)
    }
}
