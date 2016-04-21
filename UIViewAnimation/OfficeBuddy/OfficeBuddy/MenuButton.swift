//
//  MenuButton.swift
//  OfficeBuddy
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class MenuButton: UIView {

    var imageView: UIImageView!
    var tapHandler: (()->())?
    
    override func didMoveToSuperview() {
        frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTap")))
        addSubview(imageView)
    }
    
    func didTap()
    {
        tapHandler?()
    }

}
