//
//  MovieListContractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

// MARK: - Interactor
protocol MovieListInteractorProtocol: AnyObject {
    var delegate: MovieListInteractorDelegate? { get set }
    func getMovieList(key text: String?)
    func getSelectedData(id: Int)
}

enum MovieListInteractorOutput: Equatable {
    case setLoading(Bool)
    case showData([MediaModel])
    case showAlert(title: String, message: String)
    case showDetail(MediaModel)
}

protocol MovieListInteractorDelegate: AnyObject {
    func handleOutput(_ output: MovieListInteractorOutput)
}

// MARK: - Presenter
protocol MovieListPresenterProtocol: AnyObject {
    func loadData(key text: String?)
    func select(id: Int)
}

enum MovieListPresenterOutput: Equatable {
    case setLoading(Bool)
    case showData([[MediaPresentationModel]])
    case showAlert(title: String, message: String)
}

// MARK: - View
protocol MovieListViewProtocol: AnyObject {
    func handleOutput(_ output: MovieListPresenterOutput)
}

// MARK: - Router
protocol MovieListRouterProtocol: AnyObject {
    func navigate(to route: MovieListRoute, mediaData: MediaModel?, actorData: MovieCastModel?)
}

enum MovieListRoute: Equatable {
    case movieDetail
    case personDetail
}
