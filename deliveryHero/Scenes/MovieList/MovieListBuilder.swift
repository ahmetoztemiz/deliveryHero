//
//  MovieListBuilder.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation

final class MovieListBuilder {
    
    static func make() -> MovieListViewController {
        let service = BaseService()
        let view = MovieListViewController()
        let router = MovieListRouter(view: view)
        let interactor = MovieListInteractor(service: service)
        let presenter = MovieListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
}
