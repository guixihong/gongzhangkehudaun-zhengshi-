//
//  SureOrderViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "SureOrderViewController.h"


#import "RequsetManager.h"

@interface SureOrderViewController ()

@property (nonatomic,strong)NSMutableArray *arrayBtn;
@property (strong, nonatomic) IBOutlet UITextField *bzText;


@property (nonatomic,strong)NSMutableArray *arraysBtn;

@property (strong, nonatomic) IBOutlet UIButton *jhshsjbtn;

@property (nonatomic,strong)UIView *MMyView;
//fclb=1&psfs=1

@property (nonatomic,strong)UIDatePicker *DatePicker;

@property (nonatomic,strong)UIView *MyView;

@property (nonatomic,strong)UIView *BigMyView;
@property (nonatomic,strong)NSString *date;

@property (nonatomic,strong)RequsetManager *request;


@property (nonatomic,strong)NSString *fclb;

@property (nonatomic,strong)NSString *psfs;

@property (nonatomic,strong)NSString *mycllb;

@property (nonatomic,strong)NSString *mypsfs;


@property (nonatomic,strong)NSString *mypssj;

@property (nonatomic,strong)NSString *myobject;

@property (nonatomic,strong)UILabel *HHView;

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;//补料按钮



@property (weak, nonatomic) IBOutlet UILabel *choseLabel;//配送 Label

@end

@implementation SureOrderViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self createButton];
//    [self loadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"______+++++++++%@",self.khdz);
    NSLog(@"&&&&&&&&&&&&&&&&&&&&%@",self.money);
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    [self costumNavigation];
    [self createLabel];//创建Label
    
    for (NSInteger i = 30; i < 33; i ++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.backgroundColor = [UIColor clearColor];
        [self.arrayBtn addObject:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"默认.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
    }
    self.bzText.text = self.khdz;
     UIButton *btn1 = [self.view viewWithTag:30];
    btn1.selected = YES;
    
    self.fclb = @"1";
    
    for (NSInteger i = 33; i < 36; i ++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.backgroundColor = [UIColor clearColor];
        [self.arraysBtn addObject:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"默认.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
    }
    
    UIButton *btn = [self.view viewWithTag:33];
    btn.selected = YES;
    
    self.psfs = @"1";
    self.mycllb = @"开工";
    self.mypsfs = @"配送";
    self.jhshsjbtn.layer.borderWidth = 1;
    self.jhshsjbtn.layer.borderColor = [[UIColor grayColor] CGColor];
    
}





-(void)createLabel
{

//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    
//    label.layer.cornerRadius = 3;
//    label.layer.masksToBounds = YES;
}

#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"确定订单";
   [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
}

-(RequsetManager *)request
{

    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    return  _request;
}


-(NSMutableArray *)arrayBtn
{

    if (_arrayBtn == nil) {
        _arrayBtn = [NSMutableArray array];
    }
    return _arrayBtn;
}


-(NSMutableArray *)arraysBtn
{

    if (_arraysBtn == nil) {
        _arraysBtn = [NSMutableArray array];
    }
    return _arraysBtn;
}

#pragma mark - 材料类别按钮
- (IBAction)onButtons:(UIButton *)sender {
    
    //fclb=1&psfs=1
    
    self.mycllb = sender.titleLabel.text;
    switch (sender.tag) {
        case 30:
            self.fclb = @"1";
            self.mycllb = @"开工";
            self.choseLabel.text = @"配送";
            break;
        case 31:
        { self.fclb = @"2";
            self.mycllb = @"补料";
            self.choseLabel.text = @"配送(自费)";
            
        }
            break;
        case 32:
            self.fclb = @"3";
            self.mycllb = @"中期";
            self.choseLabel.text = @"配送";
            break;
        default:
            break;
    }
    
    
    if (sender.selected) {//如果已经选中 直接返回
        return;
    }
    
    for (UIButton * b in self.arrayBtn) {
        b.selected = NO;
    }
    
    sender.selected = YES;

    
    NSLog(@"76576");
    
}

#pragma mark - 配送方式按钮
- (IBAction)peisongButtons:(UIButton *)sender {
    
    self.mypsfs = sender.titleLabel.text;
    switch (sender.tag) {
        case 33:
            self.psfs = @"1";
            self.mypsfs = @"配送";
            break;
        case 34:
            self.psfs = @"2";
            self.mypsfs = @"自提";
            break;
        case 35:
            self.psfs = @"9";
            self.mypsfs = @"其它";
            break;
   
        default:
            break;
    }

    
    if (sender.selected) {//如果已经选中 直接返回
        return;
    }
    
    for (UIButton * b in self.arraysBtn) {
        b.selected = NO;
    }
    
    sender.selected = YES;
    
    
    NSLog(@"76576");

}
- (IBAction)jhshsjButton:(UIButton *)sender {
    
    
    [self createUIDatePicker];
    NSString *hhh = [[NSString stringWithFormat:@"%@",self.DatePicker.date] componentsSeparatedByString:@" "][0];
    [self.jhshsjbtn setTitle:hhh forState:UIControlStateNormal];
    sender.enabled = NO;
    [self createButtons];

}


#pragma mark - 创建日期选择器
-(void)createUIDatePicker
{
    
    CGRect rect = self.jhshsjbtn.frame;
    
    self.MMyView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.MyView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:245/255.0 alpha:0.3];
    UIDatePicker *date = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 100)];
    date.center = self.MMyView.center;
    date.layer.cornerRadius = 5;
    date.layer.masksToBounds = YES;
    date.alpha = 1;
    date.datePickerMode = UIDatePickerModeDate;
    date.backgroundColor = [UIColor grayColor];
    NSLog(@"%@",date.date);
    [date addTarget:self action:@selector(Change) forControlEvents:UIControlEventValueChanged];
    
    [self.MMyView addSubview:date];
    [self.view addSubview:self.MMyView];
    self.DatePicker = date;
    
    
    
    
    
}

-(void)Change
{
    NSDate *date = self.DatePicker.date;
    NSString *str = [NSString stringWithFormat:@"%@",date];
    self.date = [str componentsSeparatedByString:@" "][0];
    
}

-(void)createButtons
{
//    CGRect rect = self.DatePicker.frame;
//    NSArray *name = @[@"确定",@"取消"];
//    NSInteger i=0;
//    for (NSString *title in name) {
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(rect.origin.x+i*(rect.size.width-50), rect.origin.y+rect.size.height, 50, 30)];
//        button.backgroundColor = [UIColor purpleColor];
//        button.layer.cornerRadius = 2;
//        button.layer.masksToBounds = YES;
//        [button setTitle:title forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [self.MMyView addSubview:button];
//        i++;
//        button.tag = i;
//        [button addTarget:self action:@selector(onClickbtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
    
        CGRect rect = self.DatePicker.frame;
        NSInteger i=0;
    
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(rect.origin.x+i*(rect.size.width-50), rect.origin.y+rect.size.height, rect.size.width, 30)];
            button.backgroundColor = [UIColor grayColor];
            button.layer.cornerRadius = 2;
            button.layer.masksToBounds = YES;
            [button setTitle:@"确  定" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [self.MMyView addSubview:button];
    
            [button addTarget:self action:@selector(onClickbtn:) forControlEvents:UIControlEventTouchUpInside];
    

    
}


-(void)onClickbtn:(UIButton *)btn
{
    

        
        if ([self.date isEqualToString:@"nill"]) {
            NSString *hhh = [[NSString stringWithFormat:@"%@",self.DatePicker.date] componentsSeparatedByString:@" "][0];
            
            NSLog(@"^^^^^%@^^^^^",hhh);
            
            [self.jhshsjbtn setTitle:hhh forState:UIControlStateNormal];
        }else{
            
            if (self.date == nil) {
                NSString *hhh = [[NSString stringWithFormat:@"%@",self.DatePicker.date] componentsSeparatedByString:@" "][0];
                
                NSLog(@"^^^^^%@^^^^^",hhh);
                
                [self.jhshsjbtn setTitle:hhh forState:UIControlStateNormal];
                
            }else{
                
                [self.jhshsjbtn setTitle:self.date forState:UIControlStateNormal];
                
                
                
                
                
                
                
            }
            
        }
        
        self.date = nil;
        
    [self.MMyView removeFromSuperview];
    
    [self.MMyView removeFromSuperview];
    
    self.jhshsjbtn.enabled = YES;
    
    
//    NSLog(@"----*****----%@",self.jhshsjbtn.titleLabel.text);
}




#pragma mark - 创建Button
-(void)createButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"确定信息" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor colorWithRed:15/256.0 green:135/256.0 blue:206/256.0 alpha:0.8]];
    [button addTarget:self action:@selector(onSureOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}


-(void)onSureOrder
{

    [self.bzText resignFirstResponder];
    
    
//http://111.200.41.13:8090/sgdmm?fclb=1&psfs=1&psdzt=1&funname=insertCld&jhshsj=2016-06-13&lrr=chenjm1&khbh=0013031&psph=P001303116007
    
    if (self.jhshsjbtn.titleLabel.text.length < 6) {
        self.HHView = [[UILabel alloc]init];
        self.HHView.backgroundColor = [UIColor grayColor];
        self.HHView.layer.cornerRadius = 5;
        self.HHView.layer.masksToBounds = YES;
        self.HHView.text = @"请先选择时间";
        self.HHView.textColor = [UIColor whiteColor];
        self.HHView.textAlignment = NSTextAlignmentCenter;
        self.HHView.frame = CGRectMake(0, 0, 250, 50);
        self.HHView.center = self.view.center;
        [self.view addSubview:self.HHView];
        [self createTime];

    }else{
    
        
        NSLog(@"+++++++****+++++%@",[self compareTime:self.jhshsjbtn.titleLabel.text]);
        
        
        
        if ([[self compareTime:self.jhshsjbtn.titleLabel.text] isEqualToString:@"no"]) {
            
            
            self.HHView = [[UILabel alloc]init];
            self.HHView.backgroundColor = [UIColor grayColor];
            self.HHView.layer.cornerRadius = 5;
            self.HHView.layer.masksToBounds = YES;
            self.HHView.text = @"请选择距今天后两天的时间";
            self.HHView.textColor = [UIColor whiteColor];
            self.HHView.textAlignment = NSTextAlignmentCenter;
            self.HHView.frame = CGRectMake(0, 0, 250, 50);
            self.HHView.center = self.view.center;
            [self.view addSubview:self.HHView];
            [self createTime];
            
            
        }else{
            
            
            
            
            
            
            if (self.jhshsjbtn.titleLabel.text.length < 6) {
                UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"请选择日期" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
                [self.view addSubview:aler];
                
            }
//
            
            
            
            self.BigMyView = [[UIView alloc]initWithFrame:self.view.bounds];
            
            UIView *youView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            youView.backgroundColor = [UIColor blackColor];
            youView.alpha = 0.5;
            [self.view addSubview:youView];
            UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];//创建View
            youView.tag = 2;
            myview.backgroundColor = [UIColor whiteColor];
            myview.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
            
            //                            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];//X号按钮
            //                            btn.tag = 9;
            //                            btn.frame = CGRectMake(myview.bounds.size.width - 27, 5, 25, 25);
            //                            [btn setBackgroundImage:[UIImage imageNamed:@"guanbi-contact.png"] forState:UIControlStateNormal];
            //                            [btn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
            //                            [myview addSubview:btn];
            
            
            
            myview.layer.cornerRadius = 20;
            myview.layer.masksToBounds = YES;
            myview.layer.borderWidth = 1;//边框宽度
            myview.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 60)];
            label.text = @"请确定填写信息是否正确";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont boldSystemFontOfSize:17];
            label.textAlignment = NSTextAlignmentCenter;
            NSArray *array = @[@"修改",@"确定"];
            for (NSInteger i = 0; i < 2; i ++) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(myview.frame.size.width/2*i, myview.frame.size.height - 60, myview.frame.size.width/2, 60);
                btn.backgroundColor = [UIColor whiteColor];
                btn.layer.borderWidth = 0.5;//边框宽度
                btn.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
                [btn setTitleColor:[UIColor colorWithRed:0.0 green:122.0/256 blue:255.0/256 alpha:1] forState:UIControlStateNormal];
                [btn setTitle:array[i] forState:UIControlStateNormal];
                btn.tag = i + 1;
                [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
                [myview addSubview:btn];
            }
            
            [myview addSubview:label];
            
            
            
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 200, 60)];
            label1.text = [NSString stringWithFormat:@"  材料类别: %@",self.mycllb];
            label1.font = [UIFont boldSystemFontOfSize:16];
            label1.textAlignment = NSTextAlignmentLeft;
            [myview addSubview:label1];
            
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 200, 60)];
            label2.text = [NSString stringWithFormat:@"  配送方式: %@",self.mypsfs];
            label2.font = [UIFont boldSystemFontOfSize:16];
            label2.textAlignment = NSTextAlignmentLeft;
            [myview addSubview:label2];
            
            
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 200, 60)];
            label3.text = [NSString stringWithFormat:@"  配送时间: %@",self.jhshsjbtn.titleLabel.text];
            
            label3.font = [UIFont boldSystemFontOfSize:16];
            label3.textAlignment = NSTextAlignmentLeft;
            [myview addSubview:label3];
          
            
            UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 250, 60)];
            label4.text = [NSString stringWithFormat:@"  配送地址: %@",self.khdz];
            label4.numberOfLines = 0;
            
            label4.font = [UIFont boldSystemFontOfSize:16];
            label4.textAlignment = NSTextAlignmentLeft;
            [myview addSubview:label4];
            
            
            
            UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 250, 60)];
            label5.text = [NSString stringWithFormat:@"  材料总价: %@",self. money];
            label5.numberOfLines = 0;
            
            label5.font = [UIFont boldSystemFontOfSize:16];
            label5.textAlignment = NSTextAlignmentLeft;
            [myview addSubview:label5];
            
            [self.view addSubview:youView];
            [self.BigMyView addSubview:myview];
            [self.view addSubview:self.BigMyView];
            

            
        }
        

    }
    
    

    
    
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



-(NSString *)compareTime:(NSString *)time
{

    
    NSArray *new = [time componentsSeparatedByString:@"-"];
    
    NSInteger new1 = [new[0] integerValue];
    NSInteger new2 = [new[1] integerValue];
    NSInteger new3 = [new[2] integerValue];
    
    
    
    NSString *str1 = [NSString stringWithFormat:@"%@",[[UIDatePicker alloc]init].date];//今天的时间
    NSArray *data = [[str1 componentsSeparatedByString:@" "][0] componentsSeparatedByString:@"-"];
    
    
    NSInteger data1 = [data[0] integerValue];
    NSInteger data2 = [data[1] integerValue];
    NSInteger data3 = [data[2] integerValue];
    
    if ((new1 >= data1 && new2 >= data2 && ((data3 - new3) <= -2)) || (new1 >= data1 && new2 > data2) || new1 > data1) {
        return @"yes";
    }else{
    
        return @"no";
    }
}


-(void)removeView
{

    UIView *view = [self.view viewWithTag:2];
    [view removeFromSuperview];

}


-(void)onClick:(UIButton *)Button
{

    switch (Button.tag) {
        case 1:
        {
        
            UIView *view = [self.view viewWithTag:2];
            [view removeFromSuperview];
            
            UIView *view1 = [self.view viewWithTag:5];
            
            [view1 removeFromSuperview];
            
            [self.BigMyView removeFromSuperview];

        }
            break;
            
        case 2:
            [self sureButton];
            break;
            
        default:
            break;
    }
}



-(void)sureButton
{

    
    UIView *view = [self.view viewWithTag:2];
    
    [view removeFromSuperview];
    
    UIView *view1 = [self.view viewWithTag:5];
    
     [view1 removeFromSuperview];
    [self.BigMyView removeFromSuperview];
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"请认真核对材料单及金额后下单,否则后果自负" message:nil delegate:self cancelButtonTitle:@"修改" otherButtonTitles:@"确定下单", nil];
    [aler show];
 
    [self.view addSubview:aler];

    
    
}


#pragma mark - 实现提示框代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 0) {
        
    }else{
        
        [self sureBuy];//提示框的确定下单
    }
    
}


-(void)sureBuy
{
    
    if ([self.panduan isEqualToString:@"yes"]) {//从快捷下单传过来
        [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?fclb=%@&psfs=%@&psdzt=1&funname=insertCld&jhshsj=%@&lrr=%@&khbh=%@&psph=%@&bz=%@",self.fclb,self.psfs,self.jhshsjbtn.titleLabel.text,self.userName,self.model.khbh,self.mybh,[self.bzText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil complicate:^(BOOL success, id object) {
            if (success) {
                
                NSLog(@"%@",object);
                
                self.myobject = object;
                
                UIView *view = [self.view viewWithTag:2];
                [view removeFromSuperview];
                
                UIView *youView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                youView.backgroundColor = [UIColor blackColor];
                youView.alpha = 0.5;
                youView.tag = 7;
                [self.view addSubview:youView];
                UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 160)];//创建View
                myview.tag = 5;
                myview.backgroundColor = [UIColor whiteColor];
                myview.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
                
                //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];//X号按钮
                //    btn.tag = 9;
                //    btn.frame = CGRectMake(myview.bounds.size.width - 27, 5, 25, 25);
                //    [btn setBackgroundImage:[UIImage imageNamed:@"guanbi-contact.png"] forState:UIControlStateNormal];
                //    [btn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
                //    [myview addSubview:btn];
                
                
                
                myview.layer.cornerRadius = 20;
                myview.layer.masksToBounds = YES;
                myview.layer.borderWidth = 1;//边框宽度
                myview.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
                
                
                
                
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 20)];
                label.text = @"你已下单成功";
                label.font = [UIFont boldSystemFontOfSize:17];
                label.textAlignment = NSTextAlignmentCenter;
                
                
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 200, 20)];
                label1.text = @"等待材料出库";
                label1.font = [UIFont boldSystemFontOfSize:17];
                label1.textAlignment = NSTextAlignmentCenter;
                
                
                
                UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, myview.frame.size.width, 20)];
                label2.text = [NSString stringWithFormat:@"材料单号为: %@",self.myobject];
                label2.textColor = [UIColor redColor];
                label2.font = [UIFont boldSystemFontOfSize:17];
                label2.textAlignment = NSTextAlignmentCenter;
                
                
                UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, myview.frame.size.width, 20)];
                label3.text = [NSString stringWithFormat:@"配送时间: %@    ",self.jhshsjbtn.titleLabel.text];
                
                label3.textColor = [UIColor redColor];
                label3.font = [UIFont boldSystemFontOfSize:17];
                label3.textAlignment = NSTextAlignmentCenter;
                
                
                NSArray *array = @[@"修改",@"保存"];
                for (NSInteger i = 0; i < 2; i ++) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(myview.frame.size.width/2*i, myview.frame.size.height - 60, myview.frame.size.width/2, 60);
                    btn.backgroundColor = [UIColor whiteColor];
                    btn.layer.borderWidth = 0.5;//边框宽度
                    btn.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
                    [btn setTitleColor:[UIColor colorWithRed:0.0 green:122.0/256 blue:255.0/256 alpha:1] forState:UIControlStateNormal];
                    [btn setTitle:array[i] forState:UIControlStateNormal];
                    btn.tag = i + 3;
                    [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [myview addSubview:btn];
                }
                
                [myview addSubview:label];
                [myview addSubview:label1];
                [myview addSubview:label2];
                [myview addSubview:label3];
                [self.view addSubview:myview];
                

                
                
            }else{
                
                NSLog(@"%@",object);
                
            }
        }];
        
    }else{
        
        
        
        if ([[self compareTime:self.jhshsjbtn.titleLabel.text] isEqualToString:@"no"]) {
            
            
            self.HHView = [[UILabel alloc]init];
            self.HHView.backgroundColor = [UIColor grayColor];
            self.HHView.layer.cornerRadius = 5;
            self.HHView.layer.masksToBounds = YES;
            self.HHView.text = @"请选择距今天后两天的时间";
            self.HHView.textColor = [UIColor whiteColor];
            self.HHView.textAlignment = NSTextAlignmentCenter;
            self.HHView.frame = CGRectMake(0, 0, 250, 50);
            self.HHView.center = self.view.center;
            [self.view addSubview:self.HHView];
            [self createTime];
            
            
        }else{
            
            [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?fclb=%@&psfs=%@&psdzt=1&funname=insertCld&jhshsj=%@&lrr=%@&khbh=%@&psph=%@&bz=%@",self.fclb,self.psfs,self.jhshsjbtn.titleLabel.text,self.userName,self.khbh,self.psph,[self.bzText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil complicate:^(BOOL success, id object) {
                if (success) {
                    
                    NSLog(@"%@",object);
                    
                    self.myobject = object;
                    
                    UIView *view = [self.view viewWithTag:2];
                    [view removeFromSuperview];
                    
                    UIView *youView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
                    youView.backgroundColor = [UIColor blackColor];
                    youView.alpha = 0.5;
                    youView.tag = 7;
                    [self.view addSubview:youView];
                    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 160)];//创建View
                    myview.tag = 5;
                    myview.backgroundColor = [UIColor whiteColor];
                    myview.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
                    
                    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];//X号按钮
                    //    btn.tag = 9;
                    //    btn.frame = CGRectMake(myview.bounds.size.width - 27, 5, 25, 25);
                    //    [btn setBackgroundImage:[UIImage imageNamed:@"guanbi-contact.png"] forState:UIControlStateNormal];
                    //    [btn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
                    //    [myview addSubview:btn];
                    
                    
                    
                    myview.layer.cornerRadius = 20;
                    myview.layer.masksToBounds = YES;
                    myview.layer.borderWidth = 1;//边框宽度
                    myview.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
                    
                    
                    
                    
                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 20)];
                    label.text = @"你已下单成功";
                    label.font = [UIFont boldSystemFontOfSize:17];
                    label.textAlignment = NSTextAlignmentCenter;
                    
                    
                    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, 200, 20)];
                    label1.text = @"等待材料出库";
                    label1.font = [UIFont boldSystemFontOfSize:17];
                    label1.textAlignment = NSTextAlignmentCenter;
                    
                    
                    
                    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, myview.frame.size.width, 20)];
                    label2.text = [NSString stringWithFormat:@"材料单号为: %@",self.myobject];
                    label2.textColor = [UIColor redColor];
                    label2.font = [UIFont boldSystemFontOfSize:17];
                    label2.textAlignment = NSTextAlignmentCenter;
                    
                    
                    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, myview.frame.size.width, 20)];
                    label3.text = [NSString stringWithFormat:@"配送时间: %@    ",self.jhshsjbtn.titleLabel.text];
                    
                    label3.textColor = [UIColor redColor];
                    label3.font = [UIFont boldSystemFontOfSize:17];
                    label3.textAlignment = NSTextAlignmentCenter;
                    
                    
                    NSArray *array = @[@"修改",@"保存"];
                    for (NSInteger i = 0; i < 2; i ++) {
                        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                        btn.frame = CGRectMake(myview.frame.size.width/2*i, myview.frame.size.height - 60, myview.frame.size.width/2, 60);
                        btn.backgroundColor = [UIColor whiteColor];
                        btn.layer.borderWidth = 0.5;//边框宽度
                        btn.layer.borderColor = [[UIColor blackColor] CGColor];//边框颜色
                        [btn setTitleColor:[UIColor colorWithRed:0.0 green:122.0/256 blue:255.0/256 alpha:1] forState:UIControlStateNormal];
                        [btn setTitle:array[i] forState:UIControlStateNormal];
                        btn.tag = i + 3;
                        [btn addTarget:self action:@selector(onClickBtn:) forControlEvents:UIControlEventTouchUpInside];
                        [myview addSubview:btn];
                    }
                    
                    [myview addSubview:label];
                    [myview addSubview:label1];
                    [myview addSubview:label2];
                    [myview addSubview:label3];
                    [self.view addSubview:myview];
                    
                }else{
                    
                    NSLog(@"%@",object);
                    
                }
            }];
            
        }
        
        
        
        
    }
    
    
    
}




#pragma mark - 点击保存按钮
-(void)onClickBtn:(UIButton *)Button
{

    switch (Button.tag) {
        case 3:
        {
            
            UIView *view = [self.view viewWithTag:5];
            [view removeFromSuperview];
            
            UIView *view7 = [self.view viewWithTag:7];
            [view7 removeFromSuperview];
            
            [self.BigMyView removeFromSuperview];
            
        }
            break;
            
        case 4://点击保存返回
        {

            
            UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
            
            UIGraphicsBeginImageContext(screenWindow.bounds.size);
            
            [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
            
            UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
            
            self.HHView = [[UILabel alloc]init];
            self.HHView.backgroundColor = [UIColor grayColor];
            self.HHView.layer.cornerRadius = 5;
            self.HHView.layer.masksToBounds = YES;
            self.HHView.text = @"截屏成功";
            self.HHView.textColor = [UIColor whiteColor];
            self.HHView.textAlignment = NSTextAlignmentCenter;
            self.HHView.frame = CGRectMake(0, 0, 250, 50);
            self.HHView.center = self.view.center;
            [self.view addSubview:self.HHView];
            [self createTime1];

            
        }
            break;
            
        default:
            break;
    }

}


//1秒定位结束
-(void)createTime1
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(dismissAlertView1)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)dismissAlertView1
{
    
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
    

    
}




-(void)removeView1
{
    
    UIView *view = [self.view viewWithTag:5];
    [view removeFromSuperview];
    
}


-(void)onback
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.bzText resignFirstResponder];
//    [self.MMyView removeFromSuperview];
//    self.jhshsjbtn.enabled = YES;

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
