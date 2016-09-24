//
//  BuyListTableViewCell.h
//  ForemanAPP
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuildModel.h"

@interface BuyListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *ksdhf;
@property (strong, nonatomic) IBOutlet UILabel *xsdhtext;

@property (strong,nonatomic)BuildModel *model;

@property (strong, nonatomic) IBOutlet UILabel *xstttext;
@end
