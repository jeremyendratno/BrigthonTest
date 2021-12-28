//
//  FavoriteViewModel.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import Foundation

protocol FavoriteViewModelDelegate {
    func onSuccess()
    func onFailed()
}

class FavoriteViewModel {
    var delegate: FavoriteViewModelDelegate?
    var filmListData: [FilmModel] = []
    
    func request(id: String) {
        let url = URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=feecadf3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedJson = try! JSONDecoder().decode(FilmModel.self, from: data)
                self.filmListData.append(decodedJson)
                print(self.filmListData as Any)
                self.delegate?.onSuccess()
            } catch {
                self.delegate?.onFailed()
            }
        }
        task.resume()
    }
}
