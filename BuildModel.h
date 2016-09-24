//
//  BuildModel.h
//  ForemanAPP
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildModel : NSObject

@property (nonatomic,strong)NSString *cldh;//材料单号

@property (nonatomic,strong)NSString *shzt;//审核状态

@property (nonatomic,strong)NSString *lrsj;//录入时间

@property (nonatomic,strong)NSString *clmx;//材料细明


@property (nonatomic,strong)NSString *clbm;//材料细明

@property (nonatomic,strong)NSString *clmc;//材料细明

@property (nonatomic,strong)NSString *xh;//材料细明

@property (nonatomic,strong)NSString *gg;//材料细明

@property (nonatomic,strong)NSString *jldwbm;//材料细明

@property (nonatomic,strong)NSString *pssl;//材料细明







//xsph=FX011500012
//xszsl=20.0
//xszje=12.0
//xsdzt=等待审核
//lrsj=2015-11-1200:00

@property (nonatomic,strong)NSString *xsph;//材料细明

@property (nonatomic,strong)NSString *xszsl;//材料细明

@property (nonatomic,strong)NSString *xszje;//材料细明

@property (nonatomic,strong)NSString *xsdzt;//材料细明

@property (nonatomic,strong)NSString *xsdztSJ;//材料细明
@end
