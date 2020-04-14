//
//  MainTableViewCell.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/13/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

     @IBOutlet var countryName: UILabel!
     
     override func awakeFromNib() {
         super.awakeFromNib()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
     }
     
     //preparing UI of cell and adding data from view model.
     func prepareCell(model: Country){
         countryName.text = model.name
     }
    
}
