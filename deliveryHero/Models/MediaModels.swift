//
//  MovieModels.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

struct MediaListModel: Codable, Equatable {
    let page: Int?
    let results: [MediaModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MediaModel: Codable, Equatable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: MediaType?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount, gender: Int?
    let knownFor: [MediaModel]?
    let knownForDepartment, name: String?
    let profilePath: String?
    let firstAirDate: String?
    let originCountry: [String]?
    let originalName: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case gender
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
    
    func getMediaPresentationModel() -> MediaPresentationModel {
        let modelId = String(describing: id)
        let personName = self.name ?? ""
        let title = self.originalTitle ?? personName
        let personImage = self.profilePath ?? ""
        let imageURL = self.posterPath ?? personImage
        let mediaType = self.mediaType ?? .movie
        
        let presentationModel = MediaPresentationModel(id: modelId, title: title, imagePath: imageURL, type: mediaType)
        
        return presentationModel
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}

struct MediaPresentationModel: Codable, Equatable {
    let id, title, imagePath: String
    let type: MediaType
}
