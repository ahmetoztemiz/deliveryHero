//
//  MovieListInteractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieListInteractor: MovieListInteractorProtocol {
    
    //MARK: - PROPERTIES
    weak var delegate: MovieListInteractorDelegate?
    private var service: BaseServiceProtocol
    private var mediaList: [MediaModel] = []
    
    init(service: BaseServiceProtocol) {
        self.service = service
    }
    
    //MARK: - FUNCTIONS
    func getMovieList(key text: String?) {
        delegate?.handleOutput(.setLoading(true))
        
        
        var mediaAdditionalParam = urlParameters.popularMovie.rawValue
        var mediaQueryParams: [(urlParameters, String)] = [(.apiKey, urlParameters.key.rawValue), (.language, "en-US"), (.page, "1")]
        if let queryText = text, queryText != "" {
            mediaAdditionalParam = urlParameters.multiSearch.rawValue
            let queryParam: (urlParameters, String) = (.query, queryText)
            mediaQueryParams.append(queryParam)
        }
        
        service.responseService(params: mediaQueryParams, additionalURL: mediaAdditionalParam) { [weak self] (result: MediaListModel?) in
            let mediaResult = result?.results ?? []
            self?.mediaList = mediaResult
            self?.delegate?.handleOutput(.showData(mediaResult))
            self?.delegate?.handleOutput(.setLoading(false))
        }
        
    }
    
    func getSelectedData(at index: Int) {
        delegate?.handleOutput(.showDetail(mediaList[index]))
    }
    
}

