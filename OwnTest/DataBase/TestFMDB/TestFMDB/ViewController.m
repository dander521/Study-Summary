//
//  ViewController.m
//  TestFMDB
//
//  Created by 程荣刚 on 16/1/25.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@property (nonatomic, strong) FMDatabase *fmDatabase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fmDatabase = [self createFMDBDataBase];
}

#pragma mark - Create FMDB

- (FMDatabase *)createFMDBDataBase
{
    // 设置路径
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlte"];
    
    // 获得数据库
    FMDatabase *dataBase = [FMDatabase databaseWithPath:filePath];
    
    // 打开数据库
    if ([dataBase open])
    {
        // 创表
        BOOL isCreatSuccess = [dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (isCreatSuccess)
        {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
    }

    return dataBase;
}


#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self deleteDataFromFMDB];
    [self insertDataToFMDB];
    [self queryDataWithFMDB];
}

#pragma mark - Delete Data

- (void)deleteDataFromFMDB
{
    //    [self.fmDatabase executeUpdate:@"DELETE FROM t_student;"];
    [self.fmDatabase executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
    [self.fmDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
}

#pragma mark - Insert Data

- (void)insertDataToFMDB
{
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
        // executeUpdate : 不确定的参数用?来占位
        [self.fmDatabase executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
        //        [self.fmDatabase executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]];
        
        // executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
        //        [self.fmDatabase executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
    }
}


#pragma mark - Query Data

- (void)queryDataWithFMDB
{
    FMResultSet *fmResultSet = [self.fmDatabase executeQuery:@"SELECT * FROM t_student"];
    
    // 2.遍历结果
    while ([fmResultSet next]) {
         int ID = [fmResultSet intForColumn:@"id"];
         NSString *name = [fmResultSet stringForColumn:@"name"];
         int age = [fmResultSet intForColumn:@"age"];
         NSLog(@"ID = %d name = %@ age = %d", ID, name, age);
     }
}

@end
