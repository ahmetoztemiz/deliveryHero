//
//  ImageCache.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let wrapped = NSCache<NSString, UIImage>()

    func insert(_ value: UIImage, forKey key: NSString) {
        wrapped.setObject(value, forKey: key)
    }

    func value(forKey key: NSString) -> UIImage? {
        return wrapped.object(forKey: key)
    }

    func removeValue(forKey key: NSString) {
        wrapped.removeObject(forKey: key)
    }
}
