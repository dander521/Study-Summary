//
//  TableViewHeaderView.m
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        // code
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
 
- (UIImageView *)imageView {
    if(_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if(_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(45, 1, self.frame.size.width - 50, 42)];
        _titleLable.numberOfLines = 2;
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLable];
    }
    return _titleLable;
}

#pragma mark - Tap 

- (void)tapView:(UITapGestureRecognizer *)tapGesture
{
    if ([self.delegate respondsToSelector:@selector(tapTableViewHeaderView:)])
    {
        [self.delegate tapTableViewHeaderView:self.selectSection];
    }
}


@end
