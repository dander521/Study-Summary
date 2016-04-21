//
//  MainViewController.m
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "MainViewController.h"
#import "TreeTableViewViewController.h"

@interface MainViewController ()<TreeTableViewViewControllerDelegate>

@property (nonatomic, strong) TreeTableViewViewController *treeTableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.treeTableView = [[TreeTableViewViewController alloc] init];
    
    self.treeTableView.delegate = self;
    [self addChildViewController:self.treeTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Touch Method

- (IBAction)touchShowKeyboardButton:(id)sender
{
    if (![[self.view subviews] containsObject:self.treeTableView.view])
    {
        [self.view addSubview:self.treeTableView.view];
        self.treeTableView.view.frame = CGRectMake(0, 264, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        self.treeTableView.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

#pragma mark - TreeTableViewViewControllerDelegate

- (void)touchSubmitButton
{
    [UIView animateWithDuration:1.0 animations:^{
        self.treeTableView.view.frame = CGRectMake(0, 264, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)touchCancelButton
{
    [UIView animateWithDuration:1.0 animations:^{
        self.treeTableView.view.frame = CGRectMake(0, 264, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)selectSubFlag:(NSString *)subFlagId
{
    NSLog(@"subFlagId = %@", subFlagId);
}

@end
