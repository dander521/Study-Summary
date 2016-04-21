//
//  CenterViewController.swift
//  OfficeBuddy
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class CenterViewController: UIViewController {
    
    var menuItem: MenuItem! {
        
        didSet {
            navigationItem.title = menuItem.title
            view.backgroundColor = menuItem.color
            symbol.text = menuItem.symbol
        }
    }
    
    @IBOutlet weak var symbol: UILabel!
    
    var menuButton: MenuButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton = MenuButton()
        
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parentViewController as? ContainerViewController {
//                containerVC.toggleSideMenu()
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuItem = MenuItem.sharedItems.first!
    }
    
    
}
