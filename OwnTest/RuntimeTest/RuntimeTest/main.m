//
//  main.m
//  RuntimeTest
//
//  Created by 程荣刚 on 16/4/11.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
#import "Dog.h"
#import "Chicken.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        [[Cat new] jump];
        
        [[Dog new] jump];
        
        [[Chicken new] jump];
        
    }
    return 0;
}
