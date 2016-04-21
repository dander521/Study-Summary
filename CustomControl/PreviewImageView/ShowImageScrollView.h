//
//  ShowImageScrollView.h
//  IMC
//
//  Created by ivan on 15/11/1.
//  Copyright © 2015年  ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MomentAttachTable;

@interface ShowImageScrollView : UIScrollView

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) MomentAttachTable *attachTable;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image;

@end
