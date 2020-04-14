//
//  CountryViewModel.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit

class CountryViewModel: NSObject {
    
    var countries: [Country]?
    var originalCountriesList:[Country] = []
    private var networkController:CountryNetworkController
    var collapsed: Bool = true
    
    init(networkController:CountryNetworkController){
        self.networkController = networkController
    }
    
    //load plan details from API or offline
    func loadCountries(name: String, callback:@escaping (Bool) -> ()){
        networkController.getCountries(with: name) { (countries) in
            if countries != nil {
                self.countries = countries
                
                for country in countries! {
                    self.originalCountriesList.append(country)
                }
                
                callback(true)
            }else{
                return callback(false)
            }
        }
    }
    
    func rowCount() -> Int{
        if let countries = self.countries {
            return countries.count
        }
        return 0
    }
}
