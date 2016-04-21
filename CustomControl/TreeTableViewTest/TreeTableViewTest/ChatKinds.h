//
//  ChatKinds.h
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatKinds : NSObject

@property (nonatomic, strong) NSString *cfname; // 会话类型
@property (nonatomic, strong) NSArray *sublist; // 会话类型分类
@property (nonatomic, assign) BOOL isSelected; // 是否选中

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)chatKindstWithDict:(NSDictionary *)dictionary;
+ (NSArray *)chatKindsWithArray:(NSArray *)array;

@end
