//
//  FirebaseDependencie.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseFirestore

class FirebaseDependencie {
    private var dataBase = Firestore.firestore()
    
    func getSongsLibrary(checkDocument: @escaping (_ : DocumentSnapshot) -> Bool, completion: @escaping (_ correctDoc: QuerySnapshot, _ placeDicId: String) -> Void) {
        var docId = ""
        dataBase.collection("places").getDocuments { (querySnap, error) in
            guard error == nil, let snap = querySnap else { return }
            for document in snap.documents {
                if checkDocument(document) {
                    docId = document.documentID
                    document.reference.collection("Songs").getDocuments { (songsSnapOptional, error) in
                        guard error == nil, let songsSnap = songsSnapOptional else { return }
                        completion(songsSnap, docId)
                    }
                }
            }
        }
    }
}
