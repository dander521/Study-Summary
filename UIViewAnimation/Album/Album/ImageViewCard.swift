//
//  ImageViewCard.swift
//  Album
//
//  Created by 倩倩 on 16/4/13.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class ImageViewCard: UIImageView {

    var title: String!
    var didSelect: ((ImageViewCard)->())?
    
    convenience init(imageNamed: String, title name: String)
    {
        self.init()
        
        image = UIImage(named: imageNamed)
        contentMode = .ScaleAspectFill
        clipsToBounds = true
        
        title = name
        
        autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
    }
    
    override func didMoveToSuperview() {
        userInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapHandler:")))
    }

    func didTapHandler(tap: UITapGestureRecognizer)
    {
        didSelect?(self)
    }
}
