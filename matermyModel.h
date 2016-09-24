//
//  matermyModel.h
//  ForemanAPP
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface matermyModel : NSObject

@property (nonatomic,strong)NSString *clbm;//材料类型

@property (nonatomic,strong)NSString *clmc;//材料规格

@property (nonatomic,strong)NSString *xh;//材料单位

@property (nonatomic,strong)NSString *gg;//材料数量
@property (nonatomic,strong)NSString *jldwbm;//材料数量
@property (nonatomic,strong)NSString *clsl;//材料数量

@property (nonatomic,strong)NSString *clxlbm;//材料数量

@property (nonatomic,strong)NSString *clxlmc;//材料数量

@property (nonatomic,strong)NSString *xssl;

@property (nonatomic,strong)NSString *cbj;//材料单价

@property (nonatomic,strong)NSString *xsj;//材料单价

//clbm=FC00000000001
//clmc=大芯板E1级(鑫生）
//            xh=
//            gg=1220?440?8mm
//            jldwbm=张
//            xssl=999.0
//            cbj=133.0
//            xsj=145.0


@end
