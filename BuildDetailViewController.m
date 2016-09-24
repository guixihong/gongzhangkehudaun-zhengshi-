//
//  BuildDetailViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuildDetailViewController.h"


#import "BuildTableViewCell.h"


#import "RequsetManager.h"


#import "GDataXMLNode.h"

#import "BuildModel.h"

#import "MBProgressHUD.h"

#import "DetailViewController.h"

@interface BuildDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *_hud;
    
}
@property (weak, nonatomic) IBOutlet UILabel *khxm;
@property (weak, nonatomic) IBOutlet UILabel *mykhbh;
@property (weak, nonatomic) IBOutlet UILabel *mysjgj;
@property (weak, nonatomic) IBOutlet UILabel *mykgrq;
@property (weak, nonatomic) IBOutlet UILabel *mybjjb;
@property (weak, nonatomic) IBOutlet UILabel *mytcmc;
@property (weak, nonatomic) IBOutlet UILabel *myfwdz;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,strong)RequsetManager *request;

@end

@implementation BuildDetailViewController


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self costumNavigation];
    [self createLabels];
    [self RegisterTableView];
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"拼命加载中";
    [self.view addSubview:_hud];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.navigationController.navigationBar setTranslucent:NO];
    
NSLog(@"____++____%@",self.khdz);
    
    
}



-(RequsetManager *)request
{

    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    return _request;
    
}

#pragma mark - 设置导航栏
-(void)costumNavigation

{

    self.title = @"房屋详细信息";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    
}

-(void)onback
{
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 创建Labels
-(void)createLabels
{

    [self.dataSource removeAllObjects];

    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=getKhxx&khbh=%@",self.khbh] parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            [_hud hideAnimated:YES];
//            NSLog(@"object------%@-------object",object);
            
//            
//            NSString *hh = [[[[[[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""] stringByReplacingOccurrencesOfString:@"<row2>" withString:@""] stringByReplacingOccurrencesOfString:@"</row2>" withString:@""] stringByReplacingOccurrencesOfString:@"<row1>" withString:@""] stringByReplacingOccurrencesOfString:@"</row1>" withString:@""];
            
            
            NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            
                            NSLog(@"555555_____%@___555555",hh);
            
            //                NSLog(@"555555");
            
            //
            //
            NSData * data = [NSData dataWithData:[hh dataUsingEncoding:NSUTF8StringEncoding]];
            GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
            // 得到xml的根节点（如果得到节点的值，会得到所有的子节点的值）
            GDataXMLElement * root = document.rootElement;
//                NSLog(@"%@=%@", root.name, root.stringValue);
            // 得到一级节点
            NSArray * firstElementArr = root.children;
            for (GDataXMLElement * firstElement in firstElementArr) {
//                NSLog(@"+++++++%@=%@", firstElement.name, firstElement.stringValue);
                
                
                
//                            NSArray *titles = @[[NSString stringWithFormat:@"房屋地址信息: %@",[firstElementArr[2] stringValue]],@"客户姓名: 魏立宇",@"客户编号: 0020020",@"设计管家: 桂锡鸿",@"合同开工日期: 2016-04-04"];
                
                
         
                self.myfwdz.adjustsFontSizeToFitWidth = YES;
                self.mykhbh.text = [NSString stringWithFormat:@"施工状态: %@",[firstElementArr[10] stringValue]];
                self.khxm.text = [NSString stringWithFormat:@"客户姓名: %@",[firstElementArr[1] stringValue]];
                     self.myfwdz.text = [NSString stringWithFormat:@"房屋地址信息: %@",[firstElementArr[2] stringValue]];
                self.mysjgj.text = [NSString stringWithFormat:@"设计管家: %@",[firstElementArr[3] stringValue]];
                self.mykgrq.text = [NSString stringWithFormat:@"开工日期: %@",[firstElementArr[7] stringValue]];
                self.mybjjb.text = [NSString stringWithFormat:@"报价级别: %@",[firstElementArr[8] stringValue]];
                self.mytcmc.text = [NSString stringWithFormat:@"套餐名称: %@",[firstElementArr[9] stringValue]];
                
                
            
            
                
                
//                
//                            NSInteger j = 0;
//                            for (NSInteger i = 0; i < 6; i ++) {
//                                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 40 * j, self.view.bounds.size.width - 30, 40)];
//                                label.text = titles[i];
//                                label.font = [UIFont systemFontOfSize:13];
//                                label.numberOfLines = 0;
//                                j++;
//                                [self.view addSubview:label];
//                            }
//
//                
                
                
                
                
                
                // 得到二级节点
                NSArray * secondElementArr = firstElement.children;
                for (GDataXMLElement * secondElement in secondElementArr) {
//                                NSLog(@"%@=%@", secondElement.name, secondElement.stringValue);
                    if ([secondElement.name isEqualToString:@"row1"]) {
                        // 得到三级节点
                        NSArray * thirdElementArr = secondElement.children;
                        
                        int j = 4;
                        for (NSInteger i = 0; i<=thirdElementArr.count/4-1; i++) {
                        BuildModel *model = [[BuildModel alloc]init];
//                            cldh;//材料单号
//                            shzt;//审核状态
//                            lrsj;//录入时间
//                            clmx;//材料细明
                            
//                            psph=P002257016001
//                            2016-06-07 10:48:27.171 ForemanAPP[2190:60384] psdzt=等待审核
//                            2016-06-07 10:48:27.172 ForemanAPP[2190:60384] lrrq=2016-06-03
                            
                            
                            model.cldh = [thirdElementArr[0+j*i] stringValue];
                            model.shzt = [thirdElementArr[1+j*i] stringValue];
                            model.lrsj = [thirdElementArr[2+j*i] stringValue];
                            model.clmx = [thirdElementArr[3+j*i] stringValue];
                            [self.dataSource addObject:model];
                            
                            
                        }
                        [self.tableView reloadData];
                        
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

            
            
            
            
//
//            
//            NSData * data = [NSData dataWithData:[hh dataUsingEncoding:NSUTF8StringEncoding]];
//            
//            //            NSString * path = [[NSBundle mainBundle]pathForResource:@"xml1" ofType:@"xml"];
//            // 得到文件流
//            //            NSData * data = [NSData dataWithContentsOfFile:path];
//            // 得到文档
//            GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithData:data options:kNilOptions error:nil];
//            // 得到xml的根节点（如果得到节点的值，会得到所有的子节点的值）
//            GDataXMLElement * root = document.rootElement;
//            //                NSLog(@"%@=%@", root.name, root.stringValue);
//            // 得到一级节点
//            
//            
//            
//            
//            NSArray * firstElementArr = root.children;
//            
//            
//            for (GDataXMLNode * thirdNode in firstElementArr) {
//                NSLog(@"%@=%@", thirdNode.name, thirdNode.stringValue);
//            }
//            
////            NSArray *titles = @[[NSString stringWithFormat:@"房屋地址信息: %@",[firstElementArr[2] stringValue]],@"客户姓名: 魏立宇",@"客户编号: 0020020",@"设计管家: 桂锡鸿",@"合同开工日期: 2016-04-04"];
//            
//          NSArray *titles = @[[NSString stringWithFormat:@"房屋地址信息: %@",[firstElementArr[2] stringValue]],[NSString stringWithFormat:@"客户姓名: %@",[firstElementArr[1] stringValue]],[NSString stringWithFormat:@"客户编号: %@",[firstElementArr[0] stringValue]],[NSString stringWithFormat:@"设计管家: %@",[firstElementArr[3] stringValue]],[NSString stringWithFormat:@"合同开工日期: %@",[firstElementArr[7] stringValue]]];
//            
//            
//            
//            NSInteger j = 0;
//            for (NSInteger i = 0; i < 5; i ++) {
//                
//                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 40 * j, self.view.bounds.size.width - 30, 40)];
//                label.text = titles[i];
//                label.font = [UIFont boldSystemFontOfSize:15];
//                label.numberOfLines = 0;
//                j++;
//                [self.view addSubview:label];
//            }
//
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];

    
    
    
    
    
    
    
  }


-(NSMutableArray *)dataSource
{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - 注册tableView
-(void)RegisterTableView
{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 233,self.view.bounds.size.width, 5)];
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 238, self.view.bounds.size.width, self.view.bounds.size.height - 243) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"BuildTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.rowHeight = 80;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - 实现tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BuildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DetailViewController *detail = [[DetailViewController alloc]init];
    BuildModel *model = self.dataSource[indexPath.row];
    detail.khdz = self.khdz;
    detail.userName = self.userName;
    detail.khbh = self.khbh;
    detail.myModel = model;
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
