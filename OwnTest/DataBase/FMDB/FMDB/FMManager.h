//
//  FMManager.h
//  FMDB
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "FMDB.h"

@interface FMManager : FMDatabase

#pragma mark - Single Thread

/*!
 *  @author RogerChen, 16-03-01 14:03:35
 *
 *  创建数据库
 *
 *  @param dataPath 数据库本地路径
 *
 *  @return 返回数据库对象
 */
+ (instancetype)shareInstanceWithPath:(NSString *)dataPath;

/*!
 *  @author RogerChen, 16-03-01 14:03:09
 *
 *  打开数据库 根据sql语句建表
 *
 *  @param fmManager db单例对象
 *  @param creatTableSql 建表语句
 */
+ (BOOL)openDatabase:(FMManager *)fmManager
       creatTableSql:(NSString *)creatTableSql;

/*!
 *  @author RogerChen, 16-03-01 14:03:06
 *
 *  插入数据
 *
 *  @param fmManager     db单例对象
 *  @param insertDataSql 插入sql
 */
+ (void)insertDataWithDatabase:(FMManager *)fmManager
                 insertDataSql:(NSString *)insertDataSql;

/*!
 *  @author RogerChen, 16-03-01 14:03:55
 *
 *  更新数据
 *
 *  @param fmManager     db单例对象
 *  @param updateDataSql 更新sql
 */
+ (void)updateDataWithDatabase:(FMManager *)fmManager
                 updateDataSql:(NSString *)updateDataSql;


/*!
 *  @author RogerChen, 16-03-01 14:03:56
 *
 *  删除数据
 *
 *  @param fmManager     db单例对象
 *  @param deleteDataSql 删除sql
 */
+ (void)deleteDataWithDatabase:(FMManager *)fmManager
                 deleteDataSql:(NSString *)deleteDataSql;

/*!
 *  @author RogerChen, 16-03-01 14:03:27
 *
 *  查询数据
 *
 *  @param fmManager    db单例对象
 *  @param queryDataSql 查询sql
 */
+ (FMResultSet *)queryDataWithDatabase:(FMManager *)fmManager
                          queryDataSql:(NSString *)queryDataSql;

@end
