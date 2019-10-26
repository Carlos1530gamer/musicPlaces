//
//  BaseWebService.swift
//  ProyectoTeamManitas
//
//  Created by Carlos Daniel Hernandez Chauteco on 10/6/19.
//  Copyright © 2019 Carlos Chauteco. All rights reserved.
//

import Foundation

struct DefaultVariables {
    static let deafultHeaders = [
        "Content-Type": "application/json"
    ]
}

enum ServiceResponse<MODEL> {
    case success(model: MODEL)
    case failed(message: String)
}

// No se preocupen por entender esta clase posiblemente la veamos a fondo el fin de semmana
class BaseWebService<T> {
    
    enum HttpMethod: String {
        case post = "POST"
        case get = "GET"
    }
    
    func callEndPoint(endpoint: String,
                      httpMethod: HttpMethod = .get,
                      body: [String: Any]? = nil,
                      headers: [String: String] = DefaultVariables.deafultHeaders,
                      completion: @escaping (ServiceResponse<T>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failed(message: "Error to make url with endpont"))
            return
        }
        
        var request = URLRequest(url: url)
    
        if let body = body, let dataBody = try? JSONSerialization.data(withJSONObject: body, options: []) {
            request.httpBody = dataBody
        }else{
            completion(.failed(message: "Error make the body data"))
        }
        
        request.httpMethod = httpMethod.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = URLSession(configuration: .default).dataTask(with: request) {[unowned self] (data, urlResponse, error) in
            if let error = error {
                completion(.failed(message: error.localizedDescription))
                return
            }
            
            guard let data = data, let decodeData = self.parse(data: data) else { completion(.failed(message: "Error parsing the data")); return }
            completion(.success(model: decodeData))
        }
        task.resume()
    }
    
    func parse(data: Data) -> T? {
        return nil
    }
}
