//
//  FirstGHUnitTests.m
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-20.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "TableDataSource.h"
#import "TableViewController.h"

@interface MyTest : GHTestCase

@end

@implementation MyTest

- (void)testStrings {
    NSString *string1 = @"a string";
    GHTestLog(@"I can log to the GHUnit test console: %@", string1);
    
    // Assert string1 is not NULL, with no custom error description
    GHAssertNotNil(string1, nil);
    
    // Assert equal objects, add custom error description
    NSString *string2 = @"a string";
    GHAssertEqualObjects(string1, string2, @"A custom error message. string1 should be equal to: %@.", string2);
}

- (void)testSimpleFail {
    GHAssertTrue(NO, nil);
}

- (void)testDataSourceInitializing {
    TableViewCellConfigureBlock cellConfigureBlock = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };
    
    TableDataSource *tableSource = [[TableDataSource alloc] initWithItems:@[@"1", @"2", @"3"]
                                                           CellIdentifier:@"TestCell"
                                                       ConfigureCellBlock:cellConfigureBlock];
    
    GHAssertNotNil(tableSource, @"TableView data source should not be nil");
}

@end
