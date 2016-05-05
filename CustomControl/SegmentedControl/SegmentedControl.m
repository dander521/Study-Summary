//
//  SegmentedControl.m
//  SegmentedControlTest
//
//  Created by 程荣刚 on 16/3/14.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "SegmentedControl.h"

#define kSegmentedOriginY               49 // 控件y坐标
#define kSegmentedHeight                68 // 控件高度

#define kSegmentedControlMargin         30 // 内部距离
#define kSegmentedBottomLabelOriginY    54 // 底部view y坐标
#define kSegmentedBottomLabelHeight      2 // 底部view 高度

#define kSegmentedControlLeftButtonTag   0 // 左侧按钮tag
#define kSegmentedControlRightButtonTag  1 // 右侧按钮tag

#define kSegmentedControlAnimateTime   0.25 // 底部view 动画时间

@interface SegmentedControl ()

@property (weak, nonatomic) IBOutlet UIButton *leftButton; // 左按钮
@property (weak, nonatomic) IBOutlet UIButton *rightButton; // 右按钮

@property (weak, nonatomic) IBOutlet UILabel *bottomLabel; // 底部背景view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLabelCenterConstraint; // 背景view水平约束

@end

@implementation SegmentedControl

/*!
 *  设置单例
 *
 *  @return 单例对象
 */
+ (instancetype)shareSegmentedControl
{
    SegmentedControl *segmented = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SegmentedControl class]) owner:self options:nil].lastObject;
    
    segmented.frame = CGRectMake(0, kSegmentedOriginY, [UIScreen mainScreen].bounds.size.width, kSegmentedHeight);
    
    [segmented.leftButton.titleLabel setFont: [UIFont boldSystemFontOfSize: 18.0]];
    [segmented.rightButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0]];
    
    
    segmented.selectedIndex = 0;
    
    return segmented;
}

#pragma mark - Touch 

- (IBAction)touchLeftButton:(id)sender
{
    self.selectedIndex = 0;
    if ([self.delegate respondsToSelector:@selector(touchSegmentedControlWithIndex:)])
    {
        [self.delegate touchSegmentedControlWithIndex:kSegmentedControlLeftButtonTag];
    }
    [self.leftButton.titleLabel setFont: [UIFont boldSystemFontOfSize: 18.0]];
    [self.rightButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0]];
    
    self.bottomLabelCenterConstraint.constant = self.leftButton.frame.size.width / 2 + self.leftButton.frame.origin.x - self.bottomLabel.frame.size.width / 2 - kSegmentedControlMargin;
    CGRect bounds = CGRectMake(kSegmentedControlMargin, kSegmentedBottomLabelOriginY, self.leftButton.bounds.size.width, kSegmentedBottomLabelHeight);
    
    [UIView animateWithDuration:kSegmentedControlAnimateTime animations:^{
        self.bottomLabel.bounds = bounds;
        [self.bottomLabel layoutIfNeeded];
    }];
}

- (IBAction)touchRightButton:(id)sender
{
    self.selectedIndex = 1;
    if ([self.delegate respondsToSelector:@selector(touchSegmentedControlWithIndex:)])
    {
        [self.delegate touchSegmentedControlWithIndex:kSegmentedControlRightButtonTag];
    }
    
    [self.leftButton.titleLabel setFont: [UIFont systemFontOfSize: 18.0]];
    [self.rightButton.titleLabel setFont: [UIFont boldSystemFontOfSize: 18.0]];
    
    self.bottomLabelCenterConstraint.constant = self.rightButton.frame.size.width / 2 + self.rightButton.frame.origin.x - self.bottomLabel.frame.size.width / 2 - kSegmentedControlMargin;
    CGRect bounds = CGRectMake(3*kSegmentedControlMargin + self.leftButton.bounds.size.width, kSegmentedBottomLabelOriginY, self.rightButton.bounds.size.width, kSegmentedBottomLabelHeight);
    
    [UIView animateWithDuration:kSegmentedControlAnimateTime animations:^{
        self.bottomLabel.bounds = bounds;
        [self.bottomLabel layoutIfNeeded];
    }];
}

#pragma mark - Setter

- (void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = itemsArray;
    [self.leftButton setTitle:itemsArray[0] forState:UIControlStateNormal];
    [self.rightButton setTitle:itemsArray[1] forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.leftButton.titleLabel.font = titleFont;
    self.rightButton.titleLabel.font = titleFont;
}

- (void)setBottomViewColor:(UIColor *)bottomViewColor
{
    _bottomViewColor = bottomViewColor;
    self.bottomLabel.backgroundColor = bottomViewColor;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    switch (selectedIndex)
    {
        case 0:
        {
            [self.leftButton setTitleColor:self.titleSelectedColor forState:UIControlStateNormal];
            [self.rightButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [self.leftButton setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
            [self.rightButton setTitleColor:self.titleSelectedColor forState:UIControlStateNormal];
        }
            break;
    }
}


@end
