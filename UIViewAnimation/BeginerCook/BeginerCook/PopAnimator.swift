//
//  PopAnimator.swift
//  BeginerCook
//
//  Created by 程荣刚 on 16/4/23.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

/*
 动画控制器 (Animation Controllers) 遵从 UIViewControllerAnimatedTransitioning 协议，并且负责实际执行动画。
 交互控制器 (Interaction Controllers) 通过遵从 UIViewControllerInteractiveTransitioning 协议来控制可交互式的转场。
 转场代理 (Transitioning Delegates) 根据不同的转场类型方便的提供需要的动画控制器和交互控制器。
 转场上下文 (Transitioning Contexts) 定义了转场时需要的元数据，比如在转场过程中所参与的视图控制器和视图的相关属性。 转场上下文对象遵从 UIViewControllerContextTransitioning 协议，并且这是由系统负责生成和提供的。
 转场协调器(Transition Coordinators) 可以在运行转场动画时，并行的运行其他动画。 转场协调器遵从 UIViewControllerTransitionCoordinator 协议。
 */

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning
{
    // MARK:variables
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->())?
    
    // MARK: UIViewControllerAnimatedTransitioning
    // This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        return duration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        let herbController = transitionContext.viewControllerForKey(
            presenting ? UITransitionContextToViewControllerKey : UITransitionContextFromViewControllerKey
            ) as! HerbDetailViewController
        
        if presenting {
            herbController.containerView.alpha = 0.0
        }
        
        UIView.animateWithDuration(duration, delay:0.0,
                                   usingSpringWithDamping: 0.4,
                                   initialSpringVelocity: 0.0,
                                   options: [],
                                   animations: {
                                    
                                    herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                                    herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
                                    herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
                                    
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
        
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = !presenting ? 0.0 : 20.0/xScaleFactor
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        herbView.layer.addAnimation(round, forKey: nil)
        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
    }
}
