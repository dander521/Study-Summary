//
//  TableViewHeaderView.h
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewHeaderViewDelegate <NSObject>

- (void)tapTableViewHeaderView:(NSUInteger)section;

@end

@interface TableViewHeaderView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, assign) NSUInteger selectSection;
@property (nonatomic, assign) id <TableViewHeaderViewDelegate> delegate;

@end
