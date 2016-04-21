//
//  FMQueueManager.m
//  FMDB
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "FMQueueManager.h"

@implementation FMQueueManager

/*!
 *  @author RogerChen, 16-03-01 14:03:35
 *
 *  创建数据库
 *
 *  @param dataPath 数据库本地路径
 *
 *  @return 返回数据库对象
 */
+ (instancetype)shareInstanceQueueWithPath:(NSString *)dataPath
{
    static FMQueueManager *queueManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queueManager = [FMQueueManager databaseQueueWithPath:dataPath];
    });
    return queueManager;
}

@end
