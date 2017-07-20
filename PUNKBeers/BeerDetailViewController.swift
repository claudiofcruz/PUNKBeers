//
//  BeerDetailViewController.swift
//  PUNKBeers
//
//  Created by Claudio Cruz on 20/07/17.
//  Copyright © 2017 ClaudioCruz. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lbAbv: UILabel!
    @IBOutlet weak var lbIbu: UILabel!
    @IBOutlet weak var imgBeer: UIImageView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backItem?.title = "";
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.beer != nil {
            
            lbName.text = beer.name
            lbTagline.text = beer.tagline
            txtDescription.text = beer.description
            lbAbv.text = String(beer.abv)
            lbIbu.text = String(beer.ibu)

            let url = URL(string: beer.image_url)
            let dataImg = try? Data(contentsOf: url!) //ma
            imgBeer.image = UIImage(data: dataImg!)
        }
    }
}
