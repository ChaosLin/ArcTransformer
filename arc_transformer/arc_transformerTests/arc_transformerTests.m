//
//  arc_transformerTests.m
//  arc_transformerTests
//
//  Created by RentonTheUncoped on 15/1/16.
//  Copyright (c) 2015年 Uncoped Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "RTRegularExpression.h"

@interface arc_transformerTests : XCTestCase

@end

@implementation arc_transformerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testRegularExpresssion{
//    NSString* str_test = @"1234";
//    XCTAssert([RTRegularExpression replaceString:str_test withPattern:@"\\W"]);
    [RTRegularExpression test];
}
@end
