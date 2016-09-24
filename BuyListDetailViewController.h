//
//  BuyListDetailViewController.h
//  ForemanAPP
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuildModel.h"

@interface BuyListDetailViewController : UIViewController


@property (nonatomic,strong)BuildModel *model;

@property (nonatomic,strong)NSString *userName;

@property (nonatomic,strong)NSString *khdz;
@end
