//
//  TableDataSource.h
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface TableDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)anItems
               CellIdentifier:(NSString *)aCellIdentifier
           ConfigureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
