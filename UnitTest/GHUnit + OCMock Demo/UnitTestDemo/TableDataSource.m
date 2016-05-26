//
//  TableDataSource.m
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "TableDataSource.h"

@interface TableDataSource ()

@property (nonatomic, strong) NSArray  *items;

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation TableDataSource
@synthesize items = _items;
@synthesize cellIdentifier = _cellIdentifier;
@synthesize configureCellBlock = _configureCellBlock;

#pragma mark - Initialization

- (id)init {
    return nil;
}

- (instancetype)initWithItems:(NSArray *)anItems
               CellIdentifier:(NSString *)aCellIdentifier
           ConfigureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    
    if (self) {
        self.items              = anItems;
        self.cellIdentifier     = aCellIdentifier;
        self.configureCellBlock = [aConfigureCellBlock copy];
    }
    
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return _items[(NSUInteger)indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end
