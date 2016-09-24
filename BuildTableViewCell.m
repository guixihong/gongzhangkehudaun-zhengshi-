//
//  BuildTableViewCell.m
//  ForemanAPP
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuildTableViewCell.h"

@implementation BuildTableViewCell

-(void)setModel:(BuildModel *)model
{

        _model = model;
        _cldhText.text = [NSString stringWithFormat:@"材料单号：%@",_model.cldh];
        _cksjText.text = [NSString stringWithFormat:@"出库时间：%@",_model.lrsj];
        _ckztText.text = _model.shzt;
    
}


- (void)awakeFromNib {
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
