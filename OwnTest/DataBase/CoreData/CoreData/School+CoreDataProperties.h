//
//  School+CoreDataProperties.h
//  CoreData
//
//  Created by 程荣刚 on 16/3/1.
//  Copyright © 2016年 rongkecloud. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "School.h"

NS_ASSUME_NONNULL_BEGIN

@interface School (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *schoolName;
@property (nullable, nonatomic, retain) NSString *schoolAddress;

@end

NS_ASSUME_NONNULL_END
