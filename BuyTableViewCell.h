//
//  BuyTableViewCell.h
//  ForemanAPP
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MaterialModel.h"

@interface BuyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *seeDetailbtn;
@property (strong, nonatomic) IBOutlet UIButton *buybtn;
@property (weak, nonatomic) IBOutlet UILabel *khxm;
@property (weak, nonatomic) IBOutlet UILabel *khbh;
@property (weak, nonatomic) IBOutlet UILabel *bjjb;

@property (weak, nonatomic) IBOutlet UILabel *fwdz;

@property (weak, nonatomic) IBOutlet UILabel *tcmc;
@property (strong,nonatomic)MaterialModel *model;

@end
