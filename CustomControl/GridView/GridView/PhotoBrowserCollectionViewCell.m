//
//  PhotoBrowserCollectionViewCell.m
//  GridViewTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "PhotoBrowserCollectionViewCell.h"

@interface PhotoBrowserCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

@end

@implementation PhotoBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Custom Method

- (void)setupUI
{
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.contentView addSubview:self.activity];
    
    self.scrollView.frame = self.bounds;
    self.activity.center = self.contentView.center;
}

- (void)setupImagePosition
{
    // 1.拿到图片高宽比
    float s = self.imageView.image.size.height / self.imageView.image.size.width;
    // 2.按照图片的宽高比缩放图片, 保证能够显示整张图片
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float height = s * screenWidth;
    
    self.imageView.frame = CGRectMake(0, 0, screenWidth, height);
    
    // 3.判断当前是长图还是短图
    if (height > screenHeight)
    {
        NSLog(@"长图");
        self.scrollView.contentSize = self.imageView.bounds.size;
    } else {
       NSLog(@"短图");
        // 3.计算Y值
        float y = ([UIScreen mainScreen].bounds.size.height - height) * 0.5;
        self.scrollView.contentInset = UIEdgeInsetsMake(y, 0, 0, y);
    }
}

- (void)resetScrollView
{
    self.imageView.transform = CGAffineTransformIdentity;
    
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointZero;;
    self.scrollView.contentSize = CGSizeZero;
}

#pragma mark - Lazy Init

- (UIImageView *)imageView {
	if(_imageView == nil) {
		_imageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_imageView addGestureRecognizer:tapGesture];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)];
        [_imageView addGestureRecognizer:longPress];
        _imageView.userInteractionEnabled = YES;
	}
	return _imageView;
}

- (UIScrollView *)scrollView {
	if(_scrollView == nil) {
		_scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 0.5;
	}
	return _scrollView;
}

- (UIActivityIndicatorView *)activity {
	if(_activity == nil) {
		_activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	}
	return _activity;
}

#pragma mark - UIGestureRecognizer

- (void)tapGesture:(UITapGestureRecognizer *)tap
{
    NSLog(@"tapGesture");
    if ([self.delegate respondsToSelector:@selector(tapImageView)])
    {
        [self.delegate tapImageView];
    }
}

- (void)longGesture:(UILongPressGestureRecognizer *)longPress
{
    NSLog(@"longGesture");
    if ([self.delegate respondsToSelector:@selector(longPressImageView)])
    {
        [self.delegate longPressImageView];
    }
}


#pragma mark - Setter

- (void)setPhotoImage:(UIImage *)photoImage
{
    if (_photoImage != photoImage)
    {
        _photoImage = photoImage;
        
        // 1.重置cell所有属性 避免重用导致异常
        [self resetScrollView];
        
        self.imageView.image = photoImage;
        
        [self setupImagePosition];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    // 注意: scrollview缩放内部的实现原理其实是利用transform实现的,
    // 如果是利用transform缩放控件, 那么bounds不会改变, 只有frame会改变
    
//    NSLog(@"view.frame.width = %f, view.frame.height = %f, view.bounds.width = %f, view.bounds.height = %f", view.frame.size.width, view.frame.size.height, view.bounds.size.width, view.bounds.size.height);
    // 重新调整图片的位置
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float offsetY = (screenHeight - view.frame.size.height) * 0.5;
    
    // 注意: 如果offsetY是负数, 会导致高度显示不完整
    offsetY = offsetY < 0 ? 0 : offsetY;
    
    float offsetX = (screenWidth - view.frame.size.width) * 0.5;
    
    // 注意: 如果offsetX负数, 会导致高度显示不完整
    offsetX = offsetX < 0 ? 0 : offsetX;
    
    scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, offsetY, offsetX);
}

@end
