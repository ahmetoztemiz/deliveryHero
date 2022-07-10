//
//  MovieListPresenter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieListPresenter: MovieListPresenterProtocol {

    //MARK: - PROPERTIES
    private unowned let view: MovieListViewProtocol
    private let interactor: MovieListInteractorProtocol
    private let router: MovieListRouterProtocol
    
    init(view: MovieListViewProtocol,
         interactor: MovieListInteractorProtocol,
         router: MovieListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
    }
    
    //MARK: - FUNCTIONS
    func loadData(key text: String?) {
        interactor.getMovieList(key: text)
    }
    
    func select(at index: Int) {
        interactor.getSelectedData(at: index)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    
    func handleOutput(_ output: MovieListInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showData(let data):
            let presentationList = data.map { $0.getMediaPresentationModel() }
            let movies = presentationList.filter { $0.type == MediaType.movie }
            let actors = presentationList.filter { $0.type == MediaType.person }
            let tvSeries = presentationList.filter { $0.type == MediaType.tv }
            let filteredModel = [movies, actors, tvSeries].filter{ !($0.isEmpty) }
            view.handleOutput(.showData(filteredModel))
        case .showAlert(let title, let message):
            view.handleOutput(.showAlert(title: title, message: message))
        case .showDetail(let data):
            if data.mediaType == .person {
                let actorData = data.decodeByModel()
                router.navigate(to: .personDetail, mediaData: nil, actorData: actorData)
            } else {
                router.navigate(to: .movieDetail, mediaData: data, actorData: nil)
            }
            
        }
    }
}
