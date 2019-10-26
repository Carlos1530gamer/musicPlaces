//
//  ViewController.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var location: CLLocation? {
        didSet {
            if let newLocation = location {
                getLocationNameOf(newLocation)
            }
        }
    }
    
    var locationName: String? {
        willSet {
            print(newValue)
        }
    }
    
    var locationAdministrativeArea: String? {
        willSet {
            print(newValue)
        }
    }
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        
    }

}

