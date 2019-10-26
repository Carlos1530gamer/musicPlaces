//
//  SongModel.swift
//  MusicPlaces
//
//  Created by Carlos on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation

struct ItunesResponseSongs: Codable {
    var resultCount: Int
    var results: [ItunesSong]
}

struct ItunesSong: Codable {
    var trackId: Int
    var artistName: String
    var trackName: String
    var previewUrl: String
    var artworkUrl100: String
}
