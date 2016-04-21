//
//  SublistTableViewCell.h
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SublistTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;


@end
