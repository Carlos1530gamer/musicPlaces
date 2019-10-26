//
//  MusicHeaderViewController.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit

class MusicHeaderViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Variables
    private let musicPlayer = MusicPlayer()

    //MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - public funcs
    func setSong(_ song: ItunesSong) {
        imageView.load(from: song.artworkUrl100)
        musicPlayer.set(song: song.previewUrl)
    }
    
    static func intance() -> MusicHeaderViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "musicHeader") as? MusicHeaderViewController else { return MusicHeaderViewController() }
        return vc
    }
    
    //MARK: - Actions
    @IBAction func playOrStopAction(_ sender: UIButton) {
        musicPlayer.playOrPause {[unowned self] (isSelected) in
            self.playButton.setImage(isSelected ? UIImage(named: "pauseIcon") : UIImage(named: "playIcon"), for: .normal)
        }
    }
    
}
