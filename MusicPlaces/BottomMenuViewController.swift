//
//  BottomMenuViewController.swift
//  MusicPlaces
//
//  Created by Carlos Bambu on 26/10/19.
//  Copyright © 2019 Manzip. All rights reserved.
//

import UIKit

protocol BottomMenuViewControllerDataSource {
    func bottomMenulocation() -> String
    func bottomMenuSelectedSong() -> ItunesSong?
}

protocol BottomMenuViewControllerDelegate {
    func userDidSelected(song: ItunesSong)
}

class BottomMenuViewController: UIViewController {
    
    //MARK: - Variables
    
    var delegate: BottomMenuViewControllerDelegate?
    var dataSource: BottomMenuViewControllerDataSource?
    var selectedSong: ItunesSong?
    
    //MARK: - Outlets
    @IBOutlet weak var locationPanelView: UIView!
    @IBOutlet weak var commentsPanel: UIView!
    @IBOutlet weak var sugetsSongButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var currentLocationLabel: UILabel!
    
    
    //MARK: - VC life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - public methods
    
    func reloadData() {
        UIView.transition(with: self.view, duration: 0.35, options: .transitionCrossDissolve, animations: {[unowned self] in
            self.currentLocationLabel.text = self.dataSource?.bottomMenulocation()
        }, completion: nil)
        self.selectedSong = dataSource?.bottomMenuSelectedSong()
    }
    

    static func intance() -> BottomMenuViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(identifier: "bottomMenu") as? BottomMenuViewController else { return BottomMenuViewController() }
        return vc
    }
    
    
    @IBAction func sugetsSongDidTaped(_ sender: Any) {
        let searchSongVC = SearchSongViewController.intance()
        searchSongVC.delegate = self
        self.present(searchSongVC, animated: true, completion: nil)
    }
    
    //MARK: - Private funcs
    private func setupUI() {
        self.locationPanelView.layer.cornerRadius = 8
        self.commentsPanel.layer.cornerRadius = 8
        self.sugetsSongButton.layer.cornerRadius = 8
        commentTextField.layer.cornerRadius = 8
        commentTextField.addLeft(icon: UIImage(named: "talkIcon") ?? UIImage())
        commentTextField.delegate = self
        commentTextField.addDoneButtonOnKeyboard()
        commentTextField.placeholder = "Comenta acerca de la cancion aqui"
    }
}

extension BottomMenuViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension BottomMenuViewController: SearchSongViewControllerDelegate {
    
    func searchSong(didSelect song: ItunesSong) {
        delegate?.userDidSelected(song: song)
    }
    
}
