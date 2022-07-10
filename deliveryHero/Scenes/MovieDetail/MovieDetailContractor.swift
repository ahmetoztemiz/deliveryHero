//
//  MovieDetailContractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

// MARK: - Interactor
protocol MovieDetailInteractorProtocol: AnyObject {
    var delegate: MovieDetailInteractorDelegate? { get set }
    func getMovieDetail()
    func getActor(at index: Int)
}

enum MovieDetailInteractorOutput: Equatable {
    case setLoading(Bool)
    case showData(MediaModel)
    case showCastData([PersonModel])
    case showDetail(PersonModel)
}

protocol MovieDetailNavigationDelegate: AnyObject {
    func routeToMovieDetail(to route: MovieDetailRoute, movieDetail data: MediaModel)
}

protocol MovieDetailInteractorDelegate: AnyObject {
    func handleOutput(_ output: MovieDetailInteractorOutput)
}

// MARK: - Presenter
protocol MovieDetailPresenterProtocol: AnyObject {
    func loadData()
    func selectActor(at index: Int)
}

enum MovieDetailPresenterOutput: Equatable {
    case setLoading(Bool)
    case showData(MediaDetailPresentationModel)
    case showCastData([CastPresentationModel])
}

// MARK: - View
protocol MovieDetailViewProtocol: AnyObject {
    func handleOutput(_ output: MovieDetailPresenterOutput)
}

// MARK: - Router
protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(to route: MovieDetailRoute, data personData: PersonModel)
}

enum MovieDetailRoute: Equatable {
    case actorDetail
}

