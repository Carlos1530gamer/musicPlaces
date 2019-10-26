//
//  UIImageExtension.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(from string: String) {
        guard let url = URL(string: string) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, urlResponse, error) in
            DispatchQueue.main.async {[unowned self] in
                guard let data = data, let image = UIImage(data: data) else { return }
                self.image = image
            }
        }).resume()
    }
}
