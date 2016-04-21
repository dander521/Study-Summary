//
//  AnimatedMaskLabel.swift
//  SlideToReveal
//
//  Created by 倩倩 on 16/4/4.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class AnimatedMaskLabel: UIView
{
    let gradientLayer: CAGradientLayer = {
       let gradientLayer = CAGradientLayer()
        
        // Configure the gradient here
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let colors = [
            UIColor.yellowColor().CGColor,
            UIColor.greenColor().CGColor,
            UIColor.orangeColor().CGColor,
            UIColor.cyanColor().CGColor,
            UIColor.redColor().CGColor,
            UIColor.yellowColor().CGColor
        ]
        
        gradientLayer.colors = colors
        
        let locations = [
            0.0, 0.0, 0.0, 0.0, 0.0, 0.25
        ]
        
        gradientLayer.locations = locations
        
        return gradientLayer
    }()
    
    //
    let textAttributes: [String: AnyObject] = {
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        return [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 28.0)!,
            NSParagraphStyleAttributeName: style
        ]
    }()
    
    
    @IBInspectable var text: String! {
        didSet {
            setNeedsDisplay()
            
            UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            text.drawInRect(bounds, withAttributes: textAttributes)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let maskLayer = CALayer()
            maskLayer.backgroundColor = UIColor.clearColor().CGColor
            maskLayer.frame = CGRectOffset(bounds, bounds.size.width, 0)
            maskLayer.contents = image.CGImage
            
            gradientLayer.mask = maskLayer
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: bounds.origin.y,
            width: 3 * bounds.size.width,
            height: bounds.size.height)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        layer.addSublayer(gradientLayer)
        
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [
            0.0, 0.0, 0.0, 0.0, 0.0, 0.25
        ]
        
        gradientAnimation.toValue = [
            0.65, 0.8, 0.85, 0.9, 0.95, 1.0
        ]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = Float.infinity
        
        gradientLayer.addAnimation(gradientAnimation, forKey: nil)
    }
}
