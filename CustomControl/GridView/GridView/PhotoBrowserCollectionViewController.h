//
//  PhotoBrowserCollectionViewController.h
//  PhotoBrowserTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStatus.h"

@interface PhotoBrowserCollectionViewController : UICollectionViewController

@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, strong) ImageStatus *imageStatus;

@end
