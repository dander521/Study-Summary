//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by Jymn_Chen on 14-3-19.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UnitTestDemoTests : XCTestCase

@end

@implementation UnitTestDemoTests

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

/* 自带的testExample方法 */

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}


/* 探讨测试方法的调用顺序 */

//- (void)testTrue2 {
//    NSLog(@"2222222222222222222222");
//    XCTAssert(1, @"Can not be zero");
//}
//
//- (void)testTrue1 {
//    NSLog(@"1111111111111111111111");
//    XCTAssert(1, @"Can not be zero");
//}
//
//- (void)testTrue3 {
//    NSLog(@"3333333333333333333333");
//    XCTAssert(1, @"Can not be zero");
//}
//
//- (void)testAtrue {
//    NSLog(@"0000000000000000000000");
//    XCTAssert(1, @"Can not be zero");
//}


/* 测试各个断言 */

- (void)testAssert {
    
    // XCTFail(format…) 生成一个失败的测试；
//    XCTFail(@"Fail");
    
    
    // XCTAssertNil(a1, format...) 为空判断， a1 为空时通过，反之不通过；
//    XCTAssertNil(@"not nil string", @"string must be nil");
    
    
    // XCTAssertNotNil(a1, format…) 不为空判断，a1不为空时通过，反之不通过；
//    XCTAssertNotNil(@"not nil string", @"string can not be nil");
    
    
    // XCTAssert(expression, format...) 当expression求值为TRUE时通过；
//    XCTAssert((2 > 2), @"expression must be true");
    
    
    // XCTAssertTrue(expression, format...) 当expression求值为TRUE时通过；
//    XCTAssertTrue(1, @"Can not be zero");
    
    
    // XCTAssertFalse(expression, format...) 当expression求值为False时通过；
//    XCTAssertFalse((2 < 2), @"expression must be false");
    
    
    // XCTAssertEqualObjects(a1, a2, format...) 判断相等， [a1 isEqual:a2] 值为TRUE时通过，其中一个不为空时，不通过；
//    XCTAssertEqualObjects(@"1", @"1", @"[a1 isEqual:a2] should return YES");
//    XCTAssertEqualObjects(@"1", @"2", @"[a1 isEqual:a2] should return YES");
    
    
    // XCTAssertNotEqualObjects(a1, a2, format...) 判断不等， [a1 isEqual:a2] 值为False时通过，
//    XCTAssertNotEqualObjects(@"1", @"1", @"[a1 isEqual:a2] should return NO");
//    XCTAssertNotEqualObjects(@"1", @"2", @"[a1 isEqual:a2] should return NO");

    
    // XCTAssertEqual(a1, a2, format...) 判断相等（当a1和a2是 C语言标量、结构体或联合体时使用,实际测试发现NSString也可以）；
    // 1.比较基本数据类型变量
//    XCTAssertEqual(1, 2, @"a1 = a2 shoud be true"); // 无法通过测试
//    XCTAssertEqual(1, 1, @"a1 = a2 shoud be true"); // 通过测试
    
    // 2.比较NSString对象
//    NSString *str1 = @"1";
//    NSString *str2 = @"1";
//    NSString *str3 = str1;
//    XCTAssertEqual(str1, str2, @"a1 and a2 should point to the same object"); // 通过测试
//    XCTAssertEqual(str1, str3, @"a1 and a2 should point to the same object"); // 通过测试
    
    // 3.比较NSArray对象
//    NSArray *array1 = @[@1];
//    NSArray *array2 = @[@1];
//    NSArray *array3 = array1;
//    XCTAssertEqual(array1, array2, @"a1 and a2 should point to the same object"); // 无法通过测试
//    XCTAssertEqual(array1, array3, @"a1 and a2 should point to the same object"); // 通过测试
    
    
    // XCTAssertNotEqual(a1, a2, format...) 判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
    
    
    // XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...) 判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/- accuracy ）以内相等时通过测试；
//    XCTAssertEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return YES");
    
    
    // XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
//    XCTAssertNotEqualWithAccuracy(1.0f, 1.5f, 0.25f, @"a1 = a2 in accuracy should return NO");
    
    
    // XCTAssertThrows(expression, format...) 异常测试，当expression发生异常时通过；反之不通过；（很变态）
    
    
    // XCTAssertThrowsSpecific(expression, specificException, format...) 异常测试，当expression发生 specificException 异常时通过；反之发生其他异常或不发生异常均不通过；
    
    // XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...) 异常测试，当expression发生具体异常、具体异常名称的异常时通过测试，反之不通过；

    
    // XCTAssertNoThrow(expression, format…) 异常测试，当expression没有发生异常时通过测试；
    
    
    // XCTAssertNoThrowSpecific(expression, specificException, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过；

    
    // XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...) 异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过
}

@end
