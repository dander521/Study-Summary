//
//  PreviewImageView.h
//  BATeacher
//
//  Created by ivan on 15/7/14.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewImageView : UIView

+ (PreviewImageView *)sharedInstance;


/**
 *  加载图片
 *
 *  @param imageArray 显示图片的数组，image对象
 *  @param index      当前显示的图片，在数组中的位置
 *  @param point      弹出图片的坐标
 */
- (void)showImage:(NSArray *)imageArray
      selectIndex:(int)index
        fromPoint:(CGPoint)point;


/**
 *  加载动态的图片
 *
 *  @param momentId   显示动态图片的id
 *  @param index      当前显示的图片，在数组中的位置
 *  @param point      弹出图片的坐标
 */
- (void)showMomentAttachImage:(NSString *)momentId
                  selectIndex:(int)index
                    fromPoint:(CGPoint)point;

@end
