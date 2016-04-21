//
//  ViewController.m
//  CoreData
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"

@interface ViewController ()

@property (nonatomic, strong) CoreDataManager *coreDataManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Operate CoreData
- (IBAction)insertStuAndSchool:(id)sender {
    [self.coreDataManager insertStudentAndSchoolData];
}

- (IBAction)insertStudent:(id)sender {
    [self.coreDataManager insertStudentToCoreData];
}

- (IBAction)deleteStudent:(id)sender {
    [self.coreDataManager deleteStudentToCoreData];
}

- (IBAction)updateStudent:(id)sender {
    [self.coreDataManager updateStudentToCoreData];
}

- (IBAction)fetchStudent:(id)sender {
    [self.coreDataManager fetchStudentToCoreData];
}

- (IBAction)pagingFetch:(id)sender {
    [self.coreDataManager pagingFetchCoreData];
}

- (IBAction)fuzzyFetch:(id)sender {
    [self.coreDataManager fuzzyFetchCoreData];
}


#pragma mark - Lazy Init

- (CoreDataManager *)coreDataManager {
    if(_coreDataManager == nil) {
        _coreDataManager = [CoreDataManager shareInstance];
    }
    return _coreDataManager;
}

@end
