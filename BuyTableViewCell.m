//
//  BuyTableViewCell.m
//  ForemanAPP
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyTableViewCell.h"

@implementation BuyTableViewCell

-(void)setModel:(MaterialModel *)model
{

    _model = model;
//    self.khdz.text = [NSString stringWithFormat:@"客户编号: %@",];
    self.khxm.text = [NSString stringWithFormat:@"客户姓名: %@           ",_model.khxm];
    self.khbh.text = [NSString stringWithFormat:@"施工状态: %@",_model.sgzt];
    
    self.bjjb.text = [NSString stringWithFormat:@"报价级别: %@         ",_model.bjjbmc];
     self.fwdz.text = [NSString stringWithFormat:@"房屋地址: %@         ",_model.fwdz];
    
    self.fwdz.adjustsFontSizeToFitWidth = YES;
    
     self.tcmc.text = [NSString stringWithFormat:@"套餐名称: %@         ",_model.tcmc];
}


- (void)awakeFromNib {
    // Initialization code
}

//myview.layer.borderWidth = 1;//边框宽度
//myview.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
