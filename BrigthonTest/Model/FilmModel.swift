//
//  FilmModel.swift
//  BrigthonTest
//
//  Created by Jeremy Endratno on 12/28/21.
//

import Foundation

struct FilmModel: Decodable {
    var imdbID: String
    var Title: String
    var Year: String
    var Poster: String
}

struct FilmDetailModel: Decodable {
    var imdbID: String
    var Title: String
    var Year: String
    var Poster: String
    var Released: String
    var Runtime: String
    var imdbRating: String
    var Plot: String
    var Genre: String
    var Director: String
    var Actors: String
}

struct FilmBySearchModel: Decodable {
    var Search: [FilmModel]
}
