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
    case showCastData([MovieCastModel])
    case showDetail(MovieCastModel)
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
    case showCastData([MovieCastPresentationModel])
}

// MARK: - View
protocol MovieDetailViewProtocol: AnyObject {
    func handleOutput(_ output: MovieDetailPresenterOutput)
}

// MARK: - Router
protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(to route: MovieDetailRoute, data personData: MovieCastModel)
}

enum MovieDetailRoute: Equatable {
    case actorDetail
}

