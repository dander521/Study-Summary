//
//  ViewController.swift
//  CoreMotionTest
//
//  Created by 程荣刚 on 16/5/24.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var ball: UIImageView!
    var speedX: UIAccelerationValue = 0
    var speedY: UIAccelerationValue = 0
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ball = UIImageView(image: UIImage(named: "ball"))
        ball.frame = CGRectMake(0, 0, 50, 50)
        ball.center = self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/30
        
        if motionManager.accelerometerAvailable
        {
            let queue = NSOperationQueue.currentQueue()!
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: { (accelerometerData: CMAccelerometerData?, error: NSError?) in
                self.speedX += accelerometerData!.acceleration.x
                self.speedY += accelerometerData!.acceleration.y
                
                var posX = self.ball.center.x + CGFloat(self.speedX)
                var posY = self.ball.center.y + CGFloat(self.speedY)
                
                if posX < 0
                {
                    posX = 0
                    self.speedX *= -0.4
                } else if posX > self.view.bounds.size.width {
                    posX = self.view.bounds.size.width
                    self.speedX *= -0.4
                }
                
                if posY < 0
                {
                    posY = 0
                    self.speedY = 0
                } else if posY > self.view.bounds.size.height {
                    posY = self.view.bounds.size.height
                    self.speedY *= -1.5
                }
                
                self.ball.center = CGPointMake(posX, posY)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

