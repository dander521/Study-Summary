//
//  ViewController.m
//  ActivityController
//
//  Created by 倩倩 on 16/4/18.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

#import "ViewController.h"
#import "ActivityView.h"

@interface ViewController ()<ActivityViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)touchShareButton:(id)sender
{
    ActivityView *activityView = [ActivityView sharedInstanceWithImageArray:@[@"wechat_logo", @"wechat_moments", @"wechat_logo", @"wechat_moments"]
                                                                 titleArray:@[@"微信", @"朋友圈", @"微信", @"朋友圈"]];
    activityView.delegate = self;
    
    [activityView show];
}

#pragma mark - ActivityViewDelegate

- (void)touchItemAtIndex:(NSInteger)index
{
    NSLog(@"index = %ld", (long)index);
    
    switch (index)
    {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            
        }
            break;
            
        case 2:
        {
            
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
