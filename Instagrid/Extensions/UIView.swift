//
//  UIView.swift
//  Instagrid
//
//  Created by Elodie-Anne Parquer on 24/07/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

extension UIView {
    
    // Converts UIView to UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
