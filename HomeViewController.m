//
//  HomeViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "HomeViewController.h"

#import "MaterialsListViewController.h"


#import "BuyViewController.h"


#import "QuestionsViewController.h"//常见问题


#import "BuyListViewController.h"

#import "DirectViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *Mytitle;
@property (strong, nonatomic) IBOutlet UIView *MyView;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setHidden:YES];
    
    for (NSInteger i = 1; i < 5; i ++) {
        UIButton *btn = [self.view viewWithTag:i];
        btn.backgroundColor = [UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1];
    }
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;//    iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
//    self.automaticallyAdjustsScrollViewInsets = NO;//    自动滚动调整，默认为YES
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.MyView.backgroundColor = [UIColor colorWithRed:51/256.0 green:51/256.0 blue:51/256.0 alpha:1.0];
    self.Mytitle.font = [UIFont boldSystemFontOfSize:35];
//    self.view.backgroundColor = [UIColor blackColor];
    for (NSInteger i = 1; i <= 4; i++) {
        UIButton *btn = [self.view viewWithTag:i];
        [btn setBackgroundColor:[UIColor colorWithRed:4/256.0 green:128/256.0 blue:64/256.0 alpha:1]];
    }
    
//    [self costumNavigation];
    
}
- (IBAction)onClick:(UIButton *)sender {
   
    [self.navigationController popViewControllerAnimated:NO];
}

//-(void)costumNavigation
//
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(self.view.bounds.size.width - 25, 20, 25, 25);
//    [btn setTitle:@"退出" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
//    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    
//}
//-(void)onClick
//{
//    
//    [self.navigationController popViewControllerAnimated:NO];
//}


- (IBAction)onButtons:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            
        {
//            MaterialsListViewController *home = [MaterialsListViewController alloc];
//            
//            [self.navigationController pushViewController:home animated:NO];
            
            
//            BuyListViewController *by = [[BuyListViewController alloc]init];
//            by.userName = self.userName;
//            [self.navigationController pushViewController:by animated:NO];
            BuyViewController *buy = [[BuyViewController alloc]init];
            buy.userName = self.userName;
            [self.navigationController pushViewController:buy animated:NO];

            
        }
            
            
            
            
            break;
        case 2:
        {
        
//            BuyViewController *buy = [[BuyViewController alloc]init];
//            buy.userName = self.userName;
//            [self.navigationController pushViewController:buy animated:NO];
            
            
            BuyListViewController *by = [[BuyListViewController alloc]init];
            by.userName = self.userName;
            [self.navigationController pushViewController:by animated:NO];
        }
            break;
        case 3:
            
        {
            QuestionsViewController *buy = [[QuestionsViewController alloc]init];
            buy.title = @"常见问题";
            [self.navigationController pushViewController:buy animated:NO];
        }
            break;
            
        case 4:
        {
//            DirectViewController *mm = [[DirectViewController alloc]init];
//            [self.navigationController pushViewController:mm animated:NO];
        }
            break;
            
        default:
            break;
    }

}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
