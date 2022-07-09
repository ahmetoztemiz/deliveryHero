//
//  MovieListRouter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import UIKit

final class MovieListRouter: MovieListRouterProtocol {

    //MARK: - PROPERTIES
    private let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    //MARK: - FUNCTIONS
    func navigate(to route: MovieListRoute) {
        switch route {
        case .detail:
            let detailVC = MovieListBuilder.make()
            view.show(detailVC, sender: nil)
        }
    }
}
