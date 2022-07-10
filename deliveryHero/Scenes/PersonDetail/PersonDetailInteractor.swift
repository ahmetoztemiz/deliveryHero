//
//  PersonDetailInteractor.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class PersonDetailInteractor: PersonDetailInteractorProtocol {
    
    //MARK: - PROPERTIES
    weak var delegate: PersonDetailInteractorDelegate?
    private var actorDetail: MovieCastModel
    private var creditModel: PersonCreditModel?
    private var service: BaseServiceProtocol
    
    init(service: BaseServiceProtocol, data actorDetail: MovieCastModel) {
        self.service = service
        self.actorDetail = actorDetail
    }
    
    //MARK: - FUNCTIONS
    func getPersonDetail() {
        delegate?.handleOutput(.showData(actorDetail))
        getPersonCredit()
    }
    
    private func getPersonCredit() {
        delegate?.handleOutput(.setLoading(true))
        
        let creditAdditionalParam = String(format: urlParameters.personCredits.rawValue, actorDetail.id ?? 0)
        let creditQueryParams: [(urlParameters, String)] = [(.apiKey, urlParameters.key.rawValue), (.language, "en-US")]
        
        service.responseService(params: creditQueryParams, additionalURL: creditAdditionalParam) { [weak self] (result: PersonCreditModel?) in
            self?.creditModel = result
            if let castModel = result?.cast {
                self?.delegate?.handleOutput(.showCreditData(castModel))
            }
            self?.delegate?.handleOutput(.setLoading(false))
        }
    }
    
    func getActor(at index: Int) {
        guard let selectedActor = creditModel?.cast?[index] else { return }
//        delegate?.handleOutput(.showDetail(selectedActor))
    }
    
}

