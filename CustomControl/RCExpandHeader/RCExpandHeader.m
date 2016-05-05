//
//  RCExpandHeader.m
//  RCExpandHeader
//
//  Created by 程荣刚 on 15/12/28.
//  Copyright © 2015年 rongkecloud. All rights reserved.
//

#import "RCExpandHeader.h"
#import "Definition.h"

#define RCExpandContentOffset @"contentOffset"

@implementation RCExpandHeader
{
    __weak UIScrollView *_scrollView; // scrollView或者其子类
    __weak UIView *_expandView; // 背景可以伸展的View
    
    CGFloat _expandHeight; // 扩张高度
}

// 重置_scrollView KVO _expandView
- (void)dealloc{
    if (_scrollView)
    {
        [_scrollView removeObserver:self forKeyPath:RCExpandContentOffset];
        _scrollView = nil;
    }
    _expandView = nil;
}

/**
 *  生成一个RCExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 对象
 */
+ (id)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView
{
    RCExpandHeader *expandHeader = [RCExpandHeader new];
    [expandHeader expandWithScrollView:scrollView expandView:expandView];
    return expandHeader;
}

/**
 *  生成一个RCExpandHeader实例
 *
 *  @param scrollView
 *  @param expandView
 */
- (void)expandWithScrollView:(UIScrollView *)scrollView expandView:(UIView *)expandView
{
    _expandHeight = [UIScreen mainScreen].bounds.size.height/4;
    
    _scrollView = scrollView;
    
    _scrollView.contentInset = UIEdgeInsetsMake(_expandHeight, 0, 0, 0);
    [_scrollView insertSubview:expandView atIndex:0];
    [_scrollView addObserver:self forKeyPath:RCExpandContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView setContentOffset:CGPointMake(0, -_expandHeight)];
    
    _expandView = expandView;
    
    // 使View可以伸展效果  重要属性
    _expandView.contentMode= UIViewContentModeScaleAspectFill;
    _expandView.clipsToBounds = YES;
    
    [self reSizeView];
}

// 添加监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![keyPath isEqualToString:RCExpandContentOffset])
    {
        return;
    }
    
    [self scrollViewDidScroll:_scrollView];
}

// 滑动的限制
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < _expandHeight * -1)
    {
        CGRect currentFrame = _expandView.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -1*offsetY;
        _expandView.frame = currentFrame;
    }
}

//重置_expandView位置
- (void)reSizeView
{
    [_expandView setFrame:CGRectMake(0, -1*_expandHeight, CGRectGetWidth(_expandView.frame), _expandHeight)];
}


@end
