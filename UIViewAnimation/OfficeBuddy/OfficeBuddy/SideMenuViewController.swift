//
//  SideMenuViewController.swift
//  OfficeBuddy
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {
    
    var centerViewController: CenterViewController!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.sharedItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as UITableViewCell
        
        let menuItem = MenuItem.sharedItems[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 36.0)
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = menuItem.symbol
        
        cell.contentView.backgroundColor = menuItem.color
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCellWithIdentifier("HeaderCell")!
    }
    
    override func tableView(tableView:UITableView, heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat {
        return 84.0
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated:true)
        
        centerViewController.menuItem = MenuItem.sharedItems[indexPath.row]
        
        let containerVC = parentViewController as! ContainerViewController
        containerVC.toggleSideMenu()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}
