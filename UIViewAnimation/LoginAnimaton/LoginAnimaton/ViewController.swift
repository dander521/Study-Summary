//
//  ViewController.swift
//  LoginAnimaton
//
//  Created by 倩倩 on 16/3/20.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // IB
    @IBOutlet weak var animateHubImageView: UIImageView!
    @IBOutlet weak var dotImageView: UIImageView!
    
    @IBOutlet var bubbleGroupOne: [UIImageView]!
    @IBOutlet var bubbleGroupTwo: [UIImageView]!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var warningView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButtonConstraintTop: NSLayoutConstraint!
    @IBOutlet weak var loginButtonContraintWidth: NSLayoutConstraint!
    
    let activity = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for bubble in bubbleGroupOne
        {
            bubble.transform = CGAffineTransformMakeScale(0, 0)
        }
        
        for bubble in bubbleGroupTwo
        {
            bubble.transform = CGAffineTransformMakeScale(0, 0)
        }
        
        let paddingViewForUserName = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: userNameTextField.frame.height))
        userNameTextField.leftView = paddingViewForUserName
        userNameTextField.leftViewMode = .Always
        
        let userImageView = UIImageView(image: UIImage(named: "User"))
        userImageView.frame.origin = CGPoint(x: 13, y: 10)
        userNameTextField.addSubview(userImageView)
        
        let paddingViewForPassword = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: userNameTextField.frame.height))
        passwordTextField.leftView = paddingViewForPassword
        passwordTextField.leftViewMode = .Always
        
        let passwordImageView = UIImageView(image: UIImage(named: "Key"))
        passwordImageView.frame.origin = CGPoint(x: 13, y: 10)
        passwordTextField.addSubview(passwordImageView)
        
        
        animateHubImageView.transform = CGAffineTransformMakeTranslation(-view.frame.width, 0)
        dotImageView.transform = CGAffineTransformMakeTranslation(-view.frame.width, 0)
        userNameTextField.transform = CGAffineTransformMakeTranslation(-view.frame.width, 0)
        passwordTextField.transform = CGAffineTransformMakeTranslation(-view.frame.width, 0)
        loginButton.transform = CGAffineTransformMakeTranslation(-view.frame.width, 0)
    }

   
    @IBAction func didAnimateButtonClick(sender: AnyObject)
    {
        self.animate()
    }
    
    @IBAction func loginDidTap(sender: AnyObject) {
        loginButton.addSubview(activity)
        activity.frame.origin = CGPoint(x: 12, y: 12)
        activity.startAnimating()
        
        loginButtonConstraintTop.constant = 120
        loginButtonContraintWidth.constant -= 60
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.activity.removeFromSuperview()
                self.loginButtonContraintWidth.constant += 60
                UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [],
                    animations: {
                        self.view.layoutIfNeeded()
                    }, completion: nil
                )
                
                UIView.transitionWithView(self.warningView,
                    duration: 0.3,
                    options: [.TransitionFlipFromTop, .CurveEaseOut],
                    animations: {
                        self.warningView.hidden = false
                    }, completion: nil
                )
            }
        )
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Private methods
    private func animate() {
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [],
            animations: {
                for bubble in self.bubbleGroupOne {
                    bubble.transform = CGAffineTransformIdentity
                }
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [],
            animations: {
                for bubble in self.bubbleGroupTwo {
                    bubble.transform = CGAffineTransformIdentity
                }
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.animateHubImageView.transform = CGAffineTransformIdentity
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.6, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.dotImageView.transform = CGAffineTransformIdentity
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.3, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.userNameTextField.transform = CGAffineTransformIdentity
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.3, delay: 0.4, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.passwordTextField.transform = CGAffineTransformIdentity
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.3, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [],
            animations: {
                self.loginButton.transform = CGAffineTransformIdentity
            }, completion: nil
        )
    }
}

