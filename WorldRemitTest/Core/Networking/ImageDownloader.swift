//
//  ImageLoader.swift
//  Prima
//
//  Created by Diego Caroli on 27/02/2020.
//  Copyright © 2020 Diego Caroli. All rights reserved.
//

import UIKit

protocol ImageService {
    func downloadImage(
        fromURL url: URL,
        completionHandler: @escaping (UIImage?) -> Void)
}

class ImageDownloader: ImageService {
    var imageCache: NSCache<NSString, UIImage>
    let queue: DispatchQueue

    init(imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>(),
         queue: DispatchQueue = DispatchQueue(label: "imageDownloader")) {
        self.imageCache = imageCache
        self.queue = queue
    }

    func downloadImage(fromURL url: URL,
                       completionHandler: @escaping (UIImage?) -> Void) {
        if let cacheImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completionHandler(cacheImage)
            return
        }

        queue.async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {
                completionHandler(nil)
                return
            }

            if let image = UIImage(data: data) {
                self?.imageCache.setObject(image,
                                           forKey: url.absoluteString as NSString)
                    DispatchQueue.main.async { completionHandler(image) }
            }
        }
    }

}
