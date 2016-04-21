//
//  AnimationAdvancedViewController.swift
//  AnimationAdvanced
//
//  Created by 倩倩 on 16/3/20.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class AnimationAdvancedViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var orangeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Repeat
        UIView.animateWithDuration(1, delay: 0, options: [.Repeat, .Autoreverse], animations: { () -> Void in
            self.blueView.center.x = self.view.bounds.width - self.blueView.center.x
            }, completion: nil)
        
        // slow -> fast
        UIView.animateWithDuration(1, delay: 0, options: [.CurveEaseIn, .Autoreverse, .Repeat], animations: { () -> Void in
            self.greenView.center.x = self.view.bounds.width - self.greenView.center.x
            }, completion: nil)
        // fast -> slow
        UIView.animateWithDuration(1, delay: 0, options: [.CurveEaseOut, .Autoreverse, .Repeat], animations: { () -> Void in
            self.redView.center.x = self.view.bounds.width - self.redView.center.x
            }, completion: nil)
        
        // slow -> fast -> slow
        UIView.animateWithDuration(1, delay: 0, options: [.CurveEaseInOut, .Autoreverse, .Repeat], animations: { () -> Void in
            self.yellowView.center.x = self.view.bounds.width - self.yellowView.center.x
            }, completion: nil)
        
        // Spring
        // Damping :usingSpringWithDamping的范围为0.0f到1.0f，数值越小「弹簧」的振动效果越明显
        // Velocity:initialSpringVelocity则表示初始的速度，数值越大一开始移动越快
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.1, options: .TransitionNone, animations: { () -> Void in
            self.orangeView.center.x = self.view.bounds.width - self.orangeView.center.x
            }, completion: nil)
        
    }

}
