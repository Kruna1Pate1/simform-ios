//
//  UIImage+extention.swift
//  Demo
//
//  Created by Krunal Patel on 06/04/23.
//

import UIKit

extension UIImage {
    func resizedImage(to targetSize: CGSize) -> UIImage? {
        let render = UIGraphicsImageRenderer(size: targetSize)
        return render.image { ctx in
            self.draw(in: .init(origin: .zero, size: targetSize))
        }
    }
    
    func resizedImage(to targetSize: Int) -> UIImage? {
        return resizedImage(to: CGSize(width: targetSize, height: targetSize))
    }
}
