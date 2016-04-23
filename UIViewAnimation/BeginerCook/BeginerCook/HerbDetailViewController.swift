//
//  HerbDetailViewController.swift
//  BeginerCook
//
//  Created by 程荣刚 on 16/4/23.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class HerbDetailViewController: UIViewController, UIViewControllerTransitioningDelegate
{
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var bgImage: UIImageView!
    @IBOutlet var titleView: UILabel!
    @IBOutlet var descriptionView: UITextView!
    
    var herb: HerbModel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        bgImage.image = UIImage(named: herb.image)
        titleView.text = herb.name
        descriptionView.text = herb.description
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HerbDetailViewController.actionClose(_:))))
    }
    
    func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
