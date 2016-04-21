//
//  Cat.m
//  RuntimeTest
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "Cat.h"
#import <objc/runtime.h>

void jump (id self, SEL cmd);

@implementation Cat

/*
 动态方法解析:
 首先，当接受到未能识别的选择子时，运行时系统会调用该函数用以给对象一次机会来添加相应的方法实现，如果用户在该函数中动态添加了相应方法的实现，则跳转到方法的实现部分，并将该实现存入缓存中，以供下次调用
 
 函数实现（IMP）
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if ([NSStringFromSelector(sel) isEqualToString:@"jump"])
    {
        // 用以向该类的实例对象中添加相应的方法实现
        class_addMethod(self, sel, (IMP)jump, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

void jump (id self, SEL cmd)
{
    NSLog(@"%@ jump", self);
}

@end
