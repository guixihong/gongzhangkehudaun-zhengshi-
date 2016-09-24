//
//  LoginViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "LoginViewController.h"

#import "HomeViewController.h"


#import "RequsetManager.h"

#import "ForgetViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UILabel *missLabel;
@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *possWordText;
@property (strong,nonatomic)RequsetManager *requset;
@property (strong, nonatomic) IBOutlet UIButton *loginPhoto;
@property (nonatomic,strong)NSUserDefaults *Defaults;
@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    UIImage *image = [UIImage imageNamed:@"user---alt.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    self.userNameText.leftView =  imageView;
    self.userNameText.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    UIImage *image1 = [UIImage imageNamed:@"key---alt.png"];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = image1;
    self.possWordText.leftView =  imageView1;
    self.possWordText.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    [self.loginPhoto setBackgroundImage:[UIImage imageNamed:@"矩形-2-副本.png"] forState:UIControlStateNormal];//是否保存密码
    [self.loginPhoto setBackgroundImage:[UIImage imageNamed:@"70.png"] forState:UIControlStateSelected];//是否保存密码
    [self.loginPhoto addTarget:self action:@selector(onState) forControlEvents:UIControlEventTouchUpInside];//点击是否保存密码
    self.loginPhoto.layer.masksToBounds = YES;
    self.userNameText.text = [self.Defaults objectForKey:@"userName"];
    self.possWordText.text = [self.Defaults objectForKey:@"pastWord"];
    self.loginPhoto.selected = [[self.Defaults objectForKey:@"hhh"] boolValue];//记住密码的状态
    self.missLabel.text = @"";
    
}



-(void)onState
{
    
    
    if (self.loginPhoto.selected == YES) {//判断状态  选中状态
        self.loginPhoto.selected = NO;
        [self.Defaults setObject:@0 forKey:@"hhh"];
        [self.Defaults setObject:nil forKey:@"userName"];
        [self.Defaults setObject:nil forKey:@"pastWord"];
        [self.Defaults synchronize];
    }else{//非选中状态
        self.loginPhoto.selected = YES;
        [self.Defaults setObject:@1 forKey:@"hhh"];
        [self.Defaults setObject:self.userNameText.text forKey:@"userName"];
        [self.Defaults setObject:self.possWordText.text forKey:@"pastWord"];
        [self.Defaults synchronize];
    }
    
}
- (IBAction)forgetPassWord:(UIButton *)sender {
    
    ForgetViewController *forget = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:forget animated:NO];
}


-(NSUserDefaults *)Defaults
{
    
    if (_Defaults == nil) {
        _Defaults = [NSUserDefaults standardUserDefaults];
    }
    return _Defaults;
}

-(RequsetManager *)requset
{

    if (_requset == nil) {
        _requset = [[RequsetManager alloc]init];
    }
    return _requset;
}

#pragma mark - 加载数据
-(void)loaddata
{
        [self.requset requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=login&username=%@&password=%@",self.userNameText.text,self.possWordText.text] parameters:nil complicate:^(BOOL success, NSString *object) {
            if (success) {
               
                NSLog(@"+++++++++++++%@_________",object);
                if ([object integerValue] == 0) {
                HomeViewController *home = [[HomeViewController alloc]init];
                home.userName = self.userNameText.text;
                [self.navigationController pushViewController:home animated:NO];
                    self.missLabel.text = @"";
                }else{
                
                    if ([object integerValue] == 1) {
                        self.missLabel.text = @"用户登录名为空";
                    }else if ([object integerValue] == 2){
                    
                        self.missLabel.text = @"用户口令为空";
                    }else if ([object integerValue] == 3){
                        
                        self.missLabel.text = @"请修改初始密码";
                    }else{
                        
                        self.missLabel.text = @"用户名或密码错误";
                    }
                    
                }
                
            }else{
            
                NSLog(@"++++%@",object);
            }
        }];
      
}



#pragma mark - 登录按钮
- (IBAction)LoginButton:(id)sender {
    
    
    [self loaddata];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.userNameText resignFirstResponder];
    [self.possWordText resignFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
