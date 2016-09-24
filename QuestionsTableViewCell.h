//
//  QuestionsTableViewCell.h
//  ForemanAPP
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *clmc;//材料名称
@property (strong, nonatomic) IBOutlet UILabel *clxh;//材料型号
@property (strong, nonatomic) IBOutlet UILabel *clgg;//材料规格
@property (strong, nonatomic) IBOutlet UILabel *cldw;//材料单位

@end
