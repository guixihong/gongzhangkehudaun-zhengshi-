//
//  MyForemLocal+CoreDataProperties.h
//  ForemanAPP
//
//  Created by mac on 16/6/28.
//  Copyright © 2016年 YF. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "MyForemLocal.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyForemLocal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *clsl;
@property (nullable, nonatomic, retain) NSString *uid;

@end

NS_ASSUME_NONNULL_END
