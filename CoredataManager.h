//
//  CoredataManager.h
//  AXM_APP
//
//  Created by 任前辈 on 15/12/31.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "matermyModel.h"
@interface CoredataManager : NSObject

+(BOOL)isfavourite:(matermyModel*)model;

+(void)insertModel:(matermyModel *)model;

+(void)deleteModel:(matermyModel *)model;

+(NSArray *)findAppALL;

+(void)updataData:(matermyModel*)model;

+(NSInteger)returnCount:(matermyModel*)model;
@end
