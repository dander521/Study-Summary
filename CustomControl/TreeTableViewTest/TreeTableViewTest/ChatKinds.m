//
//  ChatKinds.m
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "ChatKinds.h"
#import "SublistKinds.h"

@implementation ChatKinds

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [self setValue:dictionary[@"cfname"] forKey:@"cfname"];
        self.sublist = [SublistKinds sublistKindsWithArray:dictionary[@"sublist"]];
    }
    return self;
}

+ (instancetype)chatKindstWithDict:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

+ (NSArray *)chatKindsWithArray:(NSArray *)array
{
    NSMutableArray *arrayChatKinds = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayChatKinds addObject:[self chatKindstWithDict:dict]];
    }
    return arrayChatKinds;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

int i = 0;
- (NSString *)description
{
    return [NSString stringWithFormat: @"<%@:%p> {cfname:%@,sublist:%@}---%d",self.class,self,self.cfname,self.sublist,i++];
}


@end
