//
//  CellConfigureTests.m
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TableDataSource.h"
#import "TableViewController.h"

@interface CellConfigureTests : XCTestCase

@end

@implementation CellConfigureTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDataSourceInitializing {
    TableViewCellConfigureBlock cellConfigureBlock = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };
    
    TableDataSource *tableSource = [[TableDataSource alloc] initWithItems:@[@"1", @"2", @"3"]
                                                           CellIdentifier:@"TestCell"
                                                       ConfigureCellBlock:cellConfigureBlock];
    
    XCTAssertNotNil(tableSource, @"TableView data source should not be nil");
}

@end
