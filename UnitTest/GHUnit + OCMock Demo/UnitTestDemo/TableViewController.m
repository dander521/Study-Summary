//
//  TableViewController.m
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "TableViewController.h"
#import "TableDataSource.h"

static NSString * const kCellIdentifier = @"Cell";

@interface TableViewController ()

@property (strong, nonatomic) TableDataSource *dataSource;

@end

@implementation TableViewController
@synthesize dataSource = _dataSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TableViewCellConfigureBlock cellConfigureBlock = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };
    
    NSArray *stringsArray = @[@"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3", @"1", @"2", @"3"];
    self.dataSource = [[TableDataSource alloc] initWithItems:stringsArray
                                              CellIdentifier:kCellIdentifier
                                          ConfigureCellBlock:cellConfigureBlock];
    
    self.tableView.dataSource = _dataSource;
}

@end
