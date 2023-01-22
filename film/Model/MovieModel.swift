//
//  filmModel.swift
//  film
//
//  Created by İlker Yasin Memişoğlu on 16.01.2023.
//

import Foundation
import Alamofire


// MARK: - Welcome
struct MovieModel: Codable {
    let Title, Year, Rated, Released: String
    let Runtime, Genre, Director, Writer: String
    let Actors, Plot, Language, Country: String
    let Awards: String
    let Poster: String
    let Ratings: [Rating]
  
}

// MARK: - Rating
struct Rating : Codable {
    let Source, Value: String
}



