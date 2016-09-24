//
//  DetailViewController.h
//  ForemanAPP
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BuildModel.h"

@interface DetailViewController : UIViewController


@property (nonatomic,strong)BuildModel *myModel;//材料细明

@property (nonatomic,strong)NSString *userName;



@property (nonatomic,strong)NSString *khdz;//客户编号

@property (nonatomic,strong)NSString *khbh;//客户编号

@end
