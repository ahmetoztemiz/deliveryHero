//
//  UIImage + Extension.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from link: String,
                    cacheId: NSString?,
                    completion: @escaping (UIImage, NSString) -> Void) {
        guard let url = URL(string: link),
              let cacheId = cacheId else { return }
        
        if let cachedImage = ImageCache.shared.value(forKey: cacheId) {
            completion(cachedImage, cacheId)
            return
        }
        
        BaseService.downloadImage(from: url) { image in
            guard let image = image else { return }
            completion(image, cacheId)
            ImageCache.shared.insert(image, forKey: cacheId)
        }
    }
}
