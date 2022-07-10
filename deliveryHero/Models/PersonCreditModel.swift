//
//  PersonCreditModel.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 10.07.2022.
//

import Foundation

// MARK: - PersonCreditModel
struct PersonCreditModel: Codable, Equatable {
    let cast, crew: [PersonCastModel]?
    let id: Int?
}

// MARK: - MovieCastModel
struct PersonCastModel: Codable, Equatable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order
    }
    
    func getCastPresentationModel() -> PersonCastPresentationModel {
        let presentationModel = PersonCastPresentationModel(id: id ?? 0, title: title ?? "", character: character ?? "-")
        
        return presentationModel
    }
}

struct PersonCastPresentationModel: Codable, Equatable {
    let id: Int
    let title: String
    let character: String
}
