//
//  CreditModel.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 10.07.2022.
//

import Foundation

// MARK: - CreditModel
struct MovieCreditModel: Codable {
    let id: Int?
    let cast, crew: [MovieCastModel]?
}

// MARK: - PersonModel
struct MovieCastModel: Codable, Equatable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment: String?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    func getCastPresentationModel() -> MovieCastPresentationModel {
        let presentationModel = MovieCastPresentationModel(id: id ?? 0, name: name ?? "-", department: knownForDepartment ?? "-", character: character, profileImage: profilePath ?? "")
        
        return presentationModel
    }
}

struct MovieCastPresentationModel: Codable, Equatable {
    let id: Int
    let name: String
    let department: String
    let character: String?
    let profileImage: String
}

