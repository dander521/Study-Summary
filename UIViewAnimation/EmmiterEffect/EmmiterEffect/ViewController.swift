//
//  ViewController.swift
//  EmmiterEffect
//
//  Created by 程荣刚 on 16/4/21.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 0.0, y: -70.0, width: view.bounds.width, height: 50.0)
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        view.layer.addSublayer(emitter)
        
        emitter.emitterShape = kCAEmitterLayerRectangle
        emitter.emitterPosition = CGPoint(x: rect.width/2, y: rect.height/2)
        emitter.emitterSize = rect.size
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "flake.png")!.CGImage
        
        emitterCell.birthRate = 150
        emitterCell.lifetime = 3.5
        
        emitterCell.yAcceleration = 70.0
        emitterCell.xAcceleration = 10.0
        emitterCell.velocity = 20.0
        emitterCell.emissionLongitude = CGFloat(-M_PI)
        emitterCell.velocityRange = 200.0
        emitterCell.emissionRange = CGFloat(M_PI_2)
        emitterCell.color = UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0).CGColor
        emitterCell.redRange   = 0.1
        emitterCell.greenRange = 0.1
        emitterCell.blueRange  = 0.1
        emitterCell.scale = 0.8
        emitterCell.scaleRange = 0.8
        emitterCell.scaleSpeed = -0.15
        emitterCell.alphaRange = 0.75
        emitterCell.alphaSpeed = -0.15
        emitterCell.lifetimeRange = 1.0
        
        //cell #2
        let cell2 = CAEmitterCell()
        cell2.contents = UIImage(named: "flake2.png")!.CGImage
        cell2.birthRate = 50
        cell2.lifetime = 2.5
        cell2.lifetimeRange = 1.0
        cell2.yAcceleration = 50
        cell2.xAcceleration = 50
        cell2.velocity = 80
        cell2.emissionLongitude = CGFloat(M_PI)
        cell2.velocityRange = 20
        cell2.emissionRange = CGFloat(M_PI_4)
        cell2.scale = 0.8
        cell2.scaleRange = 0.2
        cell2.scaleSpeed = -0.1
        cell2.alphaRange = 0.35
        cell2.alphaSpeed = -0.15
        cell2.spin = CGFloat(M_PI)
        cell2.spinRange = CGFloat(M_PI)
        
        //cell #3
        let cell3 = CAEmitterCell()
        cell3.contents = UIImage(named: "flake3.png")!.CGImage
        cell3.birthRate = 20
        cell3.lifetime = 7.5
        cell3.lifetimeRange = 1.0
        cell3.yAcceleration = 20
        cell3.xAcceleration = 10
        cell3.velocity = 40
        cell3.emissionLongitude = CGFloat(M_PI)
        cell3.velocityRange = 50
        cell3.emissionRange = CGFloat(M_PI_4)
        cell3.scale = 0.8
        cell3.scaleRange = 0.2
        cell3.scaleSpeed = -0.05
        cell3.alphaRange = 0.5
        cell3.alphaSpeed = -0.05
        
        emitter.emitterCells = [emitterCell, cell2, cell3]
    }
}

