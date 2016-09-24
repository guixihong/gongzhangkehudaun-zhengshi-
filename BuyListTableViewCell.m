//
//  BuyListTableViewCell.m
//  ForemanAPP
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyListTableViewCell.h"

@implementation BuyListTableViewCell

-(void)setModel:(BuildModel *)model
{

    
//    xsph=FX011500012
//    xszsl=20.0
//    xszje=12.0
//    xsdzt=等待审核
//    lrsj=2015-11-1200:00
    
    _model = model;
    
    

    _ksdhf.text = [NSString stringWithFormat:@"出库时间：%@",[[NSMutableString stringWithString:_model.xsdztSJ] substringToIndex:10]];
    _xsdhtext.text = [NSString stringWithFormat:@"销售单号: %@",_model.xsph];

    _xstttext.text = [NSString stringWithFormat:@"审核状态: %@",_model.xsdzt];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
