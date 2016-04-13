//
//  ViewController.swift
//  Album
//
//  Created by 倩倩 on 16/4/13.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController
{
    let images = [
        ImageViewCard(imageNamed: "1", title: "A"),
        ImageViewCard(imageNamed: "2", title: "B"),
        ImageViewCard(imageNamed: "3", title: "C"),
        ImageViewCard(imageNamed: "4", title: "D")
    ]
    
    var isAlbumOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Information", style: .Done, target: self, action: Selector("information"))
    }
    
    func information()
    {
        let alertController = UIAlertController(title: "Information", message: "Nothing serious", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        for image in images
        {
            image.layer.anchorPoint.y = 0.0
            image.frame = view.bounds
            view.addSubview(image)
            
            image.didSelect = selectImage
        }
        
        navigationItem.title = images.last?.title
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/250.0
        view.layer.sublayerTransform = perspective
    }
    
    func selectImage(selectedImage: ImageViewCard)
    {
        for subview in view.subviews
        {
            if let image = subview as? ImageViewCard
            {
                // selected image
                if image === selectedImage
                {
                    UIView.animateWithDuration(0.33, delay: 0.0, options: .CurveEaseIn, animations: {
                            image.layer.transform = CATransform3DIdentity
                        }, completion: {_ in
                            self.view.bringSubviewToFront(image)
                    })
                } else {
                // other image
                    UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseIn, animations: {
                            image.alpha = 0.0
                        }, completion: {_ in
                            image.alpha = 1.0
                            image.layer.transform = CATransform3DIdentity
                    })
                }
            }
        }
        
        self.navigationItem.title = selectedImage.title
    }
    
    
    @IBAction func toggleAlbum(sender: AnyObject) {
        
        if isAlbumOpen {
            for subView in view.subviews
            {
                if let image = subView as? ImageViewCard
                {
                    let animation = CABasicAnimation(keyPath: "transform")
                    animation.fromValue = NSValue(CATransform3D: image.layer.transform)
                    animation.toValue = NSValue(CATransform3D: CATransform3DIdentity)
                    animation.duration = 0.33
                    
                    image.layer.addAnimation(animation, forKey: nil)
                    image.layer.transform = CATransform3DIdentity
                }
            }
            
            isAlbumOpen = false
            return
        } else {
            var imageYOffset: CGFloat = 50.0
            
            for subview in view.subviews
            {
                if let image = subview as? ImageViewCard
                {
                    var imageTransform = CATransform3DIdentity
                    
                    // translate
                    imageTransform = CATransform3DTranslate(imageTransform, 0.0, imageYOffset, 0.0)
                    
                    // scale
                    imageTransform = CATransform3DScale(imageTransform, 0.95, 0.7, 1.0)
                    
                    // rotation
                    imageTransform = CATransform3DRotate(imageTransform, CGFloat(M_PI_4/2), -1.0, 0.0, 0.0)
                    
                    let animation = CABasicAnimation(keyPath: "transform")
                    animation.fromValue = NSValue(CATransform3D: image.layer.transform)
                    animation.toValue = NSValue(CATransform3D: imageTransform)
                    animation.duration = 0.33
                    
                    image.layer.addAnimation(animation, forKey: nil)
                    image.layer.transform = imageTransform
                    
                    imageYOffset += view.frame.height / CGFloat(images.count)
                }
            }
        }
    }
    
}

