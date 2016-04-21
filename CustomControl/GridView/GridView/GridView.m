//
//  GridView.m
//  GridViewTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "GridView.h"
#import "GridViewCollectionViewCell.h"

static NSString * const reuseIdentifier = @"GridViewCollectionViewCell";

@interface GridView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation GridView

- (id)init
{
    if (self == [super initWithFrame:CGRectZero collectionViewLayout:self.flowLayout])
    {
        [self registerNib:[UINib nibWithNibName:@"GridViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageStatus.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.displayImageView.image = [UIImage imageNamed:[self.imageStatus.imageArray objectAtIndex:indexPath.item]];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.gridViewdelegate respondsToSelector:@selector(selectImageViewAtIndex:)])
    {
        [self.gridViewdelegate selectImageViewAtIndex:indexPath];
    }
}


#pragma mark - Calculator Size

- (CGSize)calculatorGridViewSize
{
    if (self.imageStatus.imageArray.count == 1)
    {
        UIImage *image = [UIImage imageNamed:[self.imageStatus.imageArray lastObject]];
        CGSize size = CGSizeZero;
        size.width = image.size.width > 200 ? 200 : image.size.width;
        size.height = image.size.height > 200 ? 200 : image.size.height;
        self.flowLayout.itemSize = size;
        return size;
    }
    
    float imageMargin = 10;
    float imageWidth = ([UIScreen mainScreen].bounds.size.width - 40)/3;
    float imageHeight = imageWidth;
    
    self.flowLayout.itemSize = CGSizeMake(imageWidth, imageHeight);
    
    if (self.imageStatus.imageArray.count == 4)
    {
        // 宽度 =  配图的宽度 * 2 + 间隙
        float width = imageWidth * 2 + imageMargin;
        // 高度 = 宽度
        return CGSizeMake(width, width);
    }
    
    // 4.1计算列数和行数
    NSUInteger col = 3;
    NSUInteger row = (self.imageStatus.imageArray.count - 1) / 3 + 1;
    // 宽度 = 列数 * 配图宽度 + (列数 - 1) * 间隙
    float width = col * imageWidth + (col - 1) * imageMargin;
    // 高度 = 行数 * 配图高度 + (行数 - 1) * 间隙
    float height = row * imageHeight + (row - 1) * imageMargin;
    
    return CGSizeMake(width, height);
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

#pragma mark - Setter

- (void)setImageStatus:(ImageStatus *)imageStatus
{
    if (_imageStatus != imageStatus)
    {
        _imageStatus = imageStatus;
        CGSize size = [self calculatorGridViewSize];
        self.frame = CGRectMake(10, 10, size.width, size.height);
    }
}


@end
