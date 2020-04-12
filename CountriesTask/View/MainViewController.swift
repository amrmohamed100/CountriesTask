//
//  MainViewController.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit
import CoreLocation

protocol CountryDelegate: class {
    func getCountries(countryName: Country)
    
}

class MainViewController: UIViewController, CountryDelegate {
    @IBOutlet weak var countryTableview: UITableView!
     var mainViewModel:MainViewModel?
    
    var selectedCountry:Country?
    var arrayCountry:[Country] = []
    var counter:Int?
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dataBaseController = DatabaseController()
        
        mainViewModel = MainViewModel(dataBaseController: dataBaseController)
                
        countryTableview.delegate = self
        countryTableview.dataSource = self
        
        countryTableview.register(UINib(nibName: String(describing: MainTableViewCell.self), bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
         self.countryTableview.estimatedRowHeight = 60
         self.countryTableview.rowHeight = UITableView.automaticDimension
        mainViewModel?.getSavedCountries()
        countryTableview.reloadData()

        locationManager.requestAlwaysAuthorization()
         locationManager.delegate = self
               if CLLocationManager.locationServicesEnabled() {
                  
                   locationManager.startMonitoringSignificantLocationChanges()
               }
        
        setAddBtn()
        // Do any additional setup after loading the view.
    }
    
    func setAddBtn() {
             let doneBtn = UIButton()
             doneBtn.setTitle("Add", for: .normal)
           doneBtn.tintColor = .red
             doneBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
             doneBtn.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
             
             self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
         }
         
         @objc func handleClick() {
//           counter = counter + 1
            
           let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let vc: CountryVC = storyboard.instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
            vc.delegate = self
           self.navigationController?.pushViewController(vc, animated: true)
         }
    
    func getCountries(countryName: Country) {
        self.selectedCountry = countryName
        mainViewModel?.countries.append(countryName)
        mainViewModel?.save(countryName: countryName)
        countryTableview.reloadData()
        
       }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel?.rowCount() ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        let country = mainViewModel!.countries[indexPath.row]
           cell.prepareCell(model: country)
           return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
let modelToRemove = mainViewModel!.countries[indexPath.row]
        self.mainViewModel?.countries.remove(at: indexPath.row)
        mainViewModel?.deleteCountries(countryName:modelToRemove)
        self.countryTableview.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: MainDetailsViewController = storyboard.instantiateViewController(withIdentifier: "MainDetailsViewController") as! MainDetailsViewController
        vc.countryData = mainViewModel?.countries[indexPath.row].name
        vc.captialData = mainViewModel?.countries[indexPath.row].capital
        vc.currencyData = mainViewModel?.countries[indexPath.row].currencies.first?.code
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController:  CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else { return }
            print(currentLocPlacemark.country ?? "No country found")
            print(currentLocPlacemark.isoCountryCode ?? "No country code found")
            let country = Country()
            country.name  = currentLocPlacemark.country
            self.mainViewModel?.countries.append(country)
            self.countryTableview.reloadData()
        }
    }
}
