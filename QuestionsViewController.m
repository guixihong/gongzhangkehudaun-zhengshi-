//
//  QuestionsViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "QuestionsViewController.h"

#import "QuestionsTableViewCell.h"

@interface QuestionsViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *TPdataSource;
@property (nonatomic,strong)NSMutableArray *MCdataSource;
@property (nonatomic,strong)NSMutableArray *XHdataSource;

@property (nonatomic,strong)UIView *myView;
@end

@implementation QuestionsViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self RegisterTableView];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self costumNavigation];//设置导航栏
    
}

#pragma mark - 设置导航栏
-(void)costumNavigation

{
    self.navigationController.navigationBarHidden = NO;

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
}

-(void)onback
{
    
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 加载数据
-(void)loadData
{

    
    NSArray *array3 = @[
                        @"FC00000000171.jpg",
                        @"FC00000000172.jpg",
                        @"FC00000000173.jpg",
                        @"FC00000000174.jpg",
                        @"FC00000000175.jpg",
                        @"FC00000000176.jpg",
                        @"FC00000000177.jpg",
                        @"FC00000000178.jpg",
                        @"FC00000000182.jpg",
                        @"FC00000000181.jpg",
                        @"FC00000000183.jpg",
                        @"FC00000000179.jpg",
                        @"FC00000000180.jpg"];
    
    [self.TPdataSource addObjectsFromArray:array3];
    
    
    NSArray *array1 = @[
                       @"石膏线(10公分金雅--899套餐顶角线)",
                       @"石膏线(10公分金雅--新古典造型线)",
                       @"石膏线(10公分育美--899套餐顶角线)",
                       @"石膏线(10公分育美-新古典造型线)",
                       @"石膏线(15公分金雅--899套餐顶角线)",
                       @"石膏线(15公分金雅--新中式顶角线)",
                       @"石膏线(15公分育美--899套餐顶角线)",
                       @"石膏线(15公分育美--新中式顶角线)",
                       @"石膏线(5.5公分金雅-简欧墙面造型线)",
                       @"石膏线(5.5公分育美-简欧墙面造型线)",
                       @"石膏线(7公分金雅--平线)",
                       @"石膏线(9公分金雅--新古典顶角线)",
                       @"石膏线(9公分育美--新古典顶角线)"];
    [self.MCdataSource addObjectsFromArray:array1];
    
    
    NSArray *array2 = @[
    @"100*24*2400mm",
    @"100*100*2400mm",
    @"100*24*2400mm",
    @"100*100*2400mm",
    @"150*24*2400mm",
    @"150*12*2400mm",
    @"150*24*2400mm",
    @"150*12*2400mm",
    @"55*55*2000mm",
    @"55*55*2000mm",
    @"--",
    @"90*90*2400mm",
    @"90*90*2400mm"];
    
    [self.XHdataSource addObjectsFromArray:array2];

    
    [self.tableView reloadData];
}


#pragma mark - 注册tableView
-(void)RegisterTableView
{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 322;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
}

-(NSMutableArray *)TPdataSource
{

    if (_TPdataSource == nil) {
        _TPdataSource = [NSMutableArray array];
    }
    return _TPdataSource;
}



-(NSMutableArray *)MCdataSource
{

    if (_MCdataSource == nil) {
        _MCdataSource = [NSMutableArray array];
    }
    return _MCdataSource;
}

-(NSMutableArray *)XHdataSource
{

    if (_XHdataSource == nil) {
        _XHdataSource = [NSMutableArray array];
    }
    return _XHdataSource;
}

#pragma mark - 实现tableView代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.XHdataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    QuestionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.3;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.clmc.text = self.MCdataSource[indexPath.row];
    cell.imageView.image = nil;//解决图片复用的问题
    if (cell.imageView.image == nil) {
        cell.imageView.image = [UIImage imageNamed:self.TPdataSource[indexPath.row]];
    }else{
    
       
    }
    
    cell.clxh.text = self.XHdataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    self.myView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.myView];
    self.myView.backgroundColor = [UIColor grayColor];
//    self.myView.alpha = 0.5;
    
    UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
    view.frame = CGRectMake(0, 0, 300, 300);
    [view setBackgroundImage:[UIImage imageNamed:self.TPdataSource[indexPath.row]] forState:UIControlStateNormal];
    [view addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    view.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    [self.myView addSubview:view];
    
}

-(void)onClick
{

    [self.myView removeFromSuperview];
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
