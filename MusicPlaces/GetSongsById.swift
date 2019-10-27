//
//  GetSongsById.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation

class GetSongsById: BaseWebService<ItunesResponseSongs> {
    
    func getSongs(with songs: [FirebaseSong], completion: @escaping (ServiceResponse<ItunesResponseSongs>) -> Void) {
        var idSongs = ""
        for (index, song) in songs.enumerated() {
            if index > 0 { idSongs.append(",") }
            idSongs.append("\(song.itunesId)")
        }
        
        let url = Endpoitns.itunesBaseUrl + "lookup?id=" + idSongs
        callEndPoint(endpoint: url, completion: completion)
    }
    
    override func parse(data: Data) -> ItunesResponseSongs? {
        return try? JSONDecoder().decode(ItunesResponseSongs.self, from: data)
    }
}
