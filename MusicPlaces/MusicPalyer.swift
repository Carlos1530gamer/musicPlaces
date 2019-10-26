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
    
    private var player = AVPlayer()
    private var isPlaying = false
    
    func set(song url: String) {
        guard let songUrl = URL(string: url) else { return }
        player = AVPlayer(url: songUrl)
    }
    
    func playOrPause(clousure: (_ : Bool) -> Void) {
        if isPlaying {
            player.pause()
            isPlaying = false
        }else{
            player.play()
            isPlaying = true
        }
        clousure(isPlaying)
    }
}
