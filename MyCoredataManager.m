//
//  CoredataManager.m
//  AXM_APP
//
//  Created by 任前辈 on 15/12/31.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "MyCoredataManager.h"
#import "MagicalRecord.h"
#import "MyForemLocal.h"
@implementation MyCoredataManager

+(void)insertModel:(matermyModel *)model{
    
    MyForemLocal * app = [MyForemLocal MR_createEntity];
    
    
    //    *clbm;//材料类型
    //    *clmc;//材料规格
    //    *xh;//材料单位
    //    *gg;//材料数量
    //    *jldwbm;//材料数量
    //    *clsl;//材料数量
    
    
    
    app.uid = model.clbm;
   
    app.clsl = model.clsl;
   
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库
    NSLog(@"555插入成功");
    
}

+(void)deleteModel:(matermyModel *)model{
    
    NSArray * array =  [MyForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    for (MyForemLocal * local in array) {
        
        [local MR_deleteEntity];//删除liudan
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库
    
    NSLog(@"555删除成功");
    
}

+(NSArray *)findAppALL{
    
    
    NSArray * models = [MyForemLocal MR_findAll];
    
    NSMutableArray * apps = [NSMutableArray array];
    
    for (MyForemLocal * model in models) {
        matermyModel * app = [[matermyModel alloc] init];
        app.clbm = model.uid;
        app.clsl = model.clsl;
       
        [apps addObject:app];
    }
    
    return apps;
    
}

+(BOOL)isfavourite:(matermyModel*)model{
    
    NSArray * array =  [MyForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    return array.count;
    
}


+(void)updataData:(matermyModel*)model
{
    
    NSArray *array = [MyForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    MyForemLocal *MMokde = array[0];
    MMokde.clsl = model.clsl;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库
    
    NSLog(@"555更新成功");
}

+(NSInteger)returnCount:(matermyModel*)model
{
    
    NSArray *array = [MyForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    return array.count;
}

+(NSString *)Getclsl:(matermyModel *)model{
    
   NSArray * array =  [MyForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
   MyForemLocal *MMokde = array[0];
   return MMokde.clsl;
}



@end
