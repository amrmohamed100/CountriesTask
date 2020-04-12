//
//  CountryNetworkController.swift
//  vod
//
//  Created by Amr Mohamed on 2/9/20.
//  Copyright © 2020 KARIM. All rights reserved.
//

import UIKit
import RealmSwift

//Home Network Controller for calling Home Screen api.
class CountryNetworkController {

    private let decoder = JSONDecoder()
    private let networkManager = NetworkManager()
    
    func getCountries(with name:String,callback: @escaping (([Country]?) -> Void)){
        
        let request = CountryApiManger.country(name: name)
        
        //initializing Realm
        let realm = try! Realm()
        
        //if no internet fetch the data which saved
        
        if Connectivity.isConnected() {
            networkManager.request(request) { (data:[Country]?, error) in
                
                guard let result = data else{ return callback(nil)}
                // Persist your data easily
                try! realm.write {
                    for country in result {
                       realm.add(country ,update:.modified)
                    }
                }
                return callback(result)
            }
        }else{
            let countries = realm.objects(Country.self)
            if countries.count > 0{
                callback(countries.sorted(byKeyPath: "name").toArray(ofType: Country.self))
            }else{
                callback(nil)
            }
        }
        
    }
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
