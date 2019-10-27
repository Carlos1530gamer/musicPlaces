//
//  ViewController.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit
import FirebaseFirestore
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var musicPanelContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - variables
    var locationManager: CLLocationManager!
    let getSongsById = GetSongsById()
    var firebaseSongs: [FirebaseSong] = []
    var dataSongs: [ItunesSong] = []
    let header = MusicHeaderViewController.intance()
    var bottomView: BottomMenuViewController?
    let firebaseDependencie = FirebaseDependencie()
    
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
        setupTableView()
        musicPanelContainer.addSubview(header.view)
        header.view.frame = musicPanelContainer.bounds
    }
    
    //MARK: - public vars
    
    static func intance() -> ViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "mainVC") as? ViewController else { return ViewController() }
        return vc
    }
    
    private func loadData(newLocation: CLLocation, completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {[unowned self] in
            
            let semaphore = DispatchSemaphore(value: 0)
            
            self.firebaseDependencie.getSongsLibrary(checkDocument: {[unowned self] (document) -> Bool in
                guard let data = document.data(), let dataCoordinate = data["location"] as? GeoPoint else { return false }
                let documentPoint = CLLocationCoordinate2D(cordinate: dataCoordinate)
                return self.the(point: newLocation.coordinate, are: documentPoint)
            }) {[unowned self] (documents, placeDocId) in
                for document in documents.documents {
                    guard let node = FirebaseSong.formDic(dic: document.data()) else { return }
                    self.firebaseSongs.append(node)
                }
                semaphore.signal()
            }
            
            semaphore.wait()
            
            self.getSongsById.getSongs(with: self.firebaseSongs) {[unowned self] response in
                switch response {
                case .success(let itunesResponse):
                    self.dataSongs = itunesResponse.results
                case .failed: break
                }
                semaphore.signal()
            }
            
            semaphore.wait()
            completion()
        }
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func reloadTableView() {
        UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {[unowned self] in
            self.tableView.reloadData()
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") else { return UITableViewCell() }
        cell.textLabel?.text = dataSongs[indexPath.row].trackName
        cell.detailTextLabel?.text = dataSongs[indexPath.row].artistName
        cell.imageView?.load(from: dataSongs[indexPath.row].artworkUrl100)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedSong = dataSongs[indexPath.row]
    }
}

