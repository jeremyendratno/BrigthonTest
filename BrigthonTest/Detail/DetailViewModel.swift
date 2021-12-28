//
//  DetailViewModel.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import Foundation

protocol DetailViewModelDelegate {
    func onSuccess()
    func onFailed()
}

class DetailViewModel {
    var delegate: DetailViewModelDelegate?
    var filmData: FilmDetailModel?
    
    func getFilmData(id: String) {
        let url = URL(string: "https://www.omdbapi.com/?i=\(id)&apikey=feecadf3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedJson = try! JSONDecoder().decode(FilmDetailModel.self, from: data)
                self.filmData = decodedJson
                self.delegate?.onSuccess()
            } catch {
                self.delegate?.onFailed()
            }
        }
        task.resume()
    }
}
