//
//  ViewController.m
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "TreeTableViewViewController.h"
#import "ChatKinds.h"
#import "SublistKinds.h"
#import "TableViewHeaderView.h"
#import "SublistTableViewCell.h"

@interface TreeTableViewViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewHeaderViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UITableView *treeTableView;

@end

@implementation TreeTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.treeTableView = [self getTableView];
    [self.view addSubview:[self getToolBar]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((ChatKinds *)self.dataArray[section]).sublist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SublistTableViewCell *cell = (SublistTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SublistTableViewCell class]) owner:nil options:nil] lastObject];
    }

    ChatKinds *chatkinds = self.dataArray[indexPath.section];
    NSArray *arraySublist = chatkinds.sublist;
    
    if (chatkinds.isSelected)
    {
        SublistKinds *subkinds = arraySublist[indexPath.row];
        cell.defaultImageView.image = [UIImage imageNamed:@"a"];
        cell.subNameLabel.text = subkinds.scfname;
        cell.selectedImageView.image = subkinds.isSubSelected ? [UIImage imageNamed:@"c1"] : [UIImage imageNamed:@"c2"];
    } else {
        cell.defaultImageView = nil;
        cell.subNameLabel.text = @"";
        cell.selectedImageView.image = nil;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatKinds *chatkinds = self.dataArray[indexPath.section];
    
    return chatkinds.isSelected ? 44.0 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChatKinds *chatkinds = self.dataArray[section];
    
    TableViewHeaderView *viewHeader = [[TableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    viewHeader.delegate = self;
    viewHeader.selectSection = section;
    viewHeader.imageView.image = chatkinds.isSelected ? [UIImage imageNamed:@"b1"]
    : [UIImage imageNamed:@"b2"];
    viewHeader.titleLable.text = chatkinds.cfname;
    
    return viewHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (ChatKinds *chatkinds in _dataArray)
    {
        NSArray *arraySublist = chatkinds.sublist;
        for (SublistKinds *subkinds in arraySublist)
        {
            subkinds.isSubSelected = NO;
        }
    }
    
    ChatKinds *chatkinds = self.dataArray[indexPath.section];
    NSArray *arraySublist = chatkinds.sublist;
    SublistKinds *subkinds = arraySublist[indexPath.row];
    
    subkinds.isSubSelected = !subkinds.isSubSelected;
    
    [self.treeTableView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(selectSubFlag:)])
    {
        [self.delegate selectSubFlag:subkinds.scfid];
    }
}

#pragma mark - Lazy Init

- (NSArray *)dataArray {
	if(_dataArray == nil) {
		_dataArray = [[NSArray alloc] init];
        NSString *arrayPath = [[[NSBundle mainBundle] pathForResource:@"chatkinds" ofType:@"plist"] stringByDeletingLastPathComponent];
        NSArray *arrayTemp = [[NSArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", arrayPath, @"chatkinds.plist"]];
        _dataArray = [ChatKinds chatKindsWithArray:arrayTemp];
	}
	return _dataArray;
}

#pragma mark - TableViewSectionHeaderViewDelegate

- (void)tapTableViewHeaderView:(NSUInteger)section
{
    ChatKinds *chatkinds = _dataArray[section];
    chatkinds.isSelected = !chatkinds.isSelected;

    [self.treeTableView reloadData];
}

- (void)submitAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(touchSubmitButton)])
    {
        [self.delegate touchSubmitButton];
    }
}

- (void)cancelAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(touchCancelButton)])
    {
        [self.delegate touchCancelButton];
    }
}

#pragma mark - TableView

- (UITableView *)getTableView
{
    UITableView *treeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 220.0, [UIScreen mainScreen].bounds.size.width, 220.0) style:UITableViewStyleGrouped];
    treeTableView.delegate = self;
    treeTableView.dataSource = self;
    [self.view addSubview:treeTableView];
    
    return treeTableView;
}

#pragma mark - TableViewHeaderView

- (UIToolbar *)getToolBar
{
    UIToolbar *_toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 264.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
    _toolBar.backgroundColor = [UIColor blueColor];
    UIBarButtonItem *btnPlace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnItemCancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    
    UILabel *labelMid = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 12, 80, 20)];
    labelMid.text = @"标记会话";
    labelMid.textAlignment = NSTextAlignmentCenter;
    UIBarButtonItem *labelItem = [[UIBarButtonItem alloc] initWithCustomView:labelMid];
    
    UIBarButtonItem *btnItemSubmit = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submitAction:)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:btnItemCancel,btnPlace,labelItem,btnPlace,btnItemSubmit, nil];
    _toolBar.items = itemsArray;
    
    return _toolBar;
}

@end
