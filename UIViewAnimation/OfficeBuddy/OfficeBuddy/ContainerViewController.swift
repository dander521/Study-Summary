//
//  ContainerViewController.swift
//  OfficeBuddy
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController
{
    let menuWidth: CGFloat = 80.0
    let animationTime: NSTimeInterval = 0.5
    
    let menuViewController: UIViewController!
    let centerViewController: UIViewController!
    
    var isOpening = false
    
    init(sideView: UIViewController, center: UIViewController)
    {
        menuViewController = sideView
        centerViewController = center
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blackColor()
        setNeedsStatusBarAppearanceUpdate()
        
        addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
        /*
        当从一个视图控制容器中添加或者移除viewController后，该方法被调用。
        parent：父视图控制器，如果没有父视图控制器，将为nil
        
        当我们向我们的视图控制器容器（就是父视图控制器，它调用addChildViewController方法加入子视图控制器，它就成为了视图控制器的容器）中添加（或者删除）子视图控制器后，必须调用该方法，告诉iOS，已经完成添加（或删除）子控制器的操作。
        */
        centerViewController.didMoveToParentViewController(self) // 告诉iOS，已经完成添加（或删除）
        
        addChildViewController(menuViewController)
        view.addSubview(menuViewController.view)
        menuViewController.didMoveToParentViewController(self)
        
        menuViewController.view.layer.anchorPoint.x = 1.0 // 设置锚点 主要是想通过transition 和 rotation 合理动画 达到无缝连接
        menuViewController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        view.addGestureRecognizer(panGesture)
        
        setToPercent(0.0)
    }
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer)
    {
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)
        progress = min(max(progress, 0.0), 1.0)
        
        switch recognizer.state {
        
        case .Began:
            // 向下取整 0.0 ｜｜ 1.0
            let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
            isOpening = isOpen == 1.0 ? false : true
            
            /*
            当shouldRasterize设成true时，layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。实现圆角本身就是在做颜色混合（blending），如果每次页面出来时都blending，消耗太大，这时shouldRasterize = yes，下次就只是简单的从渲染引擎的cache里读取那张bitmap，节约系统资源。
            额外收获：如果在滚动tableView时，每次都执行圆角设置，肯定会阻塞UI，设置这个将会使滑动更加流畅
            */
            menuViewController.view.layer.shouldRasterize = true
            menuViewController.view.layer.rasterizationScale = UIScreen.mainScreen().scale
            
        case .Changed:
            self.setToPercent(isOpening ?  progress : (1.0 - progress))
            
        case .Ended: fallthrough
        case .Cancelled: fallthrough
            
        case .Failed:
            var targetProgress: CGFloat
            if (isOpening) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            } else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            UIView.animateWithDuration(animationTime, animations: {
                self.setToPercent(targetProgress)
                }, completion: {_ in
                    self.menuViewController.view.layer.shouldRasterize = false
            })
            
        default: break
        }
    }
    
    func toggleSideMenu() {
        let isOpen = floor(centerViewController.view.frame.origin.x/menuWidth)
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
        
        UIView.animateWithDuration(animationTime, animations: {
            self.setToPercent(targetProgress)
            }, completion: { _ in
                self.menuViewController.view.layer.shouldRasterize = false
        })
    }
    
    func setToPercent(percent: CGFloat)
    {
        centerViewController.view.frame.origin.x = menuWidth * CGFloat(percent)
//        menuViewController.view.frame.origin.x = menuWidth * CGFloat(percent) - menuWidth
        
        menuViewController.view.layer.transform = menuTransformForPercent(percent)
        menuViewController.view.alpha = CGFloat(max(0.2, percent))
        
        let centerVC = (centerViewController as! UINavigationController).viewControllers.first as? CenterViewController
        
        if let menuButton = centerVC?.menuButton {
            menuButton.imageView.layer.transform = buttonTransformForPercent(percent)
        }
    }
    
    func menuTransformForPercent(percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000 // 三维动画 仿射变换 从z轴方向 投影动画 转变为 二维动画
        
        let remainingPercent = 1.0 - percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
        
        let rotationTransform = CATransform3DRotate(identity, angle,
            0.0, 1.0, 0.0)
        let translationTransform =
        CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
        return CATransform3DConcat(rotationTransform,
            translationTransform)
    }
    
    
    func buttonTransformForPercent(percent: CGFloat) -> CATransform3D
    {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000 // 仿射变换
        
        let angle = percent * CGFloat(-M_PI)
        let rotationTransform = CATransform3DRotate(identity, angle, 1.0, 1.0, 0.0)
        
        return rotationTransform
    }
    

}
