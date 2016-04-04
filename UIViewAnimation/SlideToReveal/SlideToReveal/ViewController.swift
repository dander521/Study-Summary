//
//  ViewController.swift
//  SlideToReveal
//
//  Created by 倩倩 on 16/4/4.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var slideView: AnimatedMaskLabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: "didSlide")
        swipe.direction = .Right
        slideView.addGestureRecognizer(swipe)
    }

    func didSlide() {
        // reveal the imageView upon successful slide
        let image = UIImageView(image: UIImage(named: "meme"))
        image.center = view.center
        image.center.x += view.bounds.size.width
        view.addSubview(image)
        
        UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
            self.timeLabel.center.y -= 200.0
            self.slideView.center.y += 200.0
            image.center.x -= self.view.bounds.size.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 1.0, options: [], animations: {
            self.timeLabel.center.y += 200.0
            self.slideView.center.y -= 200.0
            image.center.x += self.view.bounds.size.width
            }, completion: {_ in
                image.removeFromSuperview()
        })
    }
}

