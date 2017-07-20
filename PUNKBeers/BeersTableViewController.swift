//
//  BeersTableViewController.swift
//  PUNKBeers
//
//  Created by Claudio Cruz on 19/07/17.
//  Copyright © 2017 ClaudioCruz. All rights reserved.
//

import UIKit
import CoreData


class BeersTableViewController: UITableViewController {

    var beerResponse: [Beer] = []
    var lastPageCalled: Int = 0
    var isGettingBeers: Bool = false
    var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator()
        loadDataBeers(beerPage: 1)
    }
    
    func loadDataBeers(beerPage: Int){
        self.isGettingBeers = true
        PunkAPI.getBeers(beerPage: beerPage) { (beers: [Beer]?) in
            if let beers = beers {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.beerResponse.insert(contentsOf: beers, at: self.beerResponse.count)
                self.lastPageCalled = beerPage
                self.tableView.reloadData()
                self.isGettingBeers = false
            }
        }
        
    }
    
    func activityIndicator() {
        self.indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.indicator.clipsToBounds = true
        self.indicator.center = self.view.center
        self.view.addSubview(indicator)
        self.indicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerResponse.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let lastLines = self.beerResponse.count - 5
        if  (indexPath.row > lastLines && !self.isGettingBeers) {
            let newBeerPage = self.lastPageCalled + 1
            print("newBeerPage: \(newBeerPage)")
            loadDataBeers(beerPage: newBeerPage)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        
        let beer = self.beerResponse[indexPath.row]
        cell.lbName.text = beer.name

        let url = URL(string: beer.image_url)
        let dataImg = try? Data(contentsOf: url!) //ma
        cell.imgBeer.image = UIImage(data: dataImg!)
        
        cell.lbAbv.text = String(beer.abv)

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BeerDetailViewController {
            if let selected = tableView.indexPathForSelectedRow {
                vc.beer = self.beerResponse[selected.row]                
            }
        }
    }
}
