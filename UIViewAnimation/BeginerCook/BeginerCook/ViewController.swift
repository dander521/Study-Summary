//
//  ViewController.swift
//  BeginerCook
//
//  Created by 程荣刚 on 16/4/23.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

let herbs = HerbModel.all()

class ViewController: UIViewController {

    @IBOutlet var listView: UIScrollView!
    @IBOutlet var bgImage: UIImageView!
    var selectedImage: UIImageView?
    
    let transition = PopAnimator()
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transition.dismissCompletion = {
            self.selectedImage!.hidden = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if listView.subviews.count < herbs.count {
            listView.viewWithTag(0)?.tag = 1000 //prevent confusion when looking up images
            setupList()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    //MARK: View setup
    
    //add all images to the list
    func setupList() {
        
        for i in 0 ..< herbs.count {
            
            //create image view
            let imageView  = UIImageView(image: UIImage(named: herbs[i].image))
            imageView.tag = i + 1
            imageView.contentMode = .ScaleAspectFill
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)
            
            //attach tap detector
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapImageView(_:))))
        }
        
        listView.backgroundColor = UIColor.clearColor()
        positionListItems()
    }
    
    //position all images inside the list
    func positionListItems() {
        
        let itemHeight: CGFloat = listView.frame.height * 1.33
        let aspectRatio = UIScreen.mainScreen().bounds.height / UIScreen.mainScreen().bounds.width
        let itemWidth: CGFloat = itemHeight / aspectRatio
        
        let horizontalPadding: CGFloat = 10.0
        
        for i in 0 ..< herbs.count {
            let imageView = listView.viewWithTag(i + 1) as! UIImageView
            imageView.frame = CGRect(
                x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, y: 0.0,
                width: itemWidth, height: itemHeight)
        }
        
        listView.contentSize = CGSize(
            width: CGFloat(herbs.count) * (itemWidth + horizontalPadding) + horizontalPadding,
            height:  0)
    }
    
    //MARK: Actions
    
    func didTapImageView(tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = tap.view!.tag - 1
        let selectedHerb = herbs[index]
        
        //present details view controller
        let herbDetails = storyboard!.instantiateViewControllerWithIdentifier("HerbDetailViewController") as! HerbDetailViewController
        herbDetails.herb = selectedHerb
        herbDetails.transitioningDelegate = self
        presentViewController(herbDetails, animated: true, completion: nil)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({context in
            self.bgImage.alpha = (size.width>size.height) ? 0.25 : 0.55
            self.positionListItems()
            }, completion: nil)
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage!.superview!.convertRect(selectedImage!.frame, toView: nil)
        transition.presenting = true
        selectedImage!.hidden = true
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
