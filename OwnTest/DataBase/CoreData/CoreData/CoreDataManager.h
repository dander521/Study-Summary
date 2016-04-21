//
//  CoreDataManager.h
//  CoreData
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

/*!
 *  @author RogerChen, 16-03-01 09:03:35
 *
 *  数据库管理类单例
 *
 *  @return CoreDataManager
 */
+ (instancetype)shareInstance;

#pragma mark - Insert

- (void)insertStudentAndSchoolData;

- (void)insertStudentToCoreData;

#pragma mark - Delete

- (void)deleteStudentToCoreData;

#pragma mark - Update

- (void)updateStudentToCoreData;

#pragma mark - Fetch

- (void)fetchStudentToCoreData;

- (void)pagingFetchCoreData;

- (void)fuzzyFetchCoreData;
@end
