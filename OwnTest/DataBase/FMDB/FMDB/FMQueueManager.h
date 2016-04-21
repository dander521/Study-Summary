//
//  FMQueueManager.h
//  FMDB
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "FMDatabaseQueue.h"

@interface FMQueueManager : FMDatabaseQueue

#pragma mark - Multi Threads

/*!
 *  @author RogerChen, 16-03-01 14:03:35
 *
 *  创建数据库
 *
 *  @param dataPath 数据库本地路径
 *
 *  @return 返回数据库对象
 */
+ (instancetype)shareInstanceQueueWithPath:(NSString *)dataPath;



@end
