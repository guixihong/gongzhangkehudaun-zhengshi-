//
//  CoredataManager.m
//  AXM_APP
//
//  Created by 任前辈 on 15/12/31.
//  Copyright © 2015年 SingleProgrammers. All rights reserved.
//

#import "CoredataManager.h"
#import "MagicalRecord.h"
#import "ForemLocal.h"
@implementation CoredataManager

+(void)insertModel:(matermyModel *)model{
    
   ForemLocal * app = [ForemLocal MR_createEntity];
    
    
//    *clbm;//材料类型
//    *clmc;//材料规格
//    *xh;//材料单位
//    *gg;//材料数量
//    *jldwbm;//材料数量
//    *clsl;//材料数量
    
    
    
    app.uid = model.clbm;
    app.clmc = model.clmc;
    app.clxh = model.xh;
    app.clgg = model.gg;
    app.cldw = model.jldwbm;
    app.clsl = model.clsl;
    app.xsj = model.xsj;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库
    NSLog(@"插入成功");
    
}

+(void)deleteModel:(matermyModel *)model{
    
  NSArray * array =  [ForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    for (ForemLocal * local in array) {
        
        [local MR_deleteEntity];//删除liudan
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库

    NSLog(@"删除成功");
    
}

+(NSArray *)findAppALL{
   
    
    NSArray * models = [ForemLocal MR_findAll];
    
    NSMutableArray * apps = [NSMutableArray array];
    
    for (ForemLocal * model in models) {
        matermyModel * app = [[matermyModel alloc] init];
        app.clbm = model.uid;
        app.clmc = model.clmc;
        app.xh = model.clxh;
        app.gg = model.clgg;
        app.jldwbm = model.cldw;
        app.clsl = model.clsl;
        app.xsj = model.xsj;
        [apps addObject:app];
    }
    
    return apps;
    
}

+(BOOL)isfavourite:(matermyModel*)model{
    
     NSArray * array =  [ForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    return array.count;
    
}


+(void)updataData:(matermyModel*)model
{
    
    NSArray *array = [ForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    ForemLocal *MMokde = array[0];
    MMokde.clsl = model.clsl;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];//同步到数据库
    
    NSLog(@"更新成功");
}

+(NSInteger)returnCount:(matermyModel*)model
{

     NSArray *array = [ForemLocal MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"uid = %@",model.clbm]];
    
    return array.count;
}

@end
