//
//  ViewController.h
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TreeTableViewViewControllerDelegate <NSObject>

- (void)touchSubmitButton;

- (void)touchCancelButton;

- (void)selectSubFlag:(NSString *)subFlagId;

@end

@interface TreeTableViewViewController : UIViewController

@property (nonatomic, assign) id <TreeTableViewViewControllerDelegate> delegate;

@end

