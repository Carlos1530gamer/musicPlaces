//
//  reverseGeocoding.swift
//  MusicPlaces
//
//  Created by Alejandro Mendoza on 27/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import Foundation

extension ViewController {
    struct ReverseGeocodingResponse: Codable {
        var Response: Response
    }

    struct Response: Codable {
        var MetaInfo: MetaInfo
        var View: [View]
    }

    struct MetaInfo: Codable {
        var Timestamp: String
    }

    struct View: Codable {
        var Result: [Result]
    }

    struct Result: Codable {
        var MatchLevel: String
        var Location: Location
    }

    struct Location: Codable {
        var Name: String
        var Address: Address
    }

    struct Address: Codable {
        var State: String
    }

    struct LocationReverseGeododingInformation {
        var name: String
        var state: String
    }

    func getLocationNameForCoordinates(lat: Double, lon: Double, radius: Int) {
        let endpoint = "https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox=\(lat)%2C\(lon)%2C\(radius)&mode=retrieveLandmarks&app_id=ZWQHQA9FNlzWYHC65i2g&app_code=eeT87EdNvDg8Zeh88rsQXg&gen=9"
        
        let session = URLSession.shared
        let url = URL(string: endpoint)!
        
        var result: LocationReverseGeododingInformation? = nil
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data,
                   error == nil else {return}
             
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(ReverseGeocodingResponse.self, from:
                             dataResponse)
                
                result = LocationReverseGeododingInformation(name: model.Response.View[0].Result[0].Location.Name, state: model.Response.View[0].Result[0].Location.Address.State)
                
                DispatchQueue.main.async {
                    [unowned self] in
                    self.locationName = result?.name
                }
                
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }
        
        task.resume()
        
    }

}

