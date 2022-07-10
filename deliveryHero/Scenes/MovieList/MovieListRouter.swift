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
    func navigate(to route: MovieListRoute, mediaData: MediaModel?, actorData: PersonModel?) {
        switch route {
        case .movieDetail:
            guard let detailData = mediaData else { return }
            let detailVC = MovieDetailBuilder.make(data: detailData)
            view.show(detailVC, sender: nil)
        case .personDetail:
            guard let detailData = actorData else { return }
            //let detailVC = MovieDetailBuilder.make(data: detailData)
            //view.show(detailVC, sender: nil)
        }
    }
}
