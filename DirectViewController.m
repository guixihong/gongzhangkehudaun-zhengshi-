//
//  DirectViewController.m
//  ForemanAPP
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "DirectViewController.h"


#import "MaterialsListTableViewCell.h"


#import "SearchViewController.h"


#import "BuyBoxViewController.h"


#import "MaterialsListModel.h"

#import "CoredataManager.h"


#import "RequsetManager.h"

#import "GDataXMLNode.h"

#import "matermyModel.h"

#import "SureOrderViewController.h"

#import "myCollectionViewCell.h"

#import "MBProgressHUD.h"

#import "MyCoredataManager.h"

@interface DirectViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TYFSencondViewControllerDelegate>

{
    int _tags;
    MBProgressHUD *_hud;
    
}



@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)UITableView *tableView;



@property (nonatomic,strong)NSMutableArray *dataSource;


@property (strong,nonatomic)UITextField *textField;

@property (nonatomic,strong)NSMutableArray *mydataSource;
@property (strong,nonatomic)UITextField *mytextField;


@property (strong,nonatomic)UIView *myView;

@property (strong,nonatomic)UIView *YouView;

@property (strong,nonatomic)RequsetManager *request;

@property (strong,nonatomic)UICollectionView *collectionView;


@property (strong,nonatomic)NSMutableArray *ArrayCollection;

@property (strong,nonatomic)UIView *mmyView;

@property (strong,nonatomic)NSString *guanjianzi;//关键字

@property (strong,nonatomic)UILabel *HHView;

@property (nonatomic,strong)UIView *IView;

@end

@implementation DirectViewController

-(void)viewWillAppear:(BOOL)animated

{
    
    
    [super viewWillAppear:animated];
    //     NSLog(@"___________++++++++%@++++++",self.userName);
    
    //    NSLog(@"############%@",self.guanjianzi);
    
    self.navigationController.navigationBarHidden = NO;
    [self costumNavigation];
   
    [self loadBaseData];//加载BaseTableView数据
    
   
    [self registerTableView];
    [self.mydataSource removeAllObjects];
    [self.dataSource removeAllObjects];
    if (self.guanjianzi.length == 0) {
        [self loadData:@"板材类"];
    }else{
        [self myloadData:self.guanjianzi];
        
    }
    
    
    //        [self loadData:[@"板材类" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    //
    //    [self.BaseTableVIew scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES]; //滚动到第5行
    //
    //    [self.BaseTableVIew selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionTop]; //选中第5行
    
    
    [self.tableView reloadData];
    [self registerTableView];
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"拼命加载中";
    [self.view addSubview:_hud];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    //    [self loadData:[@"板材类" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   
    [self createView];
    //    [self createNotification];
}



//#pragma mark - 通知
//-(void)createNotification
//{
//    //添加事件
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNotifi:) name:@"ON" object:nil];
//    //第三个参数name:我要监听通知的名字
//    //第四个参数object:监听的对象,如果传nil,监听任何对象
//}
//
//-(void)receiveNotifi:(NSNotification *)nf
//{
//    NSLog(@"~~~~~~~~~%@~~~", nf.userInfo);
//
//    [@"U6842" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
////    UISwitch *sw = (id)[self.view viewWithTag:1];
////    sw.on = [nf.userInfo[@"ON"] boolValue];
//}



-(RequsetManager *)request
{
    
    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    return _request;
}

//#pragma mark - 点击搜索
- (IBAction)onSearch:(UIButton *)sender {
    
    SearchViewController *search = [[SearchViewController alloc]init];
    search.delegate = self;
    [self.navigationController pushViewController:search animated:NO];
    
}

#pragma mark - 实现协议上的方法
-(void)setOn:(NSString *)isOn
{
    //找到控件
    //    NSLog(@"++++++*****++_____%@",isOn);
    self.guanjianzi = isOn;
    //    [self loadData:isOn];
}

-(NSMutableArray *)ArrayCollection
{
    
    if (_ArrayCollection == nil) {
        _ArrayCollection = [NSMutableArray array];
    }
    return _ArrayCollection;
}

#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    NSInteger j = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        j = j + [model.clsl integerValue];
    }
    self.title = [NSString stringWithFormat:@"材料下单(%ld)",j];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"shopcart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(buyBox)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
}

#pragma mark - 点击下拉框

//- (IBAction)onClickXLK:(UIButton *)sender {
//
//
//     NSLog(@"4567890[");
//    [self createCollectionView];
//}



#pragma mark - 创建下拉框显示的内容
-(void)createView
{
    
    
    [self.request requestWithUrl:@"http://111.200.41.13:8090/sgdmm?cldlmc=%E6%9D%BF%E6%9D%90%E7%B1%BB&funname=clbmEj" parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            //                            NSLog(@"555555_____%@___555555",hh);
            
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
            
            
            NSMutableArray *arrayData = [NSMutableArray array];
            
            NSArray * firstElementArr = root.children;
            int j = 2;
            for (NSInteger i = 0; i<=firstElementArr.count/2-1; i++) {
                
                //
                //                clbm=FC00000000031
                //                clmc=洗衣机龙头（摩恩）
                //                xh=9017
                //                gg=
                //                jldwbm=套
                matermyModel *model = [[matermyModel alloc]init];
                
                
                model.clxlbm = [firstElementArr[0+j*i] stringValue];
                model.clxlmc = [firstElementArr[1+j*i] stringValue];
                [self.ArrayCollection addObject:model];
                
            }
            
            
            //            NSLog(@"----------%ld",self.ArrayCollection.count);
            
            [self.collectionView reloadData];
            
            for (GDataXMLNode * thirdNode in firstElementArr) {
                //                NSLog(@">>>>>>>>%@=%@", thirdNode.name, thirdNode.stringValue);
            }
            
            
            
            
            
            //              NSLog(@"_________________%ld",self.mydataSource.count);
            //            for (NSInteger i = 0; i < self.mydataSource.count; i ++) {
            //
            //
            //
            //            }
            
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    
    
}

-(void)onClick10
{
    
    NSLog(@"56789");
    
    [self registerTableView];
    [self loadData:@"板材类"];
    
    [self.tableView reloadData];
    [self.YouView removeFromSuperview];
}


-(void)buyBox
{
    
    
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"确定提交到订单" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    aler.tag = 888;
    [aler show];
    [self.view addSubview:aler];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
        if ([model.clsl isEqualToString:@"0"]) {
            [CoredataManager deleteModel:model];
        }
    }
    NSString *juset;
    if (buttonIndex == 0) {
        
        for (NSString *ss in self.dataSource) {
            if ([ss isEqualToString:@"0"] == 0) {
                //                BuyBoxViewController *box = [[BuyBoxViewController alloc]init];
                //                box.userName = self.userName;
                //                [self.navigationController pushViewController:box animated:NO];
                
                
                juset = @"1";
            }
        }
        
        //        if ([juset isEqualToString:@"1"]) {
        //
        //            if ([self.panduan isEqualToString:@"yes"]) {
        ////            SureOrderViewController *sure = [[SureOrderViewController alloc]init];
        ////
        ////            sure.panduan = @"yes";
        ////            sure.userName = self.userName;
        ////            sure.model = self.model;
        ////
        ////            [self.navigationController pushViewController:sure animated:NO];
        //
        //                BuyBoxViewController *box = [[BuyBoxViewController alloc]init];
        //                box.panduan = @"yes";
        //                box.khdz = self.khdz;
        //                box.userName = self.userName;
        //                box.model = self.model;
        //                [self.navigationController pushViewController:box animated:NO];
        //
        //            }else{
        //
        //                BuyBoxViewController *box = [[BuyBoxViewController alloc]init];
        //                box.userName = self.userName;
        //                [self.navigationController pushViewController:box animated:NO];
        //            }
        //
        //        }else{
        //
        //            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"请选择材料及数量" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
        //            [aler show];
        //            [self.view addSubview:aler];
        //
        //
        //        }
        //
        //
        //
        //    }else{
        //
        //         [alertView removeFromSuperview];
        //    }
        //
        
        if ([CoredataManager findAppALL].count != 0) {
            
            if ([self.panduan isEqualToString:@"yes"]) {
                //            SureOrderViewController *sure = [[SureOrderViewController alloc]init];
                //
                //            sure.panduan = @"yes";
                //            sure.userName = self.userName;
                //            sure.model = self.model;
                //
                //            [self.navigationController pushViewController:sure animated:NO];
                
                BuyBoxViewController *box = [[BuyBoxViewController alloc]init];
                box.panduan = @"yes";
                box.khdz = self.khdz;
                box.userName = self.userName;
                box.model = self.model;
                [self.navigationController pushViewController:box animated:NO];
                
            }else{
                
                BuyBoxViewController *box = [[BuyBoxViewController alloc]init];
                box.userName = self.userName;
                [self.navigationController pushViewController:box animated:NO];
            }
            
        }else{
            
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"请选择材料及数量" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
            [aler show];
            [self.view addSubview:aler];
            
            
        }
        
        
        
    }else{
        
        [alertView removeFromSuperview];
    }
    
    
    
    
    
}







-(void)registerTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"MaterialsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    self.tableView.rowHeight = 158;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 380)];
    
}

-(NSMutableArray *)dataSource
{
    
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


-(NSMutableArray *)mydataSource
{
    
    if (_mydataSource == nil) {
        _mydataSource = [NSMutableArray array];
    }
    return _mydataSource;
}





-(void)loadBaseData
{
    
    [self.request requestWithUrl:@"http://111.200.41.13:8090/sgdmm?funname=clbmYj" parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            //                NSLog(@"555555_____%@___555555",hh);
            
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
            
            int j = 2;
            for (NSInteger i = 0; i<=firstElementArr.count/2-1; i++) {
                
                MaterialsListModel *model = [[MaterialsListModel alloc]init];
                //
                //                khbh=0021006
                //                khxm=钱程
                //                fwdz=海淀区东南小区
                //                sjs=朱文亚
                //                zjxm=伊利超
                //                sgdmc=刘其
                
                
                model.cldlbm = [firstElementArr[0+j*i] stringValue];
                model.cldlmc = [firstElementArr[1+j*i] stringValue];
                
                
            }
            
            for (GDataXMLNode * thirdNode in firstElementArr) {
                //                NSLog(@"%@=%@", thirdNode.name, thirdNode.stringValue);
            }
            
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    
}


-(void)onback
{
    
    
    
    [_hud hideAnimated:YES];
    [self.navigationController popViewControllerAnimated:NO];
    for (matermyModel *model in [CoredataManager findAppALL]) {
        [CoredataManager deleteModel:model];
    }
    for (matermyModel *model in [MyCoredataManager findAppALL]) {
        [MyCoredataManager deleteModel:model];
    }
    
}

-(void)myloadData:(NSString *)clmc;
{
    
    [self.mydataSource removeAllObjects];
    [self.dataSource removeAllObjects];
    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?clmc=%@&xh=&clbm=&gg=&funname=selectClbm&lrr=%@",[clmc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.userName] parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            [_hud hideAnimated:YES];
            //            NSLog(@"!!!%@!!!",object);
            
            if ([object isEqualToString:@"0"]) {
                
                self.HHView = [[UILabel alloc]init];
                self.HHView.backgroundColor = [UIColor grayColor];
                self.HHView.layer.cornerRadius = 5;
                self.HHView.layer.masksToBounds = YES;
                self.HHView.text = @"暂无数据";
                self.HHView.textColor = [UIColor whiteColor];
                self.HHView.textAlignment = NSTextAlignmentCenter;
                self.HHView.frame = CGRectMake(0, 0, 100, 50);
                self.HHView.center = self.view.center;
                [self.view addSubview:self.HHView];
                [self createTime];
            }else{
                
                NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
                //                NSLog(@"555555_____%@___555555",hh);
                
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
                int j = 7;
                for (NSInteger i = 0; i<=firstElementArr.count/7-1; i++) {
                    
                    
                    //                clbm=FC00000000031
                    //                clmc=洗衣机龙头（摩恩）
                    //                xh=9017
                    //                gg=
                    //                jldwbm=套
                    matermyModel *model = [[matermyModel alloc]init];
                    
                    [self.dataSource addObject:@"0"];//数量
                    
                    model.clbm = [firstElementArr[0+j*i] stringValue];
                    model.clmc = [firstElementArr[1+j*i] stringValue];
                    model.xh = [firstElementArr[2+j*i] stringValue];
                    model.gg = [firstElementArr[3+j*i] stringValue];
                    model.jldwbm = [firstElementArr[4+j*i] stringValue];
                    model.clsl = self.dataSource[i];
                    model.xsj = [firstElementArr[5+j*i] stringValue];
                    model.cbj = [firstElementArr[6+j*i] stringValue];
                    [self.mydataSource addObject:model];
                    
                }
                
                [self.tableView reloadData];
                
                
                
                for (GDataXMLNode * thirdNode in firstElementArr) {
                    //                NSLog(@">>>>>>>>%@=%@", thirdNode.name, thirdNode.stringValue);
                }
                
                
                
                
                
                //              NSLog(@"_________________%ld",self.mydataSource.count);
                //            for (NSInteger i = 0; i < self.mydataSource.count; i ++) {
                //
                //
                //
                //            }
                
                
            }
            
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    
    //    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=clbmEj&cldlmc=%@",[cldlbm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil complicate:^(BOOL success, id object) {
    //        if (success) {
    //        }else{
    //            NSLog(@"============%@",object);
    //        }
    //    }];
    //
    //
    //
    //
    //
    //     [self.tableView reloadData];
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





-(void)loadData:(NSString *)cldlbm;
{
    
    [self.mydataSource removeAllObjects];
    [self.dataSource removeAllObjects];
    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=clbmSj&cldlmc=%@&lrr=%@",[cldlbm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],self.userName] parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            [_hud hideAnimated:YES];
            //            NSLog(@"_______%@________",object);
            
            if ([object isEqualToString:@"0"]) {
                
                self.HHView = [[UILabel alloc]init];
                self.HHView.backgroundColor = [UIColor grayColor];
                self.HHView.layer.cornerRadius = 5;
                self.HHView.layer.masksToBounds = YES;
                self.HHView.text = @"暂无数据";
                self.HHView.textColor = [UIColor whiteColor];
                self.HHView.textAlignment = NSTextAlignmentCenter;
                self.HHView.frame = CGRectMake(0, 0, 100, 50);
                self.HHView.center = self.view.center;
                [self.view addSubview:self.HHView];
                [self createTime];
            }else{
                
                NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
                //                NSLog(@"555555_____%@___555555",hh);
                
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
                int j = 7;
                for (NSInteger i = 0; i<=firstElementArr.count/7-1; i++) {
                    
                    //
                    //                clbm=FC00000000031
                    //                clmc=洗衣机龙头（摩恩）
                    //                xh=9017
                    //                gg=
                    //                jldwbm=套
                    matermyModel *model = [[matermyModel alloc]init];
                    
                    //                    [self.dataSource addObject:@"0"];//数量
                    
                    model.clbm = [firstElementArr[0+j*i] stringValue];
                    model.clmc = [firstElementArr[1+j*i] stringValue];
                    model.xh = [firstElementArr[2+j*i] stringValue];
                    
                    if ([MyCoredataManager returnCount:model] > 0) {
                        [self.dataSource addObject:[MyCoredataManager Getclsl:model]];
                    }else{
                        
                        [self.dataSource addObject:@"0"];
                        
                    }
                    
                    model.gg = [firstElementArr[3+j*i] stringValue];
                    model.jldwbm = [firstElementArr[4+j*i] stringValue];
                    model.clsl = self.dataSource[i];
                    model.xsj = [firstElementArr[5+j*i] stringValue];
                    model.cbj = [firstElementArr[6+j*i] stringValue];
                    [self.mydataSource addObject:model];
                    
                }
                
                [self.tableView reloadData];
                
                
                
                for (GDataXMLNode * thirdNode in firstElementArr) {
                    //                NSLog(@">>>>>>>>%@=%@", thirdNode.name, thirdNode.stringValue);
                }
                
                
                
                
                
                //              NSLog(@"_________________%ld",self.mydataSource.count);
                //            for (NSInteger i = 0; i < self.mydataSource.count; i ++) {
                //
                //
                //
                //            }
                
                
            }
            
            
        }else{
            
            NSLog(@"%@",object);
            
        }
    }];
    
    //    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?funname=clbmEj&cldlmc=%@",[cldlbm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] parameters:nil complicate:^(BOOL success, id object) {
    //        if (success) {
    //        }else{
    //            NSLog(@"============%@",object);
    //        }
    //    }];
    //
    //
    //
    //
    //
    //     [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
        
        return self.mydataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
        MaterialsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
        
        
        cell.model = self.mydataSource[indexPath.row];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor grayColor]CGColor];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.quantitytextField.text = self.dataSource[indexPath.row];
        cell.quantitytextField.tag = indexPath.row;
        cell.quantitytextField.delegate = self;
        
        [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField:) forControlEvents:UIControlEventEditingDidBegin];
        [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField1:) forControlEvents:UIControlEventEditingDidEnd];
        
        if ([cell.quantitytextField.text integerValue] < 1) {
            cell.quantitytextField.backgroundColor = [UIColor whiteColor];
        }else{
            
            cell.quantitytextField.backgroundColor = [UIColor grayColor];
        }
        
        
        
        
        
        cell.quantitytextField.layer.cornerRadius = 3;
        cell.quantitytextField.layer.masksToBounds = YES;
        self.textField = cell.quantitytextField;
        [cell.add addTarget:self action:@selector(onAdd:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.unadd addTarget:self action:@selector(onUnadd:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.add.tag = indexPath.row;
        cell.unadd.tag = indexPath.row;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        return cell;
        
   
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
//    if (tableView == self.BaseTableVIew) {
//        //        [self registerTableView];
//        
//        //        for (matermyModel *model in [CoredataManager findAppALL]) {
//        //            [CoredataManager deleteModel:model];
//        //        }
//        [self loadData:[self.BaseDataSource[indexPath.row]cldlmc]];
//        [self.tableView reloadData];
//        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        _hud.mode = MBProgressHUDModeIndeterminate;
//        _hud.labelText = @"拼命加载中";
//        
//        
//    }else{
//        
//        NSLog(@"%@",[self.mydataSource[indexPath.row] clbm]);
//    }
    
}



-(void)onClickquantitytextField:(UITextField *)textField
{
    
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES]; //滚动到第5行
    
    [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionTop]; //选中第5行
    
}
-(void)onClickquantitytextField1:(UITextField *)textField
{
    
    textField.layer.borderWidth = 0;
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:textField.tag inSection:0];
    
    
    
    
    [self.tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionMiddle animated:YES]; //滚动到第5行
    
    [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle]; //选中第5行
    
    
    
    MaterialsListModel *model = self.mydataSource[textField.tag];
    
    if ([textField.text hasPrefix:@"0"]) {
        model.clsl = [textField.text componentsSeparatedByString:@"0"][1];
    }else{
        
        model.clsl = textField.text;//更新clsl
    }
    
    
    
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    
    
    if ([CoredataManager returnCount:model] > 0) {
        [CoredataManager updataData:self.mydataSource[textField.tag]];//更新数据
    }else{
        
        [CoredataManager insertModel:self.mydataSource[textField.tag]];//插入数据
    }
    
    
    
    
    
    
}


-(void)onAdd:(UIButton *)btn
{
    
    
    [self.textField resignFirstResponder];
    NSInteger i = [self.dataSource[btn.tag] integerValue];
    
    i = i + 1;
    
    [self.dataSource replaceObjectAtIndex:btn.tag withObject:[NSString stringWithFormat:@"%ld",i]];
    //一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    
    matermyModel *model = self.mydataSource[btn.tag];
    model.clsl = self.dataSource[btn.tag];//更新clsl
    
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    
    
    if ([CoredataManager returnCount:model] > 0) {
        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
        [MyCoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
        
    }else{
        
        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
        [MyCoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
        
    }
    
    NSInteger j = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        j = j+[model.clsl integerValue];
    }
    self.title = [NSString stringWithFormat:@"材料下单(%ld)",j];
    
    
}

-(void)onUnadd:(UIButton *)btn
{
    [self.textField resignFirstResponder];
    NSInteger i = [self.dataSource[btn.tag] integerValue];
    
    if (i < 1) {
        return;
    }else{
        
        i = i - 1;
    }
    
    
    //    [self.dataSource replaceObjectAtIndex:btn.tag withObject:[NSString stringWithFormat:@"%ld",i]];
    //    //一个cell刷新
    //    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    //
    //    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    //
    //
    //    matermyModel *model = self.mydataSource[btn.tag];
    //    model.clsl = self.mydataSource[btn.tag];//更新clsl
    //
    //    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    //
    //
    //    if ([CoredataManager returnCount:model] > 0) {
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //    }else{
    //
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //    }
    
    [self.dataSource replaceObjectAtIndex:btn.tag withObject:[NSString stringWithFormat:@"%ld",i]];
    //一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:btn.tag inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    
    
    
    matermyModel *model = self.mydataSource[btn.tag];
    model.clsl = self.dataSource[btn.tag];//更新clsl
    
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    
    
    if ([CoredataManager returnCount:model] > 0) {
        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
        [MyCoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    }else{
        
        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
        [MyCoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    }
    
    NSInteger j = 1;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        j = j +[model.clsl integerValue];
    }
    
    j --;
    
    self.title = [NSString stringWithFormat:@"材料下单(%ld)",j];
    
    
}






-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if ([textField.text hasPrefix:@"0"] && textField.text.length > 1) {
        
        
        [self.dataSource replaceObjectAtIndex:textField.tag withObject:[NSString stringWithFormat:@"%@",[textField.text substringFromIndex:1]]];
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:textField.tag inSection:0];
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else if (textField.text.length == 0){
        
        [self.dataSource replaceObjectAtIndex:textField.tag withObject:@"0"];
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:textField.tag inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        
        [self.dataSource replaceObjectAtIndex:textField.tag withObject:[NSString stringWithFormat:@"%@",textField.text]];
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:textField.tag inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
    matermyModel *model = self.mydataSource[textField.tag];
    model.clsl = self.dataSource[textField.tag];//更新clsl
    
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    
    
    if ([CoredataManager returnCount:model] > 0) {
        [CoredataManager updataData:self.mydataSource[textField.tag]];//更新数据
    }else{
        
        [CoredataManager insertModel:self.mydataSource[textField.tag]];//插入数据
    }
    
    
    
    if ([MyCoredataManager returnCount:model] > 0) {
        [MyCoredataManager updataData:self.mydataSource[textField.tag]];//更新数据
    }else{
        
        [MyCoredataManager insertModel:self.mydataSource[textField.tag]];//插入数据
    }
    
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.index = [textField.text integerValue];
    self.IView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.IView.backgroundColor = [UIColor grayColor];
    self.IView.alpha = 0.3;
    [self.view addSubview:self.IView];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    [self.IView removeFromSuperview];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if ([self isPureInt:textField.text] == 1) {
        if ([textField.text integerValue] > 999) {
            //            self.HHView = [[UILabel alloc]init];
            //            self.HHView.backgroundColor = [UIColor grayColor];
            //            self.HHView.layer.cornerRadius = 5;
            //            self.HHView.layer.masksToBounds = YES;
            //            self.HHView.text = @"数量不能超过999";
            //            self.HHView.textColor = [UIColor whiteColor];
            //            self.HHView.textAlignment = NSTextAlignmentCenter;
            //            self.HHView.frame = CGRectMake(0, 0, 250, 50);
            //            CGPoint point = self.view.center;
            //            self.HHView.center = CGPointMake(point.x, point.y - 80);
            //            [self.view addSubview:self.HHView];
            //            [self createTime];
            //
            
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"数量不能超过999" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [aler show];
            [self.view addSubview:aler];
            textField.text = self.dataSource[textField.tag];
            
            
            
            
            
        }else{
            
            
        }
        
    }else{
        textField.text = self.dataSource[textField.tag];
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"只能输入数字" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [aler show];
        [self.view addSubview:aler];
        
    }
    
    [textField resignFirstResponder];
    [self.IView removeFromSuperview];
    
    
    
    NSInteger j = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        j = j+[model.clsl integerValue];
    }
    
    
    
    self.title = [NSString stringWithFormat:@"材料下单(%ld)",j];
    j = 0;
    
    
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.YouView removeFromSuperview];
    [self.mytextField resignFirstResponder];
}


//-(void)viewWillDisappear:(BOOL)animated
//{
//
//    [super viewWillDisappear:animated];
//
////    self.navigationController.navigationBarHidden = YES;
//}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//
//    return [self isPureInt:string];
//}

#pragma mark - 判断是不是整数
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    if (tableView == self.tableView) {
//        UIView *view = [[UIView alloc]init];
//        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 300);
//        return view;
//
//    }else{
//    
//        return nil;
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//
//    [super viewWillDisappear:animated];
//    for (matermyModel *model in [CoredataManager findAppALL]) {
//        [CoredataManager deleteModel:model];
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
