//
//  PersonDetailPresenter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class PersonDetailPresenter: PersonDetailPresenterProtocol {

    //MARK: - PROPERTIES
    private unowned let view: PersonDetailViewProtocol
    private let interactor: PersonDetailInteractorProtocol
    private let router: PersonDetailRouterProtocol
    
    init(view: PersonDetailViewProtocol,
         interactor: PersonDetailInteractorProtocol,
         router: PersonDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.interactor.delegate = self
    }
    
    //MARK: - FUNCTIONS
    func loadData() {
        interactor.getPersonDetail()
    }
    
    func selectActor(at index: Int) {
        interactor.getActor(at: index)
    }
}

extension PersonDetailPresenter: PersonDetailInteractorDelegate {
    
    func handleOutput(_ output: PersonDetailInteractorOutput) {
        switch output {
        case .setLoading(let bool):
            view.handleOutput(.setLoading(bool))
        case .showData(let data):
            let presentationData = data.getCastPresentationModel()
            view.handleOutput(.showData(presentationData))
        case .showCreditData(let data):
            let presentationModel = data.map { $0.getCastPresentationModel() }
            view.handleOutput(.showCreditData(presentationModel))
        }
    }
}
