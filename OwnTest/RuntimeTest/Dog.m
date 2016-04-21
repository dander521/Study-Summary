//
//  Dog.m
//  RuntimeTest
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "Dog.h"
#import "Cat.h"

@implementation Dog

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return false;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"jump"])
    {
        return [Cat new];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

@end
