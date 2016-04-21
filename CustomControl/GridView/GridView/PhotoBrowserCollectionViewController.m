//
//  PhotoBrowserCollectionViewController.m
//  PhotoBrowserTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "PhotoBrowserCollectionViewController.h"
#import "PhotoBrowserCollectionViewCell.h"
#import "MBProgressHUD+MJ.h"

@interface PhotoBrowserCollectionViewController ()<PhotoBrowserCollectionViewCellDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIImage *saveImage;
@property (nonatomic, strong) UIActionSheet *action;

@end

@implementation PhotoBrowserCollectionViewController

static NSString * const reuseIdentifier = @"PhotoBrowserCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[PhotoBrowserCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 1.设置layout
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) ;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.collectionViewLayout = flowLayout;
    
    // 2.设置collectionView
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.pagingEnabled = true;
    self.collectionView.bounces = false;

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageStatus.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.photoImage = [UIImage imageNamed:[self.imageStatus.imageArray objectAtIndex:indexPath.item]];
    
    return cell;
}

#pragma mark - PhotoBrowserCollectionViewCellDelegate

- (void)tapImageView
{
    NSLog(@"tap");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)longPressImageView
{
    NSLog(@"long");
    NSIndexPath *indexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    PhotoBrowserCollectionViewCell *cell = (PhotoBrowserCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    self.saveImage = cell.photoImage;
    
    [self.action showInView:self.view];
}

#pragma mark - Lazy Init

- (UIActionSheet *)action {
	if(_action == nil) {
        _action = [[UIActionSheet alloc] initWithTitle:@"保存图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
	}
	return _action;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        return;
    }
    
    [MBProgressHUD showMessage:@"请稍后..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImageWriteToSavedPhotosAlbum(self.saveImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [MBProgressHUD hideHUD];
    
    if (error)
    {
        [MBProgressHUD showMessage:@"保存失败"];
    }
    else
    {
        [MBProgressHUD showMessage:@"保存成功"];
    }
    
    [MBProgressHUD hideHUD];
}

@end
