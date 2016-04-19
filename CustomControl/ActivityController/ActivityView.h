//
//  ActivityView.h
//  ActivityController
//
//  Created by 倩倩 on 16/4/18.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityViewDelegate <NSObject>

@required

/**
 *  点击item
 *
 *  @param index 对应索引
 */
- (void)touchItemAtIndex:(NSInteger)index;

@end

@interface ActivityView : UIWindow

@property (nonatomic, assign) id <ActivityViewDelegate> delegate;

/**
 *  自定义view单例
 *
 *  @param imageArray 显示item图片
 *  @param titleArray 显示item title
 *
 *  @return
 */
+ (ActivityView *)sharedInstanceWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
