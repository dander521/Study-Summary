//
//  SublistKinds.m
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "SublistKinds.h"

@implementation SublistKinds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

+ (instancetype)sublistKindsWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

+ (NSArray *)sublistKindsWithArray:(NSArray *)array
{
    NSMutableArray *arraySublistKinds = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arraySublistKinds addObject:[self sublistKindsWithDictionary:dict]];
    }
    return arraySublistKinds;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"<%@:%p> {scfid:%@ scfname:%@}--",self.class,self,self.scfid,self.scfname];
}

@end
