//
//  HomeViewController.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, HomeViewModelDelegate {
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeSearchBar: UISearchBar!
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Nice Movie!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(goToFavorite))
        viewModel.delegate = self
        viewModel.getFilmListData()
        homeSearchBar.delegate = self
    }
    
    func initTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    }
    
    @objc func goToFavorite() {
        let favoriteVC = FavoriteViewController()
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    func reloadTableView() {
        
    }
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
    
    func onFailed() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filmListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
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

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.filmListData.removeAll()
        homeTableView.reloadData()
        viewModel.getFilmListDataBySearch(search: searchBar.text ?? "")
    }
}

extension UISearchBar {
    
    @IBInspectable var doneAccessory: Bool {
        get { return self.doneAccessory }
        set (hasDone) { if hasDone { addDoneButtonOnKeyboard() } }
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
