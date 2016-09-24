//
//  SearchViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "SearchViewController.h"

#import "CoredataManager.h"

#import "matermyModel.h"
@interface SearchViewController ()

@property (nonatomic,strong)NSNotification *sss;

@property (nonatomic,strong)UITextField *mytextField;

@property (nonatomic,strong)UILabel *HHView;
@end

@implementation SearchViewController


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self costumNavigation];
    [self SetupButton];
    
}




#pragma mark - 设置搜索关键字的圆角
-(void)SetupButton
{

    for (NSInteger i = 1; i < 9; i ++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 2;//边框宽度
        btn.layer.borderColor = [[UIColor grayColor] CGColor];//边框颜色
    }
    
    
}


#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onbackq)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(onback) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 4, 230, 35)];
    self.mytextField = textField;
    textField.placeholder = @"请输入搜索关键字";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = textField;
    
}

-(void)onback
{
    
    if (self.mytextField.text.length == 0) {
        self.HHView = [[UILabel alloc]init];
        self.HHView.backgroundColor = [UIColor grayColor];
        self.HHView.layer.cornerRadius = 5;
        self.HHView.layer.masksToBounds = YES;
        self.HHView.text = @"请输入关键字";
        self.HHView.textColor = [UIColor whiteColor];
        self.HHView.textAlignment = NSTextAlignmentCenter;
        self.HHView.frame = CGRectMake(0, 0, 125, 50);
        self.HHView.center = self.view.center;
        [self.view addSubview:self.HHView];
        [self createTime];
    }else{
        
        NSInteger j = 0;
        
//        for (matermyModel *model in [CoredataManager findAppALL]) {
//            j = j+[model.clsl integerValue];
//        }//删除
//        [self.delegate setOn:self.mytextField.text With:j];
        
        [self.delegate setOn:self.mytextField.text];
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    
}


-(void)onbackq
{
    
        [self.navigationController popViewControllerAnimated:NO];
  
}


//1秒定位结束
-(void)createTime
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(dismissAlertView)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)dismissAlertView
{
    
    
    
    [self.HHView removeFromSuperview];
    
}



- (IBAction)onClickButtons:(UIButton *)sender {
    
    
//    //发送通知
//    NSDictionary *dict = @{@"ON": sender.titleLabel.text};
//    //创建一个通知
//    NSNotification *nf = [NSNotification notificationWithName:@"ON" object:nil userInfo:dict];
//    //第一个参数是,监听的事件
//    //第二个参数是发送的对象,如果传nil表示群发
//    //第三个参数是发送信息
//    
//    //发送
//    [[NSNotificationCenter defaultCenter]postNotification:nf];
//
//    
//    NSLog(@"%@",sender.titleLabel.text);
//    for (matermyModel *model in [CoredataManager findAppALL]) {
//        [CoredataManager deleteModel:model];
//    }//删除

    [self.delegate setOn:sender.titleLabel.text];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.mytextField resignFirstResponder];
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
