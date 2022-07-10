//
//  MovieDetailRouter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import UIKit

final class MovieDetailRouter: MovieDetailRouterProtocol {

    //MARK: - PROPERTIES
    private let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    //MARK: - FUNCTIONS
    func navigate(to route: MovieDetailRoute, data personData: PersonModel) {
        switch route {
        case .actorDetail:
            break
        }
    }
}

