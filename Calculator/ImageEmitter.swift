//
//  ImageEmitter.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/14/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

/// This class create CAEmitterCell emitter for falling images on the superview like a sublayer
class ImageEmitter {
    static var styleSettings: [String : Any]!
    
    /// This method adds image to CAEmitterCell and return CAEmitterLayer
    static func get(with image: UIImage) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterCells = generateEmitterCells(with: image)
        
        return emitter
    }
    
    /// This mrthod return CAEmitterCell for addition on layer
    static func generateEmitterCells(with image: UIImage) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        
        cell.scale = styleSettings["scale"] as? CGFloat ?? 0.1
        cell.lifetime = styleSettings["lifetime"] as? Float ?? 10
        cell.velocity = styleSettings["velocity"] as? CGFloat ?? 30
        cell.birthRate = styleSettings["birthRate"] as? Float ?? 1
        cell.scaleRange = styleSettings["scaleRange"] as? CGFloat ?? 0.08
        cell.emissionRange = CGFloat(45 * (Double.pi/180))
        cell.emissionLongitude = CGFloat(180 * (Double.pi/180))
        
        cells.append(cell)
        
        return cells
    }
}
