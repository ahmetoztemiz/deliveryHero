//
//  PersonDetailContractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

// MARK: - Interactor
protocol PersonDetailInteractorProtocol: AnyObject {
    var delegate: PersonDetailInteractorDelegate? { get set }
    func getPersonDetail()
    func getActor(at index: Int)
}

enum PersonDetailInteractorOutput: Equatable {
    case setLoading(Bool)
    case showData(MovieCastModel)
    case showCreditData([PersonCastModel])
}

protocol PersonDetailInteractorDelegate: AnyObject {
    func handleOutput(_ output: PersonDetailInteractorOutput)
}

// MARK: - Presenter
protocol PersonDetailPresenterProtocol: AnyObject {
    func loadData()
    func selectActor(at index: Int)
}

enum PersonDetailPresenterOutput: Equatable {
    case setLoading(Bool)
    case showData(MovieCastPresentationModel)
    case showCreditData([PersonCastPresentationModel])
}

// MARK: - View
protocol PersonDetailViewProtocol: AnyObject {
    func handleOutput(_ output: PersonDetailPresenterOutput)
}

// MARK: - Router
protocol PersonDetailRouterProtocol: AnyObject {
    func navigate(to route: PersonDetailRoute)
}

enum PersonDetailRoute: Equatable {}

