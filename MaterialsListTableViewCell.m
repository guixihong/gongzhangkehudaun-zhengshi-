//
//  MaterialsListTableViewCell.m
//  ForemanAPP
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "MaterialsListTableViewCell.h"


@implementation MaterialsListTableViewCell

-(void)setModel:(matermyModel *)model
{
    
//    clbm=FC00000000031
//    clmc=洗衣机龙头（摩恩）
//    xh=9017
//    gg=
//    jldwbm=套

    _model = model;
    _clmc.text = _model.clmc;
    _clxh.text = _model.xh;
    _clgg.text = _model.gg;
    _cldw.text = _model.jldwbm;
    _cldj.text = _model.xsj;
    
}


- (void)awakeFromNib {
//    [self createBtn];
}


-(void)createBtn
{
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 100, 0,100 , 40)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    self.quantitytextField.inputAccessoryView = button;
    self.quantitytextField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)onClick
{
    
    [self.quantitytextField resignFirstResponder];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
