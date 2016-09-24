//
//  BuyListViewController.m
//  ForemanAPP
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyListViewController.h"

#import "MaterialsListViewController.h"

#import "RequsetManager.h"

#import "BuyListTableViewCell.h"

#import "GDataXMLNode.h"

#import "BuildModel.h"

#import "BuyListDetailViewController.h"

#import "MBProgressHUD.h"

@interface BuyListViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    MBProgressHUD *_hud;
    
}
@property (nonatomic,strong)UITableView *tableView;


@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,strong)RequsetManager *request;
@end

@implementation BuyListViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self createTabelView];
     [self loaddata];
    [self costumNavigation];
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"拼命加载中";

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)createTabelView
{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuyListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.rowHeight = 64;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}

#pragma mark - 加载数据
-(void)loaddata
{
    [self.dataSource removeAllObjects];
    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=getXsd&lrr=%@",self.userName] parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            [_hud hideAnimated:YES];
            NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            //                NSLog(@"555555_____%@___555555",hh);
            
            //                NSLog(@"555555");
            
            NSData * data = [NSData dataWithData:[hh dataUsingEncoding:NSUTF8StringEncoding]];
            GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
            // 得到xml的根节点（如果得到节点的值，会得到所有的子节点的值）
            GDataXMLElement * root = document.rootElement;
            //                NSLog(@"%@=%@", root.name, root.stringValue);
            // 得到一级节点
            NSArray * firstElementArr = root.children;
            for (GDataXMLElement * firstElement in firstElementArr) {
                
                
                // 得到二级节点
                NSArray * secondElementArr = firstElement.children;
                
                
                
                int j = 5;
                for (NSInteger i = 0; i<=secondElementArr.count/5-1; i++) {
                    
                    
                    BuildModel *model = [[BuildModel alloc]init];
                    
                    
                    //                            cldh;//材料单号
                    //                            shzt;//审核状态
                    //                            lrsj;//录入时间
                    //                            clmx;//材料细明
                    
                    //                            psph=P002257016001
                    //                            2016-06-07 10:48:27.171 ForemanAPP[2190:60384] psdzt=等待审核
                    //                            2016-06-07 10:48:27.172 ForemanAPP[2190:60384] lrrq=2016-06-03
                    
                    //xsph=FX011500012
                    //xszsl=20.0
                    //xszje=12.0
                    //xsdzt=等待审核
                    //lrsj=2015-11-1200:00
                    
                    
                    model.xsph = [secondElementArr[0+j*i] stringValue];
                    model.xszsl = [secondElementArr[1+j*i] stringValue];
                    model.xszje = [secondElementArr[2+j*i] stringValue];
                    model.xsdzt = [secondElementArr[3+j*i] stringValue];
                    model.xsdztSJ = [secondElementArr[4+j*i] stringValue];
                    [self.dataSource addObject:model];
                    
                    
                }
                [self.tableView reloadData];
                for (GDataXMLElement * secondElement in secondElementArr) {
                        NSLog(@"$$$$$$$$$$$%@=%@", secondElement.name, secondElement.stringValue);
                    if ([secondElement.name isEqualToString:@"row"]) {
                        // 得到三级节点
                        NSArray * thirdElementArr = secondElement.children;
                        for (GDataXMLElement * thirdElement in thirdElementArr) {
                            //                                    NSLog(@"%@", thirdElement.name);
                            
                            NSLog(@"%@=%@", thirdElement.name, thirdElement.stringValue);
                            NSArray * thirdAttributeArr = thirdElement.attributes;
                            for (GDataXMLNode * thirdNode in thirdAttributeArr) {
                                //                                                NSLog(@"%@=%@", thirdNode.name, thirdNode.stringValue);
                            }
                        }
                    }else if ([secondElement.name isEqualToString:@"row2"]) {
                        // 得到三级节点
                        NSArray * thirdElementArr = secondElement.children;
                        for (GDataXMLElement * thirdElement in thirdElementArr) {
                            //                            NSLog(@"-------%@=%@", thirdElement.name, thirdElement.stringValue);
                            
                            NSArray * thirdAttributeArr = thirdElement.attributes;
                            for (GDataXMLNode * thirdNode in thirdAttributeArr) {
                                NSLog(@"-------%@=%@", thirdNode.name, thirdNode.stringValue);                            }
                        }
                    }
                    else{
                        //                        NSLog(@"%@=%@", secondElement.name, secondElement.stringValue);
                    }
                }
            }
 
            
                  }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    
    
    
    
    
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


#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"销售单列表";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"录入" style:UIBarButtonItemStylePlain target:self action:@selector(onClick)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
}

-(void)onClick
{

    MaterialsListViewController *mater = [[MaterialsListViewController alloc]init];
    mater.userName = self.userName;
    [self.navigationController pushViewController:mater animated:NO];
}

-(void)onback
{
    
    [_hud hideAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark - tableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BuyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    BuyListDetailViewController *detail = [[BuyListDetailViewController alloc]init];
    detail.model = self.dataSource[indexPath.row];
    detail.userName = self.userName;
    [self.navigationController pushViewController:detail animated:NO];
    
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
