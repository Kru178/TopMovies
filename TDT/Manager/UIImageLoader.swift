//
//  ImageLoader.swift
//  TDT
//
//  Created by Sergei Krupenikov on 05.04.2021.
//

import UIKit

class UIImageLoader {
    static let loader = UIImageLoader()
    private let imageLoader = ImagesLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(_ url: URL, for imageView: UIImageView) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            do {
                let image = try result.get()
                DispatchQueue.main.async { imageView.image = image }
            } catch {
                print(error)
            }
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}
