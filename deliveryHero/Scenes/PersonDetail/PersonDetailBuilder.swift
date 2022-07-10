//
//  PersonDetailBuilder.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

final class PersonDetailBuilder {
    
    static func make(data detailData: MovieCastModel) -> PersonDetailViewController {
        let service = BaseService()
        let view = PersonDetailViewController()
        let router = PersonDetailRouter(view: view)
        let interactor = PersonDetailInteractor(service: service, data: detailData)
        let presenter = PersonDetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
