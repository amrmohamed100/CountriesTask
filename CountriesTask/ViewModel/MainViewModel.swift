//
//  MainViewModel.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import Foundation

class MainViewModel: NSObject {
    
    var countries: [Country] = []
    private var dataBaseController:DatabaseController
    
        init(dataBaseController:DatabaseController){
            self.dataBaseController = dataBaseController
        }
    func save(countryName:Country)   {
        dataBaseController.save(countryname: countryName)
    }
    
    func getSavedCountries() {
        
        countries.append(contentsOf: dataBaseController.getSaved())
    }
    
    func deleteCountries(countryName:Country) {
        
        dataBaseController.delete(countryname: countryName)
    }
    
    func rowCount() -> Int{
        
        return countries.count
        
    }
}
