//
//  KeyframeViewController.swift
//  LoginAnimaton
//
//  Created by 倩倩 on 16/3/20.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class KeyframeViewController: UIViewController {

    @IBOutlet weak var redView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.animateKeyframesWithDuration(2, delay: 0, options: [], animations: {
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.25, animations: {
                self.redView.center.x = self.view.bounds.width - self.redView.center.x
            })
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: {
                self.redView.center.y = self.view.bounds.height - self.redView.center.y
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.25, animations: {
                self.redView.center.x = self.view.bounds.width - self.redView.center.x
            })
            UIView.addKeyframeWithRelativeStartTime(0.75, relativeDuration: 0.25, animations: {
                self.redView.center.y = self.view.bounds.height - self.redView.center.y
            })
            }, completion: nil)
    }
}
