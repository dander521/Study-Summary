//
//  AvatarView.swift
//  SearchFighter
//
//  Created by 倩倩 on 16/4/3.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class AvatarView: UIView {

    // MARK: constants
    let lineWidth: CGFloat = 6.0
    let animationDuration = 1.0
    
    // MARK: UI
    let photoLayer = CALayer()
    let circleLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialRoundedMtBold", size: 18.0)
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        return label
    }()
    
    // MARK: variables
    @IBInspectable
    var image: UIImage! {
        didSet {
            photoLayer.contents = image.CGImage
        }
    }
    
    @IBInspectable
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    var shouldTransitionToFinishedState = false
    var isSquare = false
    
    override func didMoveToWindow() {
        layer.addSublayer(photoLayer)
        photoLayer.mask = maskLayer
        layer.addSublayer(circleLayer)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        // Size the avatar image to fit
        photoLayer.frame = CGRect(
            x: (bounds.size.width - image.size.width + lineWidth) / 2,
            y: (bounds.size.width - image.size.width - lineWidth) / 2,
            width: image.size.width,
            height: image.size.width)
        
        // Draw the circle
        circleLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
        circleLayer.strokeColor = UIColor.whiteColor().CGColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clearColor().CGColor
        
        // Size the layer
        maskLayer.path = circleLayer.path
        maskLayer.position = CGPoint(x: 0.0, y: 10.0)
        
        // Size the label
        label.frame = CGRect(x: 0.0, y: bounds.size.height + 10.0, width: bounds.size.width, height: 24.0)
    }
    
    func bounceOffPoint(bouncePoint: CGPoint, morphSize: CGSize)
    {
        let originalCenter = center
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [], animations: {
                self.center = bouncePoint
            }, completion: {_ in
                // complete bounce to 
                if self.shouldTransitionToFinishedState {
                    // animate to square
                    self.animateToSquare()
                }
        })
        
        UIView.animateWithDuration(animationDuration, delay: animationDuration, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = originalCenter
            }, completion: {_ in
                delay(seconds: 0.1, completion: {
                    if !self.isSquare {
                        self.bounceOffPoint(bouncePoint, morphSize: morphSize)
                    }
                })
        })
        
        let morphedFrame = (originalCenter.x > bouncePoint.x) ?
        CGRect( // opponent avatar
            x: 0.0,
            y: bounds.height - morphSize.height,
            width: morphSize.width,
            height: morphSize.height) :
        CGRect(// self avatar
            x: bounds.width - morphSize.width,
            y: bounds.height - morphSize.height,
            width: morphSize.width,
            height: morphSize.height)
        
        let morphAnimation = CABasicAnimation(keyPath: "path")
        morphAnimation.duration = animationDuration
        morphAnimation.toValue = UIBezierPath(ovalInRect: morphedFrame).CGPath
        morphAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        circleLayer.addAnimation(morphAnimation, forKey: nil)
        maskLayer.addAnimation(morphAnimation, forKey: nil)
    }
    
    
    func animateToSquare()
    {
        isSquare = true
        
        let squarePath = UIBezierPath(rect: bounds).CGPath
        let morph = CABasicAnimation(keyPath: "path")
        morph.duration = 0.25
        morph.fromValue = circleLayer.path
        morph.toValue = squarePath
        
        circleLayer.addAnimation(morph, forKey: nil)
        maskLayer.addAnimation(morph, forKey: nil)
        
        circleLayer.path = squarePath
        maskLayer.path = squarePath
    }
}
