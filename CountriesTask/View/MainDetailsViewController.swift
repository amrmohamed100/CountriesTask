//
//  MainDetailsViewController.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/13/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit

class MainDetailsViewController: UIViewController {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var captial: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    var countryData:String?
    var captialData:String?
    var currencyData:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        country.text = "CountryName: "  + (countryData ?? "")
        captial.text = "CaptialName: "  + (captialData ?? "")
        currency.text = "CurrencyName: "  + (currencyData ?? "")

    }
    

}

