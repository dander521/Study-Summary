//
//  SnowView.swift
//  WeatherTransform
//
//  Created by 倩倩 on 16/3/23.
//  Copyright © 2016年 RogerChen. All rights reserved.
//  UIView

import UIKit
import QuartzCore

class SnowView: UIView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        
        let emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(bounds.size.width/2 , 0) // 粒子发射位置
        emitter.emitterSize = bounds.size // 发射源尺寸大小
        emitter.emitterShape = kCAEmitterLayerRectangle  // 发射源形状
        
        let emitterCell = CAEmitterCell()
        emitterCell.contents = UIImage(named: "snowflake1")?.CGImage
        
        // 速度 乘数因子
        emitterCell.birthRate = 200
        emitterCell.lifetime = 3.5
        
        // 颜色
        emitterCell.color = UIColor.whiteColor().CGColor
        
        emitterCell.redRange = 0.0
        emitterCell.blueRange = 0.1
        emitterCell.greenRange = 0.0
        // 速度和速度范围
        emitterCell.velocity = 10
        emitterCell.velocityRange = 350.0
        
        // 发射角度
        emitterCell.emissionRange = CGFloat(M_PI_2)
        emitterCell.emissionLongitude = CGFloat(-M_PI)
        
        // y, x 方向的加速度
        emitterCell.yAcceleration = 70
        emitterCell.xAcceleration = 0
        
        // 大小 范围
        emitterCell.scale = 0.33
        emitterCell.scaleRange = 1.25
        emitterCell.scaleSpeed = -0.25
        
        // 透明度 范围
        emitterCell.alphaRange = 0.5
        emitterCell.alphaSpeed = -0.15
        
        emitter.emitterCells = [emitterCell]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func layerClass() -> AnyClass
    {
        return CAEmitterLayer.self
    }
}
