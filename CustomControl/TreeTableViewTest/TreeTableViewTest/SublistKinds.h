//
//  SublistKinds.h
//  TreeTableViewTest
//
//  Created by 程荣刚 on 16/3/2.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SublistKinds : NSObject

@property (nonatomic, strong) NSString *scfid; // 服务器对应code
@property (nonatomic, strong) NSString *scfname; // 服务器对应的类型
@property (nonatomic, assign) BOOL isSubSelected; // 是否选中

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
+ (instancetype)sublistKindsWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)sublistKindsWithArray:(NSArray *)array;

@end
