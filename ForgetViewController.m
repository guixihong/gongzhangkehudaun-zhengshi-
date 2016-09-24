
//
//  ForgetViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "ForgetViewController.h"

#import "RequsetManager.h"

@interface ForgetViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *missLabel;

@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *tellNumText;
@property (nonatomic,strong)RequsetManager *request;
@property (strong, nonatomic) IBOutlet UITextField *passWordText;
@property (strong, nonatomic) IBOutlet UITextField *surepassWordText;

@end

@implementation ForgetViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self costumNavigation];
    self.missLabel.text = @"";
    
    
    self.userNameText.delegate = self;
    self.tellNumText.delegate = self;
    self.passWordText.delegate = self;
    self.surepassWordText.delegate = self;
    
}
#pragma mark - 设置导航栏
-(void)costumNavigation

{
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
}

-(void)onback
{
    
   
    [self.navigationController popViewControllerAnimated:NO];
    
    NSLog(@"567890-");
}

-(RequsetManager *)request
{

    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    return  _request;
}


#pragma mark - 提交

- (IBAction)onClickProvide:(UIButton *)sender {
    
    if ([self.passWordText.text isEqualToString:self.surepassWordText.text]) {
        [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=xgmm&username=%@&tel=%@&password=%@",self.userNameText.text,self.tellNumText.text,self.surepassWordText.text] parameters:nil complicate:^(BOOL success, NSString *object) {
            if (success) {
                NSLog(@"%@",object);
                
                if ([object integerValue] == 0) {
                    [self.navigationController popViewControllerAnimated:NO];
                }else{
                    
                    if ([object integerValue] == 1) {
                        self.missLabel.text = @"用户登录名为空";
                    }else if ([object integerValue] == 2){
                        
                        self.missLabel.text = @"tel电话为空";
                    }else if ([object integerValue] == 3){
                        
                        self.missLabel.text = @"用户口令为空";
                    }else{
                        
                        self.missLabel.text = @"用户名或电话错误";
                    }
                    
                    
                    
                }
                
                
                
                
                
            }else{
                
                NSLog(@"%@",object);
                
            }
        }];

    }else{
    
        self.missLabel.text = @"两次密码不一致";
    }
    
    
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.userNameText resignFirstResponder];
    [self.tellNumText resignFirstResponder];
    [self.passWordText resignFirstResponder];
    [self.surepassWordText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
