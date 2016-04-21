//
//  ShowImageScrollView.m
//  IMC
//
//  Created by ivan on 15/11/1.
//  Copyright © 2015年  ivan. All rights reserved.
//

#import "ShowImageScrollView.h"
#import "UIAlertView+CustomAlertView.h"
#import "AppDelegate.h"
#import "MomentAttachManager.h"
#import "MomentManager.h"
#import "MomentAttachTable.h"

@interface ShowImageScrollView ()<UIScrollViewDelegate, UIActionSheetDelegate>


@end

@implementation ShowImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        _showImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _showImageView.userInteractionEnabled = YES;
        [_showImageView setContentMode: UIViewContentModeScaleAspectFit];
        [self addSubview: _showImageView];
        //设置最大伸缩比例
        self.maximumZoomScale = 2.0;
        //设置最小伸缩比例
        self.minimumZoomScale = 1.0;
        self.delegate = self;
        
        
        UIButton *saveButton = [[UIButton alloc] initWithFrame: CGRectMake(UISCREEN_BOUNDS_SIZE.width - 100, UISCREEN_BOUNDS_SIZE.height - 50, 80, 30)];
        [saveButton setBackgroundColor: [UIColor clearColor]];
        [saveButton setTitle:@"保存" forState: UIControlStateNormal];
        [saveButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        [saveButton addTarget:self action:@selector(touchSaveButton) forControlEvents:UIControlEventTouchUpInside];
        // [_showImageView addSubview: saveButton];
        
        
        saveButton.layer.masksToBounds = YES;
        saveButton.layer.cornerRadius = 3.0;
        saveButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        saveButton.layer.borderWidth = 1.0;
        
        
        [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(updateAttachImageNotification:) name:kMomentModuleNotification object: nil];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action: @selector(longPressMethods:)];
        [_showImageView addGestureRecognizer: longPress];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)image
{
    self = [super initWithFrame: frame];
    if (self) {
        _showImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _showImageView.userInteractionEnabled = YES;
        _showImageView.image = image;
        [_showImageView setContentMode: UIViewContentModeScaleAspectFit];
        [self addSubview: _showImageView];
        //设置最大伸缩比例
        self.maximumZoomScale = 2.0;
        //设置最小伸缩比例
        self.minimumZoomScale = 1.0;
        self.delegate = self;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action: @selector(longPressMethods:)];
        [_showImageView addGestureRecognizer: longPress];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    self.showImageView.image = nil;
    [self.showImageView removeFromSuperview];
    self.showImageView = nil;
    self.attachTable = nil;
}

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _showImageView;
}

- (void)longPressMethods:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        [self saveImageToDevice: nil];
    }
}

#pragma mark -
#pragma mark Instance methods

- (void)setAttachTable:(MomentAttachTable *)attachTable
{
    _attachTable = attachTable;
    
    // 设置附件的图片
    [self setAttachImage];
}

- (void)setAttachImage
{
    UIImage *attachImage = [[MomentAttachManager shareInstance] getMomentImage:self.attachTable.attName isOrignal: YES];
    
    self.showImageView.image = attachImage;
}

- (void)saveImageToDevice:(UIImage *)image
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
    [actionSheet showInView: self];
}


// 保存图片
- (void)touchSaveButton
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
    [actionSheet showInView: self];
}

#pragma mark -
#pragma mark UIActionSheetDelegate methods

- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self saveImageToPhotos: _showImageView.image];
    }
}

#pragma mark -
#pragma mark NSNotification methods

- (void)updateAttachImageNotification:(NSNotification *)notification
{
    if (notification == nil || [notification object] == nil || [notification userInfo] == nil)
    {
        return;
    }
    
    int postType = [[notification object] intValue];
    switch (postType)
    {
        case MomentModuleNoticeTypeDownloadOrignalImage:
        {
            NSString *fileName = [notification userInfo][@"attName"];
            if ([fileName isEqualToString: self.attachTable.attName])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setAttachImage];
                });
            }
        }
            break;
            
        default:
            break;
    }
}

@end
