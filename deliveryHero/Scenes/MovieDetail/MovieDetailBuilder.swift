//
//  MovieDetailBuilder.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieDetailBuilder {
    
    static func make(data detailData: MediaModel) -> MovieDetailViewController {
        let service = BaseService()
        let view = MovieDetailViewController()
        let router = MovieDetailRouter(view: view)
        let interactor = MovieDetailInteractor(service: service, data: detailData)
        let presenter = MovieDetailPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
