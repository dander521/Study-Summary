//
//  ViewController.swift
//  WeatherTransform
//
//  Created by 倩倩 on 16/3/23.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

/*
常规动画属性设置（可以同时选择多个进行设置）

UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。

UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。

UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。

UIViewAnimationOptionRepeat：重复运行动画。

UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。

UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。

UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。

UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。

UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。

2.动画速度控制（可从其中选择一个设置）

UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。

UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。

UIViewAnimationOptionCurveEaseOut：动画逐渐加速。

UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。

3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）

UIViewAnimationOptionTransitionNone：没有转场动画效果。

UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。

UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。

UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。

UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。

UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。

UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。

UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。
*/

import UIKit

func delay(seconds seconds: Double, completion:()->())
{
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    dispatch_after(popTime, dispatch_get_main_queue(), {
        completion()
    })
}

enum AnimationDirection: Int {
    case Positive = 1
    case Negative = -1
}

class ViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var summaryImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var flightNoLabel: UILabel!
    @IBOutlet weak var gateNoLabel: UILabel!
    @IBOutlet weak var departingFromLabel: UILabel!
    @IBOutlet weak var arrivingToLabel: UILabel!
    @IBOutlet weak var planeImageView: UIImageView!
    @IBOutlet weak var flightStatusLabel: UILabel!
    
    var snowView: SnowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryLabel.addSubview(summaryImageView)
        summaryImageView.center.y = summaryLabel.frame.size.height/2
        
        // add snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y: -100, width: 300, height: 50))
        // 控制雪花的范围 view
        let snowClipView = UIView(frame: CGRectOffset(view.frame, 0 , 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        self.changeFlightDataTo(londonToParis)
    }
    
    // MARK: custom methods
    func changeFlightDataTo(data: FlightData, animate: Bool = false)
    {
        summaryLabel.text = data.summary
        
        if animate
        {
            self.planeDepart()
            self.summarySwitchTo(data.summary)
            
            changeBackgroundView(bgImageView, image: UIImage(named: data.weatherImageName)! , showEffects: data.showWeatherEffects)
            
            let direction: AnimationDirection = data.isTakingOff ?
                .Positive : .Negative
            
            cubeTransition(label: flightNoLabel, text: data.flightNr,
                direction: direction)
            cubeTransition(label: departingFromLabel, text: data.gateNr,
                direction: direction)
            
            let offsetDeparting = CGPoint(
                x: CGFloat(direction.rawValue * 80),
                y: 0.0)
            moveLabel(gateNoLabel, text: data.departingFrom,
                offset: offsetDeparting)
            
            let offsetArriving = CGPoint(
                x: 0.0,
                y: CGFloat(direction.rawValue * 50))
            moveLabel(arrivingToLabel, text: data.arrivingTo,
                offset: offsetArriving)
            
            cubeTransition(label: flightStatusLabel, text: data.flightStatus, direction: direction)
            
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
            snowView.hidden = !data.showWeatherEffects
            
            flightNoLabel.text = data.flightNr
            gateNoLabel.text = data.gateNr
            
            departingFromLabel.text = data.departingFrom
            arrivingToLabel.text = data.arrivingTo
            
            flightStatusLabel.text = data.flightStatus
        }
        
        delay(seconds: 3.0, completion: {
            self.changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis, animate: true)
        })
    }
    
    func changeBackgroundView(imageView: UIImageView, image: UIImage, showEffects: Bool)
    {
        UIView.transitionWithView(imageView, duration: 1.0, options: .TransitionCrossDissolve, animations: {
            imageView.image = image;
            }, completion: nil)
        
        UIView.animateWithDuration(1.0, animations: {
            self.snowView.alpha = showEffects ? 1.0 : 0.0;
            }, completion: nil)
    }
    
    // MARK: label Tranition
    func cubeTransition(label label: UILabel, text: String, direction: AnimationDirection) {
        
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = label.backgroundColor
        
        let auxLabelOffset = CGFloat(direction.rawValue) *
            label.frame.size.height/2.0
        
        auxLabel.transform = CGAffineTransformConcat(
            CGAffineTransformMakeScale(1.0, 0.1),
            CGAffineTransformMakeTranslation(0.0, auxLabelOffset))
        
        label.superview!.addSubview(auxLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
            auxLabel.transform = CGAffineTransformIdentity
            label.transform = CGAffineTransformConcat(
                CGAffineTransformMakeScale(1.0, 0.1),
                CGAffineTransformMakeTranslation(0.0, -auxLabelOffset))
            }, completion: {_ in
                label.text = auxLabel.text
                label.transform = CGAffineTransformIdentity
                auxLabel.removeFromSuperview()
        })
        
    }
    
    
    func moveLabel(label: UILabel, text: String, offset: CGPoint) {
        
        let auxLabel = UILabel(frame: label.frame)
        auxLabel.text = text
        auxLabel.font = label.font
        auxLabel.textAlignment = label.textAlignment
        auxLabel.textColor = label.textColor
        auxLabel.backgroundColor = UIColor.clearColor()
        
        auxLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y)
        auxLabel.alpha = 0
        view.addSubview(auxLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0,
            options: .CurveEaseIn, animations: {
                label.transform = CGAffineTransformMakeTranslation(
                    offset.x, offset.y)
                label.alpha = 0.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.25, delay: 0.1,
            options: .CurveEaseIn, animations: {
                auxLabel.transform = CGAffineTransformIdentity
                auxLabel.alpha = 1.0
                
            }, completion: {_ in
                //clean up
                auxLabel.removeFromSuperview()
                
                label.text = text
                label.alpha = 1.0
                label.transform = CGAffineTransformIdentity
        })
    }
    
    // MARK: plane summary keyframe Animation
    func planeDepart()
    {
        let originCenter = planeImageView.center
        delay(seconds: 0.7, completion: {
            // MARK:need a left direction plane image to instead of "plane_left"
            self.planeImageView.image = UIImage(named: "plane_left")
        })
        
        delay(seconds: 1.0, completion: {
            self.planeImageView.image = UIImage(named: "plane")
        })
        
        
        UIView.animateKeyframesWithDuration(1.5, delay: 0, options: [], animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.25, animations: {
                self.planeImageView.center.x += 80
                self.planeImageView.center.y -= 10
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.4, animations: {
                self.planeImageView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4/2))
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.25, relativeDuration: 0.25, animations: {
                self.planeImageView.center.x += 100.0
                self.planeImageView.center.y -= 50.0
                self.planeImageView.alpha = 0.0
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.1, animations: {
                self.planeImageView.transform = CGAffineTransformIdentity
                self.planeImageView.center = CGPoint(x: UIScreen.mainScreen().bounds.size.width, y: originCenter.y - 150.0)
                self.planeImageView.alpha = 1.0
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.6, animations: {
                self.planeImageView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4/4))
            })

            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.4, animations: {
                self.planeImageView.center.x -= UIScreen.mainScreen().bounds.size.width
                self.planeImageView.center.y += 50.0
                self.planeImageView.alpha = 0.0
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.91, relativeDuration: 0.01, animations: {
                self.planeImageView.transform = CGAffineTransformIdentity
                self.planeImageView.center = CGPoint(x: 0.0, y: originCenter.y)
                
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.95, relativeDuration: 0.55) {
                self.planeImageView.alpha = 1.0
                self.planeImageView.center = originCenter
            }
            
            }, completion: nil)
    }
    
    func summarySwitchTo(summaryText: String) {
        
        UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: [], animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.45, animations: {
                self.summaryLabel.center.y -= 100.0
            })
            UIView.addKeyframeWithRelativeStartTime(0.45, relativeDuration: 0.01, animations: {
                
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.45, animations: {
                self.summaryLabel.center.y += 100.0
            })
            }, completion: nil)
        
        delay(seconds: 0.5, completion: {
            self.summaryLabel.text = summaryText
        })
        
    }
}

