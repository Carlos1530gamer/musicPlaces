//
//  SearchSongViewController.swift
//  MusicPlaces
//
//  Created by Carlos on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit

protocol SearchSongViewControllerDelegate {
    func searchSong(didSelect song: ItunesSong)
}

class SearchSongViewController: UIViewController {
    
    struct Dependencies {
        let getSongs: GetSongService
        
        init(getSongs: GetSongService = GetSongService()) {
            self.getSongs = getSongs
        }
    }
    
    //MARK: - variables
    
    var delegate: SearchSongViewControllerDelegate?
    let dependencies = Dependencies()
    var data: [ItunesSong] = []
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

}

extension SearchSongViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell") else { return UITableViewCell() }
        cell.textLabel?.text = data[indexPath.row].trackName
        cell.detailTextLabel?.text = data[indexPath.row].artistName
        cell.imageView?.load(from: data[indexPath.row].artworkUrl100)
        cell.imageView?.round()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.searchSong(didSelect: data[indexPath.row])
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {[unowned self] in
            UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {[unowned self] in
                self.tableView.reloadData()
            }, completion: nil)
        }
    }
    
    
}

extension SearchSongViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let query = searchText.replacingOccurrences(of: " ", with: "+")
        dependencies.getSongs.getSongList(of: query) {[unowned self] response in
            switch response {
            case .success(let model):
                self.data = model.results
                self.reloadTableView()
            case .failed:
                print("ohhh no")
            }
        }
    }
    
}
