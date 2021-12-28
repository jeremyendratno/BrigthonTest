//
//  HomeViewModel.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import Foundation

protocol HomeViewModelDelegate {
    func onSuccess()
    func onFailed()
}

class HomeViewModel {
    var delegate: HomeViewModelDelegate?
    var filmListData: [FilmModel] = []
    
    func getFilmListData() {
        let url = URL(string: "https://www.omdbapi.com/?s=avenger&apikey=feecadf3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
//                let str = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(str)
                let decodedJson = try! JSONDecoder().decode(FilmBySearchModel.self, from: data)
                self.filmListData.append(contentsOf: decodedJson.Search)
                self.delegate?.onSuccess()
            } catch {
                self.delegate?.onFailed()
            }
        }
        task.resume()
    }
    
    func getFilmListDataBySearch(search: String) {
        let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=feecadf3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decodedJson = try! JSONDecoder().decode(FilmBySearchModel.self, from: data)
                self.filmListData.append(contentsOf: decodedJson.Search)
                self.delegate?.onSuccess()
            } catch {
                self.delegate?.onFailed()
            }
        }
        task.resume()
    }
}
