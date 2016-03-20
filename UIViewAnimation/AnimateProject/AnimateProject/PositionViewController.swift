//
//  PositionViewController.swift
//  AnimateProject
//
//  Created by 倩倩 on 16/3/20.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController
{
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    
    override func viewDidLoad() {
        
    }
    
    func rotation()
    {
        UIView.animateWithDuration(1, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.greenView.transform = CGAffineTransformRotate(self.greenView.transform, CGFloat(M_PI))
            }) { (finished) -> Void in
                self.rotation()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1, delay: 0, options:.CurveLinear, animations: { () -> Void in
            self.blueView.center.x = self.view.bounds.width - self.blueView.center.x
            self.blueView.center.y = self.view.bounds.height - self.blueView.center.y
            }, completion: nil)
        
        UIView.animateWithDuration(1, delay: 0.5, options: .CurveEaseIn, animations: { () -> Void in
            self.greenView.center.y = self.view.bounds.height/2
            }, completion: nil)
        
        UIView.animateWithDuration(3, delay: 1, options: .CurveEaseOut, animations: { () -> Void in
            self.redView.center.y = self.view.bounds.height - self.redView.bounds.width/2
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 2, options: .CurveLinear, animations: { () -> Void in
            // Opacity
            self.redView.alpha = 0.1
            self.blueView.alpha = 0.3
            self.greenView.alpha = 0.5
            }, completion: nil)
        
        UIView.animateWithDuration(2, delay: 2, options: .CurveLinear, animations: { () -> Void in
            
            // Scale
            self.redView.transform = CGAffineTransformMakeScale(0.5, 0.5)
            self.greenView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            
            // Color
            self.blueView.backgroundColor = UIColor.yellowColor()
            
            }, completion: {(finished) -> Void in
                
                // Rotation
                self.rotation()
        })
        
        
    }
}
