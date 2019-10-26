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
    
    @IBOutlet weak var musicPanelContainer: UIView!
    private var selectedSong: ItunesSong? {
        didSet {
            guard let newSong = selectedSong else { return }
            self.header.setSong(newSong)
        }
    }
    
    let header = MusicHeaderViewController.intance()
    
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
        musicPanelContainer.addSubview(header.view)
        header.view.frame = musicPanelContainer.bounds
    }
    
    static func intance() -> ViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "mainVC") as? ViewController else { return ViewController() }
        return vc
    }
    
}

extension ViewController: SearchSongViewControllerDelegate {
    
    func searchSong(didSelect song: ItunesSong) {
        self.selectedSong = song
    }
    
}

