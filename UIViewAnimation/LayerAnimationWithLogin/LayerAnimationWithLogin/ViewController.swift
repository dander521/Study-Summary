//
//  ViewController.swift
//  LayerAnimationWithLogin
//
//  Created by 倩倩 on 16/4/3.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->())
{
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds))
    
    dispatch_after(popTime, dispatch_get_main_queue())
    {
        completion()
    }
}

class ViewController: UIViewController
{

    // MARK: IB outlets
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let infoLabel = UILabel()
    let messages = ["正在连接 ...", "正在认证 ...", "发送认证 ...", "登录失败"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 8.0;
        loginBtn.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginBtn.addSubview(spinner)
        
        status.hidden = true
        status.center = loginBtn.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
        statusPosition = status.center
        
        infoLabel.frame = CGRect(x: 0.0, y: loginBtn.center.y + 60.0, width: view.frame.size.width, height: 30.0)
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textAlignment = .Center
        infoLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.text = "点击输入框，输入用户名和密码"
        view.insertSubview(infoLabel, belowSubview: loginBtn)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let formGroup = CAAnimationGroup()
        formGroup.duration = 1.0
        formGroup.fillMode = kCAFillModeBackwards
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = -view.bounds.size.width/2
        flyRight.toValue = view.bounds.size.width/2
        
        let fadeFieldIn = CABasicAnimation(keyPath: "opacity")
        fadeFieldIn.fromValue = 0.1
        fadeFieldIn.toValue = 1.0
        
        formGroup.animations = [flyRight, fadeFieldIn]
        loginTitle.layer.addAnimation(formGroup, forKey: nil)
        
        formGroup.delegate = self
        formGroup.setValue("form", forKey: "name")
        
        formGroup.setValue(userName.layer, forKey: "layer")
        formGroup.beginTime = CACurrentMediaTime() + 0.3
        userName.layer.addAnimation(formGroup, forKey: nil)
        
        formGroup.setValue(passWord.layer, forKey: "layer")
        formGroup.beginTime = CACurrentMediaTime() + 0.5
        passWord.layer.addAnimation(formGroup, forKey: nil)
        
        let fadeIn = CABasicAnimation(keyPath: "opacity")
        fadeIn.fromValue = 0.0
        fadeIn.toValue = 1.0
        fadeIn.duration = 0.5
        fadeIn.fillMode = kCAFillModeBackwards
        
        fadeIn.beginTime = CACurrentMediaTime() + 0.5
        cloud1.layer.addAnimation(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 1.0
        cloud2.layer.addAnimation(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 1.5
        cloud3.layer.addAnimation(fadeIn, forKey: nil)
        
        fadeIn.beginTime = CACurrentMediaTime() + 2.0
        cloud4.layer.addAnimation(fadeIn, forKey: nil)
        
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.5
        groupAnimation.beginTime = CACurrentMediaTime() + 0.5
        groupAnimation.fillMode = kCAFillModeBackwards
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 3.5
        scaleDown.toValue = 1.0

        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = CGFloat(2 * M_PI)
        rotate.toValue = 0.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.0
        fade.toValue = 1.0
        
        groupAnimation.animations = [scaleDown, rotate, fade]
        loginBtn.layer.addAnimation(groupAnimation, forKey: nil)
        
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = infoLabel.layer.position.x + view.frame.size.width
        flyLeft.toValue = infoLabel.layer.position.x
        flyLeft.duration = 5.0
        infoLabel.layer.addAnimation(flyLeft, forKey: "infoappear")
        
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.2
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 4.5
        infoLabel.layer.addAnimation(fadeLabelIn, forKey: "fadein")
        
        userName.delegate = self
        passWord.delegate = self
    }
    
    
    // MARK: further methods
    
    @IBAction func login(sender: AnyObject)
    {
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBtn.bounds.size.width += 80.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBtn.center.y += 60.0
            
            
            self.spinner.center = CGPoint(x: 40.0, y: self.loginBtn.frame.size.height/2)
            self.spinner.alpha = 1.0
            
            }, completion: {_ in
                self.showMessage(index: 0)
        })
        
        let tintColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
        tintBackgroundColor(layer: loginBtn.layer, toColor: tintColor)
        roundCorners(layer: loginBtn.layer, toRadius: 25.0)
        
        let balloon = CALayer()
        balloon.contents = UIImage(named: "balloon")!.CGImage
        balloon.frame = CGRect(x: -50.0, y: 0.0,
            width: 50.0, height: 65.0)
        view.layer.insertSublayer(balloon, below: userName.layer)
        
        let flight = CAKeyframeAnimation(keyPath: "position")
        flight.duration = 12.0
        flight.values = [
            CGPoint(x: -50.0, y: 0.0),
            CGPoint(x: view.frame.width + 50.0, y: 160.0),
            CGPoint(x: -50.0, y: loginBtn.center.y)
            ].map { NSValue(CGPoint: $0) }
        flight.keyTimes = [0.0, 0.5, 1.0]
        balloon.addAnimation(flight, forKey: nil)
        balloon.position = CGPoint(x: -50.0, y: loginBtn.center.y)
    }
    
    func showMessage(index index: Int) {
        label.text = messages[index]
        
        UIView.transitionWithView(status, duration: 0.33, options:
            [.CurveEaseOut, .TransitionFlipFromBottom], animations: {
                self.status.hidden = false
            }, completion: {_ in
                //transition completion
                delay(seconds: 2.0) {
                    if index < self.messages.count-1 {
                        self.removeMessage(index: index)
                    } else {
                        //reset form
                        self.resetForm()
                    }
                }
        })
    }
    
    func removeMessage(index index: Int) {
        UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
            self.status.center.x += self.view.frame.size.width
            }, completion: {_ in
                self.status.hidden = true
                self.status.center = self.statusPosition
                
                self.showMessage(index: index+1)
        })
    }
    
    func resetForm() {
        UIView.transitionWithView(status, duration: 0.2, options: .TransitionFlipFromTop, animations: {
            self.status.hidden = true
            self.status.center = self.statusPosition
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0.0
            self.loginBtn.bounds.size.width -= 80.0
            self.loginBtn.center.y -= 60.0
            }, completion: {_ in
                let tintColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
                self.tintBackgroundColor(layer: self.loginBtn.layer, toColor: tintColor)
                self.roundCorners(layer: self.loginBtn.layer, toRadius: 10.0)
        })
        
        let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobble.duration = 0.25
        wobble.repeatCount = 4
        wobble.values = [0.0, -M_PI_4/4, 0.0, M_PI_4/4, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        loginTitle.layer.addAnimation(wobble, forKey: nil)
        
    }
    
    func animateCloud(layer: CALayer) {
        //1
        let cloudSpeed = 60.0 / Double(view.layer.frame.size.width)
        let duration: NSTimeInterval = Double(view.layer.frame.size.width - layer.frame.origin.x) * cloudSpeed
        
        //2
        let cloudMove = CABasicAnimation(keyPath: "position.x")
        cloudMove.duration = duration
        cloudMove.toValue = self.view.bounds.size.width + layer.bounds.width/2
        cloudMove.delegate = self
        cloudMove.setValue("cloud", forKey: "name")
        cloudMove.setValue(layer, forKey: "layer")
        
        layer.addAnimation(cloudMove, forKey: nil)
    }
    
    func tintBackgroundColor(layer layer: CALayer, toColor: UIColor) {
        
        //challenge #2
        let tint = CASpringAnimation(keyPath: "backgroundColor")
        tint.damping = 5.0
        tint.initialVelocity = -10.0
        tint.fromValue = layer.backgroundColor
        tint.toValue = toColor.CGColor
        tint.duration = tint.settlingDuration
        layer.addAnimation(tint, forKey: nil)
        layer.backgroundColor = toColor.CGColor
    }
    
    func roundCorners(layer layer: CALayer, toRadius: CGFloat) {
        
        //challenge #1
        let round = CASpringAnimation(keyPath: "cornerRadius")
        round.damping = 5.0
        round.fromValue = layer.cornerRadius
        round.toValue = toRadius
        round.duration = round.settlingDuration
        layer.addAnimation(round, forKey: nil)
        layer.cornerRadius = toRadius
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("animation did finish")
        
        if let name = anim.valueForKey("name") as? String {
            if name == "form" {
                //form field found
                let layer = anim.valueForKey("layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
                
                let pulse = CASpringAnimation(keyPath: "transform.scale")
                pulse.damping = 7.5
                pulse.fromValue = 1.25
                pulse.toValue = 1.0
                pulse.duration = pulse.settlingDuration
                layer?.addAnimation(pulse, forKey: nil)
            }
            
            if name == "cloud" {
                if let layer = anim.valueForKey("layer") as? CALayer {
                    anim.setValue(nil, forKey: "layer")
                    
                    layer.position.x = -layer.bounds.width/2
                    delay(seconds: 0.5, completion: {
                        self.animateCloud(layer)
                    })
                }
            }
        }
    } 
}

extension ViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(textField: UITextField) {
        print(infoLabel.layer.animationKeys())
        infoLabel.layer.removeAnimationForKey("infoappear")
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.characters.count < 5 {
            // add animations here
            let jump = CASpringAnimation(keyPath: "position.y")
            jump.initialVelocity = 100.0
            jump.mass = 10.0
            jump.stiffness = 1500.0
            jump.damping = 50.0
            
            jump.fromValue = textField.layer.position.y + 1.0
            jump.toValue = textField.layer.position.y
            jump.duration = jump.settlingDuration
            textField.layer.addAnimation(jump, forKey: nil)
            
            textField.layer.borderWidth = 3.0
            textField.layer.borderColor = UIColor.clearColor().CGColor
            
            let flash = CASpringAnimation(keyPath: "borderColor")
            flash.damping = 7.0
            flash.stiffness = 200.0
            flash.fromValue = UIColor(red: 0.96, green: 0.27, blue: 0.0, alpha: 1.0).CGColor
            flash.toValue = UIColor.clearColor().CGColor
            flash.duration = flash.settlingDuration
            textField.layer.addAnimation(flash, forKey: nil)
        }
    }
}

