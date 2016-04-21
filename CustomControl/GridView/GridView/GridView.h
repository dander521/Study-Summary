//
//  GridView.h
//  GridViewTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageStatus.h"

@protocol GridViewDelegate <NSObject>

- (void)selectImageViewAtIndex:(NSIndexPath *)indexPath;

@end

@interface GridView : UICollectionView

@property (nonatomic, strong) ImageStatus *imageStatus;
@property (nonatomic, assign) id <GridViewDelegate> gridViewdelegate;

@end
