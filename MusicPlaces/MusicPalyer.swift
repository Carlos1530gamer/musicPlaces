//
//  MusicPalyer.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer {
    var player = AVPlayer()
    
    func set(song url: String) {
        guard let songUrl = URL(string: url) else { return }
        player = AVPlayer(url: songUrl)
    }
    
    func play() {
        player.play()
    }
    
    func stop() {
        player.pause()
    }
}
