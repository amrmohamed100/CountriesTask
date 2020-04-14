//
//  CountryVC.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit

class CountryVC: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView:UITableView!
    
    var searchViewModel:CountryViewModel?
    weak var delegate : CountryDelegate?
    
    private var networkController = CountryNetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Country"
        
        searchViewModel = CountryViewModel(networkController: networkController)
        self.searchField.delegate = self
        searchField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        setUpTableview()
        
    }
    
    func setUpTableview() {
        tableView.register(UINib(nibName: String(describing: CountryCell.self), bundle: nil), forCellReuseIdentifier: "CountryCell")
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView()
    }
    
    //reload table section on orientations
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
}

extension CountryVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchViewModel?.loadCountries(name:textField.text ?? "") { (fetched) in
                            if fetched {
                                self.tableView.reloadData()
                            }
                        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       searchViewModel?.loadCountries(name:textField.text ?? "") { (fetched) in
                     if fetched {
                         self.tableView.reloadData()
                     }
                 }
        return false
    }
    
    @objc func searchRecords(_ textField: UITextField) {
        self.searchViewModel?.countries?.removeAll()
          if textField.text?.count != 0 {
            for country in searchViewModel!.originalCountriesList {
                  if let countryToSearch = textField.text{
                    let range = country.capital!.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                      if range != nil {
                        self.searchViewModel?.countries?.append(country)
                      }
                  }
              }
          } else {
            for country in searchViewModel!.originalCountriesList {
                searchViewModel?.countries?.append(country)
              }
          }
          
        self.tableView.reloadData()
      }
}

extension CountryVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel!.rowCount()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        searchViewModel!.rowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country = searchViewModel!.countries![indexPath.row]
        cell.prepareCell(model: country)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCountries(countryName: (searchViewModel?.countries?[indexPath.row])!)
        self.navigationController?.popViewController(animated: true)
    }
    
}
