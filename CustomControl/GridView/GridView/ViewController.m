//
//  ViewController.m
//  GridViewTest
//
//  Created by 程荣刚 on 16/3/3.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "ViewController.h"
#import "GridView.h"
#import "ImageStatus.h"
#import "PhotoBrowserCollectionViewController.h"

static NSString * const reuseIdentifier = @"Cell";

@interface ViewController ()<GridViewDelegate>

@property (nonatomic, strong) GridView *gridView;
@property (nonatomic, strong) ImageStatus *imageStatus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.gridView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Init

- (GridView *)gridView {
	if(_gridView == nil) {
		_gridView = [[GridView alloc] init];
        _gridView.gridViewdelegate = self;
        _gridView.imageStatus = self.imageStatus;
	}
	return _gridView;
}

- (ImageStatus *)imageStatus {
	if(_imageStatus == nil) {
		_imageStatus = [[ImageStatus alloc] init];
        _imageStatus.imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg", @"7.jpg", @"8.jpg", @"9.jpg"];
	}
	return _imageStatus;
}

#pragma mark - GridViewDelegate

- (void)selectImageViewAtIndex:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    PhotoBrowserCollectionViewController *vwcPhotoBrowser = [[PhotoBrowserCollectionViewController alloc] initWithCollectionViewLayout:layout];
    vwcPhotoBrowser.indexPath = indexPath;
    vwcPhotoBrowser.imageStatus = self.imageStatus;
    [self presentViewController:vwcPhotoBrowser animated:YES completion:nil];
}

@end
