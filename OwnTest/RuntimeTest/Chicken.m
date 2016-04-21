//
//  Chicken.m
//  RuntimeTest
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "Chicken.h"
#import "Cat.h"

@implementation Chicken

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return false;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([NSStringFromSelector(aSelector) isEqualToString:@"jump"])
    {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:[Cat new]];
//    anInvocation.selector = @selector(fly);
//    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"%@", NSStringFromSelector(aSelector));
}

- (void)fly
{
    NSLog(@"%@ fly", self);
}

@end
