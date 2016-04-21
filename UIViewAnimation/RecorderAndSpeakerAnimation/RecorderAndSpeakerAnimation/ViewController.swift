//
//  ViewController.swift
//  RecorderAndSpeakerAnimation
//
//  Created by 倩倩 on 16/4/5.
//  Copyright © 2016年 RogerChen. All rights reserved.
//



import UIKit
import AVFoundation

/*
fillMode属性值（要想fillMode有效，最好设置removedOnCompletion=NO）
    
kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态.
    
kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状

kCAFillModeBackwards 在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始. 你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态

kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状
*/

//
// Util delay function
//
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var speakLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    let replicator = CAReplicatorLayer()
    let dot = CALayer()
    
    let monitor = MicMonitor()
    let assistant = Assistant()
    
    let dotLength: CGFloat = 6.0
    let dotOffset: CGFloat = 8.0
    
    var lastTransformScale: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        replicator.frame = view.bounds
        view.layer.addSublayer(replicator)
        
        dot.frame = CGRect(
            x: replicator.frame.size.width - dotLength,
            y: replicator.position.y,
            width: dotLength,
            height: dotLength)
        dot.backgroundColor = UIColor.lightGrayColor().CGColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        dot.borderWidth = 0.5
        dot.cornerRadius = 1.5
        
        replicator.addSublayer(dot)
        
        replicator.instanceCount = Int(view.frame.size.width / dotOffset)
        replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0.0, 0.0)

        replicator.instanceDelay = 0.02
    }


    @IBAction func actionStartMonitoring(sender: AnyObject)
    {
        dot.backgroundColor = UIColor.greenColor().CGColor
        
        monitor.startMonitoringWithHandler{level in
            self.speakLabel.text = String(format: "%0.2f db", level)
            
            let scaleFactor = max(0.2, CGFloat(level) + 50) / 2
            
            let scale = CABasicAnimation(keyPath: "transform.scale.y")
            scale.fromValue = self.lastTransformScale
            scale.toValue = scaleFactor
            scale.duration = 0.1
            scale.removedOnCompletion = false
            scale.fillMode = kCAFillModeForwards
            self.dot.addAnimation(scale, forKey: nil)
            
            self.lastTransformScale = scaleFactor
        }
    }
    
    
    @IBAction func actionEndMonitoring(sender: AnyObject)
    {
        monitor.stopMonitoring()
        
        // dot 上一个scale 到 0.2
        let scale = CABasicAnimation(keyPath: "transform.scale.y")
        scale.fromValue = lastTransformScale
        scale.toValue = 1.0
        scale.duration = 0.2
        scale.removedOnCompletion = false
        scale.fillMode = kCAFillModeForwards
        dot.addAnimation(scale, forKey: nil)
        
        dot.backgroundColor = UIColor.magentaColor().CGColor
        
        // dot 颜色渐变动画
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.greenColor().CGColor
        tint.toValue = UIColor.magentaColor().CGColor
        tint.duration = 1.2
        tint.fillMode = kCAFillModeBackwards
        dot.addAnimation(tint, forKey: nil)
        
        delay(seconds: 1.0, completion: {
            self.startSpeaking()
        })
    }
    
    func startSpeaking()
    {
        speakLabel.text = assistant.randomAnswer()
        assistant.speak(speakLabel.text!, completion: endSpeaking)
        recordButton.hidden = true
        
        // 3D 动画
        /*
        struct CATransform3D
        {
        CGFloat m11, m12, m13, m14；
        
        CGFloat m21, m22, m23, m24；
        
        CGFloat m31, m32, m33, m34；
        
        CGFloat m41, m42, m43, m44；
        };
        */
        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scale.toValue = NSValue(CATransform3D:
            CATransform3DMakeScale(1.4, 15, 1.0))
        scale.duration = 0.33
        scale.repeatCount = Float.infinity
        scale.autoreverses = true
        scale.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        dot.addAnimation(scale, forKey: "dotScale") // 用于remove animaton
        
        // 透明度
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.duration = 0.33
        fade.beginTime = CACurrentMediaTime() + 0.33
        fade.repeatCount = Float.infinity
        fade.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        dot.addAnimation(fade, forKey: "dotOpacity") // 用于remove animaton
        
        // 背景色
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.magentaColor().CGColor
        tint.toValue = UIColor.yellowColor().CGColor
        tint.duration = 0.66
        tint.beginTime = CACurrentMediaTime() + 0.28
        tint.fillMode = kCAFillModeBackwards
        tint.repeatCount = Float.infinity
        tint.autoreverses = true
        tint.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        dot.addAnimation(tint, forKey: "dotColor") // 用于remove animaton
        
        // instanceTransform指定了一个 CATransform3D 3D变换
        let initialRotation = CABasicAnimation(keyPath:
            "instanceTransform.rotation")
        initialRotation.fromValue = 0.0
        initialRotation.toValue   = 0.01
        initialRotation.duration = 0.33
        initialRotation.removedOnCompletion = false
        initialRotation.fillMode = kCAFillModeForwards
        initialRotation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        replicator.addAnimation(initialRotation, forKey:
            "initialRotation")
        
        let rotation = CABasicAnimation(keyPath:
            "instanceTransform.rotation")
        rotation.fromValue = 0.01
        rotation.toValue   = -0.01
        rotation.duration = 0.99
        rotation.beginTime = CACurrentMediaTime() + 0.33
        rotation.repeatCount = Float.infinity
        rotation.autoreverses = true // the object plays backwards after playing forwards
        rotation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        replicator.addAnimation(rotation, forKey: "replicatorRotation") // 用于remove animaton
    }
    
    func endSpeaking()
    {
        replicator.removeAllAnimations()
        
        let scale = CABasicAnimation(keyPath: "transform")
        // 清空3D动画
        scale.toValue = NSValue(CATransform3D: CATransform3DIdentity)
        scale.duration = 0.33
        scale.removedOnCompletion = false
        scale.fillMode = kCAFillModeForwards
        dot.addAnimation(scale, forKey: nil)
        
        dot.removeAnimationForKey("dotColor")
        dot.removeAnimationForKey("dotOpacity")
        dot.backgroundColor = UIColor.lightGrayColor().CGColor
        
        recordButton.hidden = false
    }
}

