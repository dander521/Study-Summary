//
//  SegmentedControl.h
//  SegmentedControlTest
//
//  Created by 程荣刚 on 16/3/14.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentedControlDelegate <NSObject>

/*!
 *  点击控件
 *
 *  @param index 控件内按钮索引
 */
- (void)touchSegmentedControlWithIndex:(NSUInteger)index;

@end

@interface SegmentedControl : UIView

@property (nonatomic, assign) id <SegmentedControlDelegate> delegate;

@property (nonatomic, strong) NSArray *itemsArray; // 文字内容数组

@property (nonatomic, strong) UIColor *titleNormalColor; // 文字正常颜色
@property (nonatomic, strong) UIColor *titleSelectedColor; // 文字选中颜色
@property (nonatomic, strong) UIColor *bottomViewColor; // 底部view颜色

@property (nonatomic, strong) UIFont *titleFont; // 文字大小
@property (nonatomic, assign) NSUInteger selectedIndex; // 选中按钮的索引


/*!
 *  设置单例
 *
 *  @return 单例对象
 */
+ (instancetype)shareSegmentedControl;

@end
