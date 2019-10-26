//
//  FirebasePlaylist.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation

struct FirebaseSong {
    var commentsPoints: Int
    var itunesId: Int
    var likes: Int
    
    static func formDic(dic: [String: Any]) -> FirebaseSong? {
        guard let commentPoits = dic["commentsPoints"] as? Int, let id = dic["id"] as? Int, let likes = dic["likes"] as? Int else { return nil }
        return FirebaseSong(commentsPoints: commentPoits, itunesId: id, likes: likes)
    }
}
