//
//  MaterialsListTableViewCell.h
//  ForemanAPP
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "matermyModel.h"

@interface MaterialsListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *clmc;

@property (strong, nonatomic) IBOutlet UILabel *clxh;

@property (strong, nonatomic) IBOutlet UILabel *clgg;

@property (strong, nonatomic) IBOutlet UILabel *cldw;

@property (strong,nonatomic) matermyModel *model;

@property (strong, nonatomic) IBOutlet UIButton *add;//加号
@property (strong, nonatomic) IBOutlet UIButton *unadd;//减号
@property (strong, nonatomic) IBOutlet UITextField *quantitytextField;//数量
@property (strong, nonatomic) IBOutlet UILabel *cldj;


@end
