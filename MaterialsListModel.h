//
//  MaterialsListModel.h
//  ForemanAPP
//
//  Created by mac on 16/5/23.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialsListModel : NSObject

@property (nonatomic,strong)NSString *uid;//uid

@property (nonatomic,strong)NSString *clmc;//材料名称

@property (nonatomic,strong)NSString *clxh;//材料类型

@property (nonatomic,strong)NSString *clgg;//材料规格

@property (nonatomic,strong)NSString *cldw;//材料单位

@property (nonatomic,strong)NSString *clsl;//材料数量
@property (nonatomic,strong)NSString *cldlbm;//材料数量
@property (nonatomic,strong)NSString *cldlmc;//材料数量
@end
