//
//  ViewController.swift
//  PengiunsFun
//
//  Created by 程荣刚 on 16/4/21.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var pengiunsImageView: UIImageView!
    @IBOutlet weak var slideButton: UIButton!
    
    var isLookingRight: Bool = true {
        didSet {
            let xScale: CGFloat = isLookingRight ? 1 : -1
            pengiunsImageView.transform = CGAffineTransformMakeScale(xScale, 1)
            slideButton.transform = pengiunsImageView.transform
        }
    }
    
    var pengiunY: CGFloat!
    
    var walkSize: CGSize!
    var slideSize: CGSize!
    
    let animationDuration = 1.0
    
    var walkFrames = [
        UIImage(named: "walk01")!,
        UIImage(named: "walk02")!,
        UIImage(named: "walk03")!,
        UIImage(named: "walk04")!
    ]
    
    var slideFrames = [
        UIImage(named: "slide01")!,
        UIImage(named: "slide02")!,
        UIImage(named: "slide01")!
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walkSize = walkFrames[0].size
        slideSize = slideFrames[0].size
        pengiunY = pengiunsImageView.frame.origin.y
        
        loadWalkAnimation()
    }
    
    func loadWalkAnimation() {
        pengiunsImageView.animationImages = walkFrames
        pengiunsImageView.animationDuration = animationDuration / 3
        pengiunsImageView.animationRepeatCount = 3
    }
    
    func loadSlideAnimation() {
        pengiunsImageView.animationImages = slideFrames
        pengiunsImageView.animationDuration = animationDuration
        pengiunsImageView.animationRepeatCount = 1
    }
    
    @IBAction func actionLeft(sender: UIButton)
    {
        isLookingRight = false
        pengiunsImageView.startAnimating()
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
            self.pengiunsImageView.center.x -= self.walkSize.width
            }, completion: nil)
    }
    
    @IBAction func actionRight(sender: UIButton)
    {
        isLookingRight = true
        
        pengiunsImageView.startAnimating()
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
            self.pengiunsImageView.center.x += self.walkSize.width
            }, completion: nil)
    }
    
    @IBAction func actionSlide(sender: AnyObject) {
        loadSlideAnimation()
        
        pengiunsImageView.frame = CGRect(
            x: pengiunsImageView.frame.origin.x,
            y: pengiunY + (walkSize.height - slideSize.height),
            width: slideSize.width,
            height: slideSize.height)
        
        pengiunsImageView.startAnimating()
        
        UIView.animateWithDuration(animationDuration - 0.02, delay: 0.0, options: .CurveEaseOut, animations: {
            self.pengiunsImageView.center.x += self.isLookingRight ?
                self.slideSize.width : -self.slideSize.width
            }, completion: {_ in
                // animation is complete
                self.pengiunsImageView.frame = CGRect(
                    x: self.pengiunsImageView.frame.origin.x,
                    y: self.pengiunY,
                    width: self.walkSize.width,
                    height: self.walkSize.height)
                self.loadWalkAnimation()
        })
        
    }
}

