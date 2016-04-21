//
//  AppDelegate.h
//  CoreData
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*
 CoreData: 面向对象 简单的App 表关系不复杂 适合
 FMDB: 复杂 表关联多
 
 CoreData 开发效率高  但是运行效率低，做了一次Sqlite语句的底层封装
 
 创建工程时，选择CoreData选项，xcode 会在AppDelegate中 生成CoreData对应的属性 并采用懒加载进行初始化
 */

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // CoreData数据库上下文 类似数据库单例
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; // CoreData数据模型 类似数据库表
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; // CoreData持久化存储调度器 把数据保存到一个文件

- (void)saveContext; // CoreData 执行保存
- (NSURL *)applicationDocumentsDirectory; // CoreData App内保存数据的路径

#pragma mark - Get AppDelegate

+ (AppDelegate *)appDelegate;



@end

