//
//  ViewController.swift
//  SearchFighter
//
//  Created by 倩倩 on 16/4/3.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

//
// Util delay function
//
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController
{
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var opponentAvatar: AvatarView!
    @IBOutlet weak var myAvatar: AvatarView!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var searchAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchForOpponent()
    }
    
    func searchForOpponent()
    {
        let avatarSize = myAvatar.frame.size
        let bounceXOffset: CGFloat = avatarSize.width/1.9
        let morphSize = CGSize(width: avatarSize.width * 0.85, height: avatarSize.height * 1.1)
        let rightBouncePoint = CGPoint(x: view.frame.size.width/2.0 + bounceXOffset, y: myAvatar.center.y)
        let leftBouncePoint = CGPoint(x: view.frame.size.width/2.0 - bounceXOffset, y: opponentAvatar.center.y)
        
        myAvatar.bounceOffPoint(rightBouncePoint, morphSize: morphSize)
        opponentAvatar.bounceOffPoint(leftBouncePoint, morphSize: morphSize)
        
        delay(seconds: 4.0, completion: foundOpponent)
    }
    
    func foundOpponent() {
        statusLabel.text = "Connecting..."
        
        opponentAvatar.image = UIImage(named: "avatar-2")
        opponentAvatar.name = "Ray"
        
        delay(seconds: 4.0, completion: connectedToOpponent)
    }
    
    func connectedToOpponent() {
        myAvatar.shouldTransitionToFinishedState = true
        opponentAvatar.shouldTransitionToFinishedState = true
        
        delay(seconds: 1.0, completion: completed)
    }
    
    func completed() {
        statusLabel.text = "Ready to play"
        UIView.animateWithDuration(1.0, animations: {
            self.vsLabel.alpha = 1.0
            self.searchAgainButton.alpha = 1.0
        })
    }

    @IBAction func searchAgain(sender: AnyObject) {
        UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard!.instantiateViewControllerWithIdentifier("ViewController") as UIViewController
    }

}

