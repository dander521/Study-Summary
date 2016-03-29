//
//  HorizontalItemList.swift
//  SummerHoliday
//
//  Created by 倩倩 on 16/3/28.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

import UIKit

class HorizontalItemList: UIScrollView {
    var didSelectItem:((index : Int) -> ())?
    
    let buttonWidth: CGFloat = 60.0
    let padding: CGFloat = 10.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(inView: UIView)
    {
        let rect = CGRect (x: inView.bounds.width, y: 120.0, width: inView.frame.width, height: 80.0)
        self.init(frame: rect)
        
        self.alpha = 0.0
        
        for var i = 0; i < 10; i++
        {
            let image = UIImage(named: "summericons_100px_0\(i).png")
            let imageView = UIImageView(image: image)
            imageView.center = CGPoint(x: CGFloat(i) * buttonWidth + buttonWidth/2, y: buttonWidth/2)
            imageView.tag = i
            imageView.userInteractionEnabled = true
            addSubview(imageView)
            
            let tap = UITapGestureRecognizer(target: self, action: "didTapImage:")
            imageView.addGestureRecognizer(tap)
        }
        
        contentSize = CGSize(width: padding * buttonWidth, height: buttonWidth + 2*padding)
    }
    
    func didTapImage(tap: UITapGestureRecognizer)
    {
        didSelectItem?(index: tap.view!.tag)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview == nil
        {
            return
        }
        
        UIView.animateWithDuration(1.0, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10.0, options: .CurveEaseIn, animations: {
                self.alpha = 1.0
                self.center.x -= self.frame.size.width
            }, completion: nil)
        
    }
}
