//
//  BuyViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyViewController.h"


#import "BuyTableViewCell.h"


#import "MaterialsListViewController.h"


#import "BuildDetailViewController.h"


#import "RequsetManager.h"

#import "GDataXMLNode.h"


#import "MaterialModel.h"


#import "MBProgressHUD.h"

static NSString *cellID = @"cellID";

@interface BuyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *_hud;
    
}

@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)RequsetManager *request;


@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation BuyViewController

-(void)viewWillAppear:(BOOL)animated
{
 [super viewWillAppear:animated];
    
    [self createTableView];

   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//
    [self costumNavigation];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"拼命加载中";
        [self loaddata];

//    self.view.backgroundColor = [UIColor redColor];
    
    
    
}
#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"工地列表";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    

}

-(void)onback
{
    [_hud hideAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

-(RequsetManager *)request
{

    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    return _request;
}

-(NSMutableArray *)dataSource
{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}


#pragma mark - 加载数据
-(void)loaddata
{
    [self.dataSource removeAllObjects];
       [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=khList&username=%@",self.userName] parameters:nil complicate:^(BOOL success, NSString * object) {
        NSLog(@"555555_____%@___555555",object);
        if (success) {
            
                NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            
            
                //                NSLog(@"555555");
                
                
                NSData * data = [NSData dataWithData:[hh dataUsingEncoding:NSUTF8StringEncoding]];
            
//            NSString * path = [[NSBundle mainBundle]pathForResource:@"xml1" ofType:@"xml"];
            // 得到文件流
//            NSData * data = [NSData dataWithContentsOfFile:path];
            // 得到文档
            GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
            // 得到xml的根节点（如果得到节点的值，会得到所有的子节点的值）
            GDataXMLElement * root = document.rootElement;
//                NSLog(@"%@=%@", root.name, root.stringValue);
            // 得到一级节点
            
            
            
            
            NSArray * firstElementArr = root.children;
            
            
            for (GDataXMLNode * thirdNode in firstElementArr) {
                NSLog(@"%@=%@", thirdNode.name, thirdNode.stringValue);
            }

            
            
            int j = 9;
            for (NSInteger i = 0; i<=firstElementArr.count/9-1; i++) {
                
                MaterialModel *model = [[MaterialModel alloc]init];
//                
//                khbh=0021006
//                khxm=钱程
//                fwdz=海淀区东南小区
//                sjs=朱文亚
//                zjxm=伊利超
//                sgdmc=刘其
                
                
                model.khbh = [firstElementArr[0+j*i] stringValue];
                model.khxm = [firstElementArr[1+j*i] stringValue];
                model.fwdz = [firstElementArr[2+j*i] stringValue];
                model.sjs = [firstElementArr[3+j*i] stringValue];
                model.zjxm = [firstElementArr[4+j*i] stringValue];
                model.sgdmc = [firstElementArr[5+j*i] stringValue];
               
                
                
                model.bjjbmc = [firstElementArr[6+j*i] stringValue];
                model.tcmc = [firstElementArr[7+j*i] stringValue];
                model.sgzt = [firstElementArr[8+j*i] stringValue];
                [self.dataSource addObject:model];
                
                
               
                [self.tableView reloadData];
                
            }
           
            
             NSLog(@"++++++++++++%ld",self.dataSource.count);
             [_hud hideAnimated:YES];
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    
    
    
}





#pragma mark - 创建tableView

-(void)createTableView
{

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.rowHeight = 160;
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)]];
//    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - 实现tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//    NSLog(@"++++++=====%ld",self.dataSource.count);

    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BuyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.row];
    
    [cell.seeDetailbtn addTarget:self action:@selector(seeOnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.buybtn addTarget:self action:@selector(buyOnclick:) forControlEvents:UIControlEventTouchUpInside];
    cell.seeDetailbtn.tag = indexPath.row;
    cell.buybtn.tag = indexPath.row;
    cell.buybtn.tag = indexPath.row;
    cell.layer.borderColor = [[UIColor blackColor]CGColor];
    cell.layer.borderWidth = 1;

    return cell;
}

#pragma mark - 查看详情
-(void)seeOnclick:(UIButton *)Button
{
    
    NSLog(@"%ld",Button.tag);
    BuildDetailViewController *build = [[BuildDetailViewController alloc]init];
    build.khbh = [self.dataSource[Button.tag] khbh];
    build.khdz = [self.dataSource[Button.tag] fwdz];
    build.userName = self.userName;
    [self.navigationController pushViewController:build animated:NO];
}

#pragma mark - 材料下单
-(void)buyOnclick:(UIButton *)Button
{
    
    NSLog(@"%ld",Button.tag);
    MaterialsListViewController *mater = [[MaterialsListViewController alloc]init];
    mater.panduan = @"yes";
    mater.userName = self.userName;
    mater.khdz = [self.dataSource[Button.tag] fwdz];
    mater.model = self.dataSource[Button.tag];
    [self.navigationController pushViewController:mater animated:NO];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [self.tableView removeFromSuperview];
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (tableView == self.tableView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
        return view;
    }else{
    
    
        return nil;
    }
    
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
