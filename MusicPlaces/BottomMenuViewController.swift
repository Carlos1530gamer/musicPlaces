//
//  BottomMenuViewController.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit

protocol BottomMenuViewControllerDataSource {
    
}

class BottomMenuViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var locationPanelView: UIView!
    @IBOutlet weak var commentsPanel: UIView!
    @IBOutlet weak var sugetsSongButton: UIButton!
    
    
    //MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    static func intance() -> BottomMenuViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "bottomMenu") as? BottomMenuViewController else { return BottomMenuViewController() }
        return vc
    }
    
    
    @IBAction func sugetsSongDidTaped(_ sender: Any) {
        let searchSongVC = SearchSongViewController.intance()
        self.present(searchSongVC, animated: true, completion: nil)
    }
    
    //MARK: - Private funcs
    private func setupUI() {
        self.locationPanelView.layer.cornerRadius = 8
        self.commentsPanel.layer.cornerRadius = 8
        self.sugetsSongButton.layer.cornerRadius = 8
    }
}
