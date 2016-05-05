//
//  RCExpandHeader.h
//  RCExpandHeader
//
//  Created by 程荣刚 on 15/12/28.
//  Copyright © 2015年 rongkecloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RCExpandHeader : NSObject <UIScrollViewDelegate>

#pragma mark - 类方法

/**
 *  生成一个RCExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 对象
 */
+ (id)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView;


#pragma mark - 成员方法

/**
 *  生成一个RCExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView
 */
- (void)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView;

/**
 *  监听scrollViewDidScroll方法
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
