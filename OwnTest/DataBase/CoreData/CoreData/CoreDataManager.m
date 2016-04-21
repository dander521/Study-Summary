//
//  CoreDataManager.m
//  CoreData
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "Student+CoreDataProperties.h"
#import "School+CoreDataProperties.h"

#define CoreDataModelName       @"Student"
#define CoreDataModelSchool     @"School"

@interface CoreDataManager ()

@property (nonatomic, assign) AppDelegate *appDelegate;

@end

@implementation CoreDataManager

- (instancetype)init
{
    if (self = [super init])
    {
        self.appDelegate = [AppDelegate appDelegate];
    }
    return self;
}

/*!
 *  @author RogerChen, 16-03-01 09:03:35
 *
 *  数据库管理类单例
 *
 *  @return CoreDataManager
 */
+ (instancetype)shareInstance
{
    static CoreDataManager *shareInstance = nil;
    static dispatch_once_t coreData;
    dispatch_once(&coreData, ^{
        shareInstance = [[CoreDataManager alloc] init];
    });
    return shareInstance;
}

#pragma mark - Insert

- (void)insertStudentAndSchoolData
{
    // 创建两个学校
    School *oneSchool = [NSEntityDescription insertNewObjectForEntityForName:CoreDataModelSchool inManagedObjectContext:self.appDelegate.managedObjectContext];
    oneSchool.schoolName = @"清华";
    oneSchool.schoolAddress = @"北京";
    
    School *twoSchool = [NSEntityDescription insertNewObjectForEntityForName:CoreDataModelSchool inManagedObjectContext:self.appDelegate.managedObjectContext];
    twoSchool.schoolName = @"交大";
    twoSchool.schoolAddress = @"西安";
    
    Student *oneStudent = [NSEntityDescription insertNewObjectForEntityForName:CoreDataModelName inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    oneStudent.name = @"Roger";
    oneStudent.age = [self randomNumber];
    oneStudent.sex = @"man";
    oneStudent.school = oneSchool;
    
    Student *twoStudent = [NSEntityDescription insertNewObjectForEntityForName:CoreDataModelName inManagedObjectContext:self.appDelegate.managedObjectContext];
    
    twoStudent.name = @"HAHA";
    twoStudent.age = [self randomNumber];
    twoStudent.sex = @"man";
    twoStudent.school = twoSchool;
    
    // 直接保存数据库
    NSError *error = nil;
    [self.appDelegate.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
}

- (void)insertStudentToCoreData
{
    // 生成数据库模型 使用 insertNewObjectForEntityForName 方法 指定模型
    for (int i = 0; i < 15; i++)
    {
        Student *student = [NSEntityDescription insertNewObjectForEntityForName:CoreDataModelName inManagedObjectContext:self.appDelegate.managedObjectContext];
        
        student.name = @"Roger";
        student.age = [self randomNumber];
        student.sex = @"man";
        
        // 直接保存数据库
        NSError *error = nil;
        [self.appDelegate.managedObjectContext save:&error];
        
        if (error) {
            NSLog(@"%@",error);
        }
    }
}

#pragma mark - Delete

- (void)deleteStudentToCoreData
{
    // 1.查找Roger
    // 1.1FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelName];
    
    // 1.2设置过滤条件
    // 查找Roger
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
                        @"Roger"];
    request.predicate = pre;
    
    // 1.3执行请求
    NSArray *students = [self.appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    // 2.删除
    for (Student *student in students) {
        [self.appDelegate.managedObjectContext deleteObject:student];
    }
    
    // 3.保存
    [self.appDelegate.managedObjectContext save:nil];
}

#pragma mark - Update

- (void)updateStudentToCoreData
{
    // 1.查找到Roger
    // 1.1FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelName];
    
    // 1.2设置过滤条件
    // 查找Roger
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
                        @"Roger"];
    request.predicate = pre;
    
    // 1.3执行请求
    NSArray *students = [self.appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    
    // 2.更新age
    for (Student *student in students) {
        student.age = @200;
    }
    
    // 3.保存
    [self.appDelegate.managedObjectContext save:nil];
}

#pragma mark - Fetch

- (void)fetchStudentToCoreData
{
    // 1.FectchRequest 抓取请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelName];
    
    // 2.设置过滤条件
    // 查找姓名为 Roger
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name = %@",
                        @"Roger"];
    request.predicate = pre;
    
    // 3.设置排序
    // age的升序排序
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = @[ageSort];
    
    // 4.执行请求
    NSError *error = nil;
    
    NSArray *students = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error");
    }
    
    // 遍历学生
    for (Student *student in students)
    {
        NSLog(@"name = %@ age = %@ sex = %@ school = %@",student.name, student.age, student.sex, student.school);
    }

}

- (void)pagingFetchCoreData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelName];
    
    // 3.设置排序
    // 身高的升序排序
    NSSortDescriptor *heigtSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = @[heigtSort];
    
    // 总有共有15数据
    // 每次获取6条数据
    // 第一页 0,6
    // 第二页 6,6
    // 第三页 12,6 3条数据
    // 分页查询 limit 0,5
    
    // 分页的起始索引
    request.fetchOffset = 0;
    
    // 分页的条数
    request.fetchLimit = 5;
    
    // 4.执行请求
    NSError *error = nil;
    
    NSArray *students = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error");
    }
    
    //遍历员工
    for (Student *student in students) {
        NSLog(@"名字 %@ 身高 %@ 生日 %@",student.name,student.age,student.sex);
    }

}

- (void)fuzzyFetchCoreData
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelName];
    
    // 1: BEGINSWITH
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", @"Roger"];
    // 2: ENDSWITH
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name ENDSWITH %@", @"1"];
#pragma unused(predicate1)
    // 3: CONTAINS
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"name CONTAINS %@", @"1"];
#pragma unused(predicate2)
    // 4: like
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"name like %@", @"*er1"];
#pragma unused(predicate3)
    
    request.predicate = predicate;
    
    // 4.执行请求
    NSError *error = nil;
    
    NSArray *students = [self.appDelegate.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"error");
    }
    
    //NSLog(@"%@",emps);
    //遍历员工
    for (Student *student in students) {
        NSLog(@"名字 %@ 身高 %@ 生日 %@",student.name,student.age,student.sex);
    }
}

#pragma mark - Random Num

- (NSNumber *)randomNumber
{
    NSUInteger randomNum = arc4random()%100 + 1;
    return [NSNumber numberWithInteger:randomNum];
}


@end
