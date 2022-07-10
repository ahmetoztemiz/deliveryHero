//
//  MovieDetailPresenter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieDetailPresenter: MovieDetailPresenterProtocol {

    //MARK: - PROPERTIES
    private unowned let view: MovieDetailViewProtocol
    private let interactor: MovieDetailInteractorProtocol
    private let router: MovieDetailRouterProtocol
    
    init(view: MovieDetailViewProtocol,
         interactor: MovieDetailInteractorProtocol,
         router: MovieDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
    }
    
    //MARK: - FUNCTIONS
    func loadData() {
        interactor.getMovieDetail()
    }
    
    func selectActor(at index: Int) {
        interactor.getActor(at: index)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorDelegate {
    
    func handleOutput(_ output: MovieDetailInteractorOutput) {
        switch output {
        case .setLoading(let bool):
            view.handleOutput(.setLoading(bool))
        case .showData(let data):
            let presentationData = data.getMediaDetailPresentationModel()
            view.handleOutput(.showData(presentationData))
        case .showCastData(let data):
            let presentationModel = data.map { $0.getCastPresentationModel() }
            view.handleOutput(.showCastData(presentationModel))
        case .showDetail(let data):
            router.navigate(to: .actorDetail, data: data)
        }
    }
}
