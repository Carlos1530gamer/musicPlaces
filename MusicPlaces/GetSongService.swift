//
//  GetSongService.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 25/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation

class GetSongService: BaseWebService<ItunesResponseSongs> {
    
    func getSongList(of query: String, completion: @escaping (ServiceResponse<ItunesResponseSongs>) -> Void) {
        
        let url = Endpoitns.itunesBaseUrl + "/search?term=\(query)&media=music"
        
        callEndPoint(endpoint: url, completion: completion)
    }
    
    override func parse(data: Data) -> ItunesResponseSongs? {
        return try? JSONDecoder().decode(ItunesResponseSongs.self, from: data)
    }
}
