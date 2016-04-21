//
//  ViewController.m
//  FMDB
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

/***************************************************************************
 *
 *
 *
 *
 *
 *
 *
 *
 ******************************************************************************/

/****************************************************************************
 
 *  1.创建表：
        @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"
 
 *  2.插入数据：
 *  2.1 
        @"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))
 *  2.2 
        @"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]
 *  2.3 
        @"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)
 
 
 *  3.删除数据：
 *  3.1 
        @"DELETE FROM t_student where ...;"
 *  3.2 
        @"DROP TABLE IF EXISTS t_student;"
 *  3.3 
        @"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"
 
    4.查询数据
 *      @"SELECT * FROM t_student"
 *
 ******************************************************************************/

#import "ViewController.h"
#import "FMManager.h"

@interface ViewController ()

@property (nonatomic, strong) FMManager *localFMmanager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - create、drop、insert、update、delete

- (IBAction)insertData:(id)sender {
    for (int i = 0; i<10; i++) {
        NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
        // executeUpdate : 不确定的参数用?来占位
        [self.localFMmanager executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
    }
}

- (IBAction)updateData:(id)sender {
    
}

- (IBAction)deleteData:(id)sender {
    
}

#pragma mark - Lazy Init

- (FMDatabase *)database {
	if(_localFMmanager == nil) {
        // 设置路径
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlite"];
        
        FMManager *fmManager = [FMManager shareInstanceWithPath:filePath];
        BOOL isSuccess = [FMManager openDatabase:fmManager creatTableSql:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        
        if (isSuccess) _localFMmanager = fmManager;
	}
	return _localFMmanager;
}

@end
