//
//  MockTableTests.m
//  UnitTestDemo
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "TableDataSource.h"
#import "TableViewController.h"

@interface MockTableTests : XCTestCase

@end

@implementation MockTableTests

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

- (void)testNumberOfRows {
    // 1.创建Table View的DataSource
    TableViewCellConfigureBlock cellConfigureBlock = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };
    
    TableDataSource *tableSource = [[TableDataSource alloc] initWithItems:@[@"1", @"2", @"3"]
                                                           CellIdentifier:@"foo"
                                                       ConfigureCellBlock:cellConfigureBlock];
    
    // 2.创建mock table view
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    
    // 3.断言
    XCTAssertEqual([tableSource tableView:mockTableView numberOfRowsInSection:0], (NSInteger)3, @"Mock table returns a bad number of rows in section 0");
}

- (void)testCellConfiguration {
    // 1.创建Table data source
    __block UITableViewCell *configuredCell = nil;
    __block id configuredObject = nil;
    TableViewCellConfigureBlock block = ^(UITableViewCell *a, id b) {
        configuredCell   = a;
        configuredObject = b;
    };
    TableDataSource *dataSource = [[TableDataSource alloc] initWithItems:@[@"a", @"b"]
                                                          CellIdentifier:@"foo"
                                                      ConfigureCellBlock:block];
    
    // 2.创建mock table view
    id mockTableView = [OCMockObject mockForClass:[UITableView class]];
    
    // 3.设定mock table view的行为
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [[[mockTableView expect] andReturn:cell] dequeueReusableCellWithIdentifier:@"foo" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [[[mockTableView stub] andReturn:cell] dequeueReusableCellWithIdentifier:@"foo" forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // 4.主动调用cellForRowAtIndexPath方法
    id result = [dataSource tableView:mockTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    // 5.验证mock table view的行为
    [mockTableView verify];
    
    // 6.断言
    XCTAssertEqual(result, cell, @"Should return the dummy cell.");
    XCTAssertEqual(configuredCell, cell, @"This should have been passed to the block.");
    XCTAssertEqualObjects(configuredObject, @"a", @"This should have been passed to the block.");
}

- (void)testXCTEqual {
//    NSString *str1 = @"a";
//    NSString *str2 = @"a";
//    NSString *str3 = @"b";
//    
//    XCTAssertEqual(str1, str3, @"str1 is not equal to str2");
    
    NSArray *arr1 = @[@"1"];
    NSArray *arr2 = @[@"1"];
    
//    XCTAssertEqual(arr1, arr2, @"arr1 is not equal to arr2");
    XCTAssertEqualObjects(arr1, arr2, @"![arr1 isEqual:arr2]");
}

@end
