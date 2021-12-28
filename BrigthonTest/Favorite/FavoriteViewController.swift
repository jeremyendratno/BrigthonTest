//
//  FavoriteViewController.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import UIKit

class FavoriteViewController: UIViewController, FavoriteViewModelDelegate {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favorites: [String]?
    let defaults = UserDefaults.standard
    let viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
        initTableView()
    }
    
    func setupView() {
        favorites = defaults.stringArray(forKey: "Favorite")
        viewModel.delegate = self
    }
    
    func getData() {
        for favorite in favorites ?? [] {
            viewModel.request(id: favorite)
        }
    }
    
    func initTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
    
    func onFailed() {
        
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filmListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.filmImageView.sd_setImage(with: URL(string: viewModel.filmListData[indexPath.row].Poster))
        cell.titleLabel.text = viewModel.filmListData[indexPath.row].Title
        cell.yearLabel.text = viewModel.filmListData[indexPath.row].Year
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.imdbID = viewModel.filmListData[indexPath.row].imdbID
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
