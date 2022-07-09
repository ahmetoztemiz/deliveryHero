//
//  AppRouter.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

final class AppRouter {
    static let shared = AppRouter()
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let mainVC = MovieListBuilder.make()
        let mainNVC = UINavigationController(rootViewController: mainVC)
        window.rootViewController = mainNVC
        window.makeKeyAndVisible()
    }
}
