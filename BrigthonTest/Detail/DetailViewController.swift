//
//  DetailViewController.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import UIKit

class DetailViewController: UIViewController, DetailViewModelDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    var imdbID: String?
    var viewModel = DetailViewModel()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        getData()
    }
    
    func viewSetup() {
        viewModel.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addFavorite(_:)))
        tapGesture.delegate = self
        favoriteImageView.addGestureRecognizer(tapGesture)
        let favoriteArray = defaults.stringArray(forKey: "Favorite") ?? []
        for favorite in favoriteArray {
            if favorite == imdbID {
                favoriteImageView.image = UIImage(systemName: "heart.circle.fill")
                favoriteImageView.isUserInteractionEnabled = false
                break
            }
        }
    }
    
    func getData() {
        viewModel.getFilmData(id: imdbID ?? "")
    }
    
    @objc func addFavorite(_ sender: UIImageView) {
        var favoriteArray = defaults.stringArray(forKey: "Favorite") ?? []
        favoriteArray.append(imdbID ?? "")
        defaults.set(favoriteArray, forKey: "Favorite")
        favoriteImageView.image = UIImage(systemName: "heart.circle.fill")
    }
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.filmImageView.sd_setImage(with: URL(string: self.viewModel.filmData?.Poster ?? ""))
            self.titleLabel.text = self.viewModel.filmData?.Title
            self.dateLabel.text = self.viewModel.filmData?.Released
            self.durationLabel.text = self.viewModel.filmData?.Runtime
            self.starLabel.text = self.viewModel.filmData?.imdbRating
            self.descriptionLabel.text = self.viewModel.filmData?.Plot
            self.genreLabel.text = self.viewModel.filmData?.Genre
            self.directorLabel.text = self.viewModel.filmData?.Director
            self.actorLabel.text = self.viewModel.filmData?.Actors
        }
    }
    
    func onFailed() {
        
    }
}
