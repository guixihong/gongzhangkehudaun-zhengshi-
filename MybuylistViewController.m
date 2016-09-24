//
//  MybuylistViewController.m
//  ForemanAPP
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "MybuylistViewController.h"

#import "CoredataManager.h"

#import "matermyModel.h"

#import "RequsetManager.h"

#import "MyCoredataManager.h"

@interface MybuylistViewController ()<UITextFieldDelegate,UITextViewDelegate>


@property (nonatomic,strong)RequsetManager *requset;

@property (nonatomic,strong)UILabel *HHView;
@property (strong, nonatomic) IBOutlet UIButton *sureOnClickBtn;
@property (strong, nonatomic) IBOutlet UILabel *misLabel;

@end

@implementation MybuylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureOnClickBtn.backgroundColor = [UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1];
    [self costumNavigation];
    self.misLabel.text = @"";
    self.shdz.text = self.khdz;
    self.srlxdh.delegate = self;
}


#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"销售单录入";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
}


-(RequsetManager *)requset
{

    if (_requset == nil) {
        _requset = [[RequsetManager alloc]init];
    }
    return _requset;
}
- (IBAction)onClickBtn:(UIButton *)sender {
    
    
//    srmc;
//    srlxdh;
//    shdz;
    
    if (self.srmc.text.length == 0) {
        self.misLabel.text = @"收货方名称不能为空!";
    }else if (self.srlxdh.text.length == 0){
    
        self.misLabel.text = @"收货方联系方式不能为空!";
    }else if (self.shdz.text.length == 0){
    
        self.misLabel.text = @"收货地址不能为空!";
    }else{
    
        
        [self.requset requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsdzt=&xsph=&lrr=%@&funname=insertXsd&shfmc=%@&shrlxfs=%@&shfdz=%@",self.userName,[self.srmc.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.srlxdh.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self.shdz.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil complicate:^(BOOL success, NSString * object) {
            if (success) {
                NSLog(@"%@",object);
                
                
                
                //            BuyListViewController *buy = [[BuyListViewController alloc]init];
                //            [self presentViewController:buy animated:NO completion:nil];
                
                
                
                
                //
                //                clbm=FC00000000031
                //                clmc=洗衣机龙头（摩恩）
                //                xh=9017
                //                gg=
                //                jldwbm=套
                
                NSMutableString *dates = [[NSMutableString alloc]init];
                
                NSInteger i = 0;
                
                for (matermyModel *model in [CoredataManager findAppALL]) {
                    NSString *MyStr = [NSString stringWithFormat:@"%@*%@^",model.clbm,model.clsl];
                    
                    
                    [dates appendString:MyStr];
                    i++;
                    
                    
                }
                
                
                
                
                NSString *ss =  [[dates substringToIndex:dates.length - 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//去除最后的^并转换URL
                
                NSLog(@"########%@",ss);
                [self.requset requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsdzt=2&xsph=%@&dates=%@&funname=insertXsdmxs",object,[NSString stringWithFormat:@"%@",ss]] parameters:nil complicate:^(BOOL success, id object) {
                    if (success) {
                        
                        NSLog(@"%@",object);
                        
                        for (matermyModel *model in [CoredataManager findAppALL]) {
                            [CoredataManager deleteModel:model];
                        }//删除所有的数据
                        
                        for (matermyModel *model in [MyCoredataManager findAppALL]) {
                            [MyCoredataManager deleteModel:model];
                        }
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
                        
                        //
                        //                                                self.HHView = [[UILabel alloc]init];
                        //                                                self.HHView.backgroundColor = [UIColor grayColor];
                        //                                                self.HHView.layer.cornerRadius = 5;
                        //                                                self.HHView.layer.masksToBounds = YES;
                        //                                                self.HHView.text = @"提交成功";
                        //                                                self.HHView.textColor = [UIColor whiteColor];
                        //                                                self.HHView.textAlignment = NSTextAlignmentCenter;
                        //                                                self.HHView.frame = CGRectMake(0, 0, 100, 50);
                        //                                                self.HHView.center = self.view.center;
                        //                                                [self.view addSubview:self.HHView];
                        //                                                [self createTime3];
                        //                    
                        
                        
                        
                    }else{
                        NSLog(@"%@",object);
                        
                    }
                }];
                
                
                
            }else{
                NSLog(@"%@",object);
                
            }
        }];
        

    }
}




-(void)onback
{
//    for (matermyModel *model in [CoredataManager findAppALL]) {
//        [CoredataManager deleteModel:model];
//    }//删除所有的数据
    [self.navigationController popViewControllerAnimated:NO];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{


    [self.srmc resignFirstResponder];
    [self.srlxdh resignFirstResponder];
    [self.shdz resignFirstResponder];
    
}


//(控制键盘输入的字符数量)
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (textField.tag == 10) {
        NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
        if (str.length < 11) {
            [str insertString:string atIndex:range.length];
            return YES;
        }else{
            
            return NO;
        }
        
        
    }
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
