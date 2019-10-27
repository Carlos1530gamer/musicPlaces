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
    
    //MARK: - outlets
    @IBOutlet weak var musicPanelContainer: UIView!
    
    //MARK: - variables
    var locationManager: CLLocationManager!
    let header = MusicHeaderViewController.intance()
    var bottomView: BottomMenuViewController?
    
    //MARK: - Computed vars
    private var selectedSong: ItunesSong? {
        didSet {
            guard let newSong = selectedSong else { return }
            self.header.setSong(newSong)
        }
    }
    
    var location: CLLocation? {
        didSet {
            if let newLocation = location {
                getLocationNameForCoordinates(lat: location!.coordinate.latitude, lon: location!.coordinate.longitude, radius: 10)
            }
        }
    }
    
    var locationName: String? {
        willSet {
            print(newValue)
            self.bottomView?.reloadData()
        }
    }
    
    var locationAdministrativeArea: String? {
        willSet {
            // todo if need this var
        }
    }
    
    //MARK: - vc life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        musicPanelContainer.addSubview(header.view)
        header.view.frame = musicPanelContainer.bounds
    }
    
    //MARK: - public vars
    
    static func intance() -> ViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "mainVC") as? ViewController else { return ViewController() }
        return vc
    }
    
}

extension ViewController: BottomMenuViewControllerDelegate, BottomMenuViewControllerDataSource {
    
    func bottomMenulocation() -> String {
        return self.locationName ?? ""
    }
    
    func bottomMenuSelectedSong() -> ItunesSong? {
        return self.selectedSong
    }
    
    func userDidSelected(song: ItunesSong) {
        self.selectedSong = song
    }
    
}

