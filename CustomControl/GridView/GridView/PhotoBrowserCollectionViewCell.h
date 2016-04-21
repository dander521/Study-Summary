//
//  PhotoBrowserCollectionViewCell.h
//  GridViewTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStatus.h"

@protocol PhotoBrowserCollectionViewCellDelegate <NSObject>

- (void)tapImageView;

- (void)longPressImageView;

@end

@interface PhotoBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, assign) id <PhotoBrowserCollectionViewCellDelegate> delegate;

@end
