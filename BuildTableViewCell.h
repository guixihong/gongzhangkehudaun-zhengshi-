//
//  BuildTableViewCell.h
//  ForemanAPP
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "BuildModel.h"

@interface BuildTableViewCell : UITableViewCell


@property (nonatomic,strong)BuildModel *model;
@property (strong, nonatomic) IBOutlet UILabel *cldhText;
@property (strong, nonatomic) IBOutlet UILabel *ckztText;

@property (strong, nonatomic) IBOutlet UILabel *cksjText;

@property (strong,nonatomic)NSString *jum;

@end
