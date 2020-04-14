//
//  CountryCell.swift
//  Countries
//
//  Created by Amr Mohamed on 4/11/20.
//  Copyright © 2020 Amr. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet var currencyCode: UILabel!
    @IBOutlet var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //preparing UI of cell and adding data from view model.
    func prepareCell(model: Country){
        currencyCode.text = model.currencies.first?.code
        countryName.text = model.capital
    }
}
