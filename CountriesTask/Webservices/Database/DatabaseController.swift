//
//  DatabaseController.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseController {
    
    let realm = try! Realm()
    
    func save(countryname:Country) {
        
        
        try! realm.write {
            countryname.isFavourite = true
            realm.add(countryname ,update:.modified)
            
        }
    }
    
    func delete(countryname:Country)  {
        if (getSaved().contains(countryname)) {
        try? realm.write {
          realm.delete(countryname)
        }
        }
    }
    
    func getSaved() -> [Country] {
        let countries = realm.objects(Country.self).filter("isFavourite == true")
        
        return countries.toArray(ofType: Country.self)
    }
}
