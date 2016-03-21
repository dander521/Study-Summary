//
//  ViewController.swift
//  NewAnimationLogin
//
//  Created by 倩倩 on 16/3/21.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var cloudOne: UIImageView!
    @IBOutlet weak var cloudTwo: UIImageView!
    @IBOutlet weak var cloudThree: UIImageView!
    @IBOutlet weak var cloudFour: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBt: UIButton!
    
    // MARK: future UI
    
    let promptView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let statusView = UIImageView(image: UIImage(named: "banner"))
    let statusText = UILabel()
    let statusMessages = ["Connecting","Authorizing","Sending credentials","Failed"]
    
    var statusPosition = CGPointZero
    
    // MARK: Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // setup UI
        loginBt.layer.cornerRadius = 8.0
        loginBt.layer.masksToBounds = true
        
        promptView.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        promptView.startAnimating()
        promptView.alpha = 0.0
        loginBt.addSubview(promptView)
        
        statusView.hidden = true
        statusView.center = loginBt.center
        view.addSubview(statusView)
        
        statusText.frame = CGRect(x: 0.0, y: 0.0, width: statusView.frame.width, height: statusView.frame.height)
        statusText.font = UIFont(name: "HelveticaNeue", size: 18.0)
        statusText.textAlignment = .Center
        statusView.addSubview(statusText)
        
        statusPosition = statusView.center
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.center.x -= view.bounds.width
        nameField.center.x -= view.bounds.width
        passwordField.center.x -= view.bounds.width
        
        cloudOne.alpha = 0.0
        cloudTwo.alpha = 0.0
        cloudThree.alpha = 0.0
        cloudFour.alpha = 0.0
        
        loginBt.center.y += 30.0
        loginBt.alpha = 0.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: {
            self.nameLabel.center.x += self.view.bounds.width
        })
        
        UIView.animateWithDuration(2.0, delay: 0.3, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: [], animations: {
            self.nameField.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(2.0, delay: 0.4, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.0, options: [], animations: {
            self.passwordField.center.x += self.view.bounds.width
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations: {
            self.cloudOne.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.7, options: [], animations: {
            self.cloudTwo.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.9, options: [], animations: {
            self.cloudThree.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 1.1, options: [], animations: {
            self.cloudFour.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBt.center.y -= 30.0
            self.loginBt.alpha = 1.0
            }, completion: nil)
        
        self.animateCloud(cloudOne)
        self.animateCloud(cloudTwo)
        self.animateCloud(cloudThree)
        self.animateCloud(cloudFour)
    }
    
    // MARK: Touch Method
    
    @IBAction func didLoginBtClicked(sender: AnyObject)
    {
        UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                self.loginBt.bounds.size.width += 80
            }, completion: nil)
        
        UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginBt.center.y += 60.0
            self.loginBt.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
            self.promptView.center = CGPoint(x: 40.0, y: self.loginBt.frame.size.height/2)
            self.promptView.alpha = 1.0
            
            }, completion: {_ in
                self.showMessage(index: 0)
        })
    }
    
    
    // MARK: Custom Method
    
    
    func showMessage(index index: Int)
    {
        statusText.text = statusMessages[index]
        
        UIView.transitionWithView(statusView, duration: 0.33, options:
            [.CurveEaseOut, .TransitionFlipFromBottom], animations: {
                self.statusView.hidden = false
            }, completion: {_ in
                //transition completion
                delay(seconds: 2.0) {
                    if index < self.statusMessages.count-1 {
                        self.removeMessage(index: index)
                    } else {
                        //reset form
                        self.resetForm()
                    }
                }
        })
    }
    
    
    func removeMessage(index index: Int)
    {
        UIView.animateWithDuration(0.33, delay: 0.0, options: [], animations: {
            self.statusView.center.x += self.view.frame.size.width
            }, completion: {_ in
                self.statusView.hidden = true
                self.statusView.center = self.statusPosition
                
                self.showMessage(index: index+1)
        })
    }
    
    
    func resetForm()
    {
        UIView.transitionWithView(statusView, duration: 0.2, options: .TransitionFlipFromTop, animations: {
            self.statusView.hidden = true
            self.statusView.center = self.statusPosition
            }, completion: nil)
        
        UIView.animateWithDuration(0.2, delay: 0.0, options: [], animations: {
            self.promptView.center = CGPoint(x: -20.0, y: 16.0)
            self.promptView.alpha = 0.0
            self.loginBt.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
            self.loginBt.bounds.size.width -= 80.0
            self.loginBt.center.y -= 60.0
            }, completion: nil)
    }
    
    
    func animateCloud(cloud: UIImageView)
    {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animateWithDuration(NSTimeInterval(duration), delay: 0.0, options: .CurveLinear, animations:
            {
                cloud.frame.origin.x = self.view.frame.width
            }, completion: {_ in
                cloud.frame.origin.x = -cloud.frame.width
                self.animateCloud(cloud)
        })
    }
    
    // MARK: UIResponder
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        self.nameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    
}

