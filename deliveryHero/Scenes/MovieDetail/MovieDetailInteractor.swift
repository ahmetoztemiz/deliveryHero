//
//  MovieDetailInteractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    //MARK: - PROPERTIES
    weak var delegate: MovieDetailInteractorDelegate?
    private var movieDetail: MediaModel
    private var creditModel: CreditModel?
    private var service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol, data movieDetail: MediaModel) {
        self.service = service
        self.movieDetail = movieDetail
    }
    
    //MARK: - FUNCTIONS
    func getMovieDetail() {
        delegate?.handleOutput(.showData(movieDetail))
        getMovieCredits()
    }
    
    private func getMovieCredits() {
        delegate?.handleOutput(.setLoading(true))
        
        let creditAdditionalParam = String(format: urlParameters.movieCredits.rawValue, movieDetail.id ?? 0)
        let creditQueryParams: [(urlParameters, String)] = [(.apiKey, urlParameters.key.rawValue), (.language, "en-US")]
        
        service.responseService(params: creditQueryParams, additionalURL: creditAdditionalParam) { [weak self] (result: CreditModel?) in
            self?.creditModel = result
            if let castModel = result?.cast {
                self?.delegate?.handleOutput(.showCastData(castModel))
            }
            self?.delegate?.handleOutput(.setLoading(false))
        }
    }
    
    func getActor(at index: Int) {
        guard let selectedActor = creditModel?.cast?[index] else { return }
        delegate?.handleOutput(.showDetail(selectedActor))
    }
    
}

