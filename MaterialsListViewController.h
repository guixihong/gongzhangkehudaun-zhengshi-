//
//  MaterialsListViewController.h
//  ForemanAPP
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BaseViewController.h"

#import "MaterialModel.h"

@interface MaterialsListViewController : BaseViewController


@property (nonatomic,strong)NSString *userName;


@property (nonatomic,strong)NSString *panduan;//判断


@property (nonatomic,strong)NSString *khdz;//判断

@property (nonatomic,strong)MaterialModel *model;
@end
