//
//  PreviewImageView.m
//  BATeacher
//
//  Created by ivan on 15/7/14.
//  Copyright (c) 2015年 Yoowa. All rights reserved.
//

#import "PreviewImageView.h"
#import "ShowImageScrollView.h"
#import "MomentManager.h"
#import "MomentAttachTable.h"
#import "MomentAttachManager.h"
#import "AppDelegate.h"
#import "DatabaseManager+MomentAttachTable.h"

static CGPoint orignalPoint;
@interface PreviewImageView ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) int imageCount;

@end

@implementation PreviewImageView


+ (PreviewImageView *)sharedInstance
{
    static dispatch_once_t dbConvertor;
    static PreviewImageView *previewImageView = nil;
    dispatch_once(&dbConvertor, ^{
        previewImageView = [[PreviewImageView alloc] init];
        previewImageView.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 31, UISCREEN_BOUNDS_SIZE.width, 22)];
        [previewImageView.titleLabel setBackgroundColor: [UIColor clearColor]];
        previewImageView.titleLabel.font = [UIFont systemFontOfSize: 17.0];
        previewImageView.titleLabel.textColor = [UIColor whiteColor];
        [previewImageView.titleLabel setTextAlignment: NSTextAlignmentCenter];
    });
    return previewImageView;
}

- (void)dealloc
{
    self.titleLabel = nil;
}

/**
 *  加载图片
 *
 *  @param imageArray 显示图片的数组，image对象
 *  @param index      当前显示的图片，在数组中的位置
 *  @param point      弹出图片的坐标
 */
- (void)showImage:(NSArray *)imageArray
      selectIndex:(int)index
        fromPoint:(CGPoint)point
{
    orignalPoint = CGPointMake(point.x, point.y);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *showImageView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame: showImageView.frame];
    [imageScrollView setContentSize: CGSizeMake([UIScreen mainScreen].bounds.size.width * [imageArray count], [UIScreen mainScreen].bounds.size.height)];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.delegate = self;
    
    [showImageView addSubview: imageScrollView];
    
    // UIImageView *imageView = nil;
    ShowImageScrollView *imageView = nil;
    for (int i = 0; i < [imageArray count]; i++)
    {
        imageView = [[ShowImageScrollView alloc] initWithFrame: CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withImage: [imageArray objectAtIndex: i]];
        // [imageView setContentMode: UIViewContentModeScaleAspectFit];
        [imageScrollView addSubview: imageView];
    }
    
    [imageScrollView scrollRectToVisible:CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) animated: NO];
    
    if ([imageArray count] > 1)
    {
        pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(0, showImageView.frame.size.height - 50, [UIScreen mainScreen].bounds.size.width,  20)];
        pageControl.numberOfPages = [imageArray count];
        
        pageControl.currentPage = index;
        [showImageView addSubview: pageControl];
    }
    
    [window addSubview:showImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenImage:)];
    
    [showImageView addGestureRecognizer: tapGesture];
    
    showImageView.backgroundColor = [UIColor blackColor];
    showImageView.center = orignalPoint;
    showImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    showImageView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        showImageView.center = window.center;
        showImageView.transform = CGAffineTransformIdentity;
        showImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = YES;
    }];
    
}

- (void)hiddenImage:(UITapGestureRecognizer *)gestureRecognizer
{
    UIView *showImageView = gestureRecognizer.view;
    [UIView animateWithDuration:0.3 animations:^{
        showImageView.center = orignalPoint;
        showImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        showImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [showImageView removeFromSuperview];
    }];
}


/**
 *  加载动态的图片
 *
 *  @param momentId   显示动态图片的id
 *  @param index      当前显示的图片，在数组中的位置
 *  @param point      弹出图片的坐标
 */
- (void)showMomentAttachImage:(NSString *)momentId
                  selectIndex:(int)index
                    fromPoint:(CGPoint)point
{
    orignalPoint = CGPointMake(point.x, point.y);
    AppDelegate *appDelegate = [AppDelegate appDelegate];
    
    NSArray *attachImageArray = [appDelegate.databaseManager getAllMomentAttachTableByMomentId: momentId];
    self.imageCount = (int)[attachImageArray count];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", index+1, self.imageCount];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *showImageView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame: showImageView.frame];
    [imageScrollView setContentSize: CGSizeMake([UIScreen mainScreen].bounds.size.width * [attachImageArray count], [UIScreen mainScreen].bounds.size.height)];
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.delegate = self;
    
    [showImageView addSubview: imageScrollView];
    
    // UIImageView *imageView = nil;
    ShowImageScrollView *imageView = nil;
    MomentAttachTable *attTable = nil;
    for (int i = 0; i < [attachImageArray count]; i++)
    {
        attTable = [attachImageArray objectAtIndex: i];
        
        imageView = [[ShowImageScrollView alloc] initWithFrame: CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imageView.attachTable = attTable;
        // [imageView setContentMode: UIViewContentModeScaleAspectFit];
        [imageScrollView addSubview: imageView];
    }
    
    [imageScrollView scrollRectToVisible:CGRectMake(index * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) animated: NO];
    
    if ([attachImageArray count] > 1)
    {
        pageControl = [[UIPageControl alloc] initWithFrame: CGRectMake(0, showImageView.frame.size.height - 50, [UIScreen mainScreen].bounds.size.width,  20)];
        pageControl.numberOfPages = [attachImageArray count];
        
        pageControl.currentPage = index;
        [showImageView addSubview: pageControl];
    }
    
    [window addSubview:showImageView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenImage:)];
    
    [showImageView addGestureRecognizer: tapGesture];
    
    showImageView.backgroundColor = [UIColor blackColor];
    showImageView.center = orignalPoint;
    showImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    showImageView.alpha = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        showImageView.center = window.center;
        showImageView.transform = CGAffineTransformIdentity;
        showImageView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int currentIndex = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    pageControl.currentPage = currentIndex;
    // self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", currentIndex+1, self.imageCount];

}


@end
