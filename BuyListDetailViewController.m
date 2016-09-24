//
//  BuyListDetailViewController.m
//  ForemanAPP
//
//  Created by mac on 16/6/8.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyListDetailViewController.h"



#import "RequsetManager.h"


#import "GDataXMLNode.h"

#import "MaterialsListTableViewCell.h"

#import "CoredataManager.h"


#import "BuyViewController.h"


#import "MBProgressHUD.h"
@interface BuyListDetailViewController ()<UITableViewDataSource,UITextFieldDelegate>
{
    MBProgressHUD *_hud;
    
}

@property (nonatomic,strong)RequsetManager *request;


@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UILabel *LLabel;

@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,strong)NSMutableArray *mydataSource;

@property (nonatomic,strong)UILabel *HHView;

@property (nonatomic,strong)UIView *IView;

@end

@implementation BuyListDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self registerTableView];
    [self createLabels];
    if ([self.model.xsdzt isEqualToString:@"等待审核"]) {
        
        self.tableView.frame = CGRectMake(0, 160, self.view.bounds.size.width, self.view.bounds.size.height - 145);
    }else{
        [self createButton];
    }
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"拼命加载中";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self costumNavigation];
    [self loadData];

}

-(NSMutableArray *)mydataSource
{
    
    if (_mydataSource == nil) {
        _mydataSource = [NSMutableArray array];
    }
    
    return _mydataSource;
}


-(NSMutableArray *)dataSource
{
    
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(RequsetManager *)request
{
    
    if (_request == nil) {
        _request = [[RequsetManager alloc]init];
    }
    
    return  _request;
}


#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"房屋详细信息";
    //    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    
    if ([self.model.xsdzt isEqualToString:@"未提交"] ) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(onClickBtn)];
       
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    }
    
    
}





#pragma mark - 点击保存

-(void)onClickBtn
{

    
    if (self.dataSource.count != 0) {
        NSMutableString *dates = [[NSMutableString alloc]init];
        
        NSInteger i = 0;
        
        for (matermyModel *model in self.mydataSource) {
            NSString *MyStr = [NSString stringWithFormat:@"%@*%@^",model.clbm,self.dataSource[i]];
            
            
            [dates appendString:MyStr];
            i++;
            
            
        }
        
        
        
        
        NSString *ss =  [[dates substringToIndex:dates.length - 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//去除最后的^并转换URL
        
        NSLog(@"########%@",ss);
        [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsdzt=2&xsph=%@&dates=%@&funname=insertXsdmxs",self.model.xsph,[NSString stringWithFormat:@"%@",ss]] parameters:nil complicate:^(BOOL success, id object) {
            if (success) {
                NSLog(@"%@",object);
                for (matermyModel *model in [CoredataManager findAppALL]) {
                    [CoredataManager deleteModel:model];
                }//删除所有的数
                _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _hud.mode = MBProgressHUDModeIndeterminate;
                _hud.labelText = @"保存成功";
                [self createTime];
                
            }else{
                NSLog(@"%@",object);
                
            }
        }];
        
        
        
        //    BuyViewController *detail = [[BuyViewController alloc]init];
        //    [self.navigationController pushViewController:detail animated:NO];
    }
    
    
    NSLog(@"保存");
    
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
    
    
    [_hud hideAnimated:YES];
}



-(void)onback
{
    [_hud hideAnimated:YES];
    for (matermyModel *model in [CoredataManager findAppALL]) {
        [CoredataManager deleteModel:model];
    }//删除所有的数
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - 创建Button
-(void)createButton
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor colorWithRed:15/256.0 green:135/256.0 blue:206/256.0 alpha:0.8]];
    [button addTarget:self action:@selector(onSureOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}


#pragma mark - 点击提交订单
-(void)onSureOrder
{
    
    
    [self onClickBtn];
    
    
    NSLog(@"&&&&&&&&%@",self.khdz);
    
//    http://111.200.41.13:8090/sgdmm?xsdzt=2&xsph=FX011600038&dates=FC00000000097*9%5EFC00000000098*8&funname=insertXsdmxs
    
    
    if (self.dataSource.count != 0) {
        NSMutableString *dates = [[NSMutableString alloc]init];
        
        NSInteger i = 0;
        
        for (matermyModel *model in self.mydataSource) {
            NSString *MyStr = [NSString stringWithFormat:@"%@*%@^",model.clbm,self.dataSource[i]];
            
            
            [dates appendString:MyStr];
            i++;
            
            
        }

        NSString *ss =  [[dates substringToIndex:dates.length - 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//去除最后的^并转换URL
        
        NSLog(@"########%@",ss);
        [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsdzt=2&xsph=%@&dates=%@&funname=insertXsdmxs",self.model.xsph,[NSString stringWithFormat:@"%@",ss]] parameters:nil complicate:^(BOOL success, id object) {
            if (success) {
                NSLog(@"%@",object);
                for (matermyModel *model in [CoredataManager findAppALL]) {
                    [CoredataManager deleteModel:model];
                }//删除所有的数据
                [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsdzt=1&xsph=%@&lrr=%@&funname=insertXsd",self.model.xsph,self.userName] parameters:nil complicate:^(BOOL success, id object) {
                    if (success) {
                        NSLog(@"%@",object);
                        
                        _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        _hud.mode = MBProgressHUDModeIndeterminate;
                        _hud.labelText = @"提交成功";
                        [self createTime];
                        
                        
                       [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
                        
                    }else{
                        NSLog(@"%@",object);
                        
                    }
                }];

                
                
            }else{
                NSLog(@"%@",object);
                
            }
        }];
        
        
        
        //    BuyViewController *detail = [[BuyViewController alloc]init];
        //    [self.navigationController pushViewController:detail animated:NO];
    }else{
    
        [self.navigationController popViewControllerAnimated:NO];
    }
    
   
}




#pragma  mark - 创建Label
-(void)createLabels
{
//    model.xsph =
//    model.xszsl =
//    model.xszje =
//    model.xsdzt =
//    model.xsdztSJ
    
    NSLog(@"_________%@",_model.xsdztSJ);
    NSArray *titles = @[[NSString stringWithFormat:@"销售单号: %@",self.model.xsph],[NSString stringWithFormat:@"销售状态: %@",self.model.xsdzt],[NSString stringWithFormat:@"录入日期: %@  %@",[[NSMutableString stringWithString:_model.xsdztSJ] substringToIndex:10],[[NSMutableString stringWithString:_model.xsdztSJ] substringFromIndex:10]],@""];
    NSInteger j = 0;
    for (NSInteger i = 0; i < 4; i ++) {
    
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 40 * j, self.view.bounds.size.width - 30, 40)];
        label.font = [UIFont systemFontOfSize:13];
        label.numberOfLines = 0;
        j++;
        label.text = titles[i];
        if (i == 3) {
            label.frame = CGRectMake(0, 40 * 3, self.view.bounds.size.width, 40);
            label.backgroundColor = [UIColor colorWithRed:206.0/255 green:206.0/255 blue:206.0/255 alpha:1];
            self.LLabel = label;
            self.LLabel.font = [UIFont boldSystemFontOfSize:15];
            self.LLabel.textAlignment = NSTextAlignmentCenter;
            self.LLabel.textColor = [UIColor blackColor];
        }
        
        [self.view addSubview:label];
    }
    
    
    
}

#pragma mark - 加载数据
-(void)loadData
{
    
//    http://111.200.41.13:8090/sgdmm?xsph=FX011600014&funname=getXsdmx
    
    [self.mydataSource removeAllObjects];
    
    [self.request requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?xsph=%@&funname=getXsdmx",self.model.xsph] parameters:nil complicate:^(BOOL success, NSString * object) {
        
        if (success) {
            
            [_hud hideAnimated:YES];
            NSLog(@"object------%@-------object",object);
            
            
            NSString *hh = [[[[object stringByReplacingOccurrencesOfString:@"<?xml+version=\"1.0\"+encoding=\"gbk\"?>" withString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"] stringByReplacingOccurrencesOfString:@"++<row>" withString:@""] stringByReplacingOccurrencesOfString:@"++</row>" withString:@""] stringByReplacingOccurrencesOfString:@"+" withString:@""];
            
            //                            NSLog(@"555555_____%@___555555",hh);
            
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
                
                //                NSArray *titles = @[[NSString stringWithFormat:@"房屋地址信息: %@",[firstElementArr[2] stringValue]],[NSString stringWithFormat:@"客户姓名: %@",[firstElementArr[1] stringValue]],[NSString stringWithFormat:@"客户编号: %@",[firstElementArr[0] stringValue]],[NSString stringWithFormat:@"设计管家: %@",[firstElementArr[3] stringValue]],[NSString stringWithFormat:@"开工日期: %@",[firstElementArr[7] stringValue]]];
                
                
                
                //                NSInteger j = 0;
                //                for (NSInteger i = 0; i < 5; i ++) {
                //
                //                    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30, 40 * j, self.view.bounds.size.width - 30, 40)];
                //                    label.text = titles[i];
                //                    label.font = [UIFont boldSystemFontOfSize:15];
                //                    label.numberOfLines = 0;
                //                    j++;
                //                    [self.view addSubview:label];
                //                }
                
                
                
                
                
                
                
                // 得到二级节点
                NSArray * secondElementArr = firstElement.children;
                
                
                
                int j = 8;
                for (NSInteger i = 0; i<=secondElementArr.count/8-1; i++) {
                    
                    
                    matermyModel *model = [[matermyModel alloc]init];
                    
                    
                    //                            cldh;//材料单号
                    //                            shzt;//审核状态
                    //                            lrsj;//录入时间
                    //                            clmx;//材料细明
                    
                    //                            psph=P002257016001
                    //                            2016-06-07 10:48:27.171 ForemanAPP[2190:60384] psdzt=等待审核
                    //                            2016-06-07 10:48:27.172 ForemanAPP[2190:60384] lrrq=2016-06-03
                    
                    //                        *clbm;//材料细明
                    //                        *clmc;//材料细明
                    //                        *xh;//材料细明
                    //                        *gg;//材料细明
                    //                        *jldwbm;//材料细明
                    //                        *pssl;//材料细明
                    
                    
                    
                    model.clbm = [secondElementArr[0+j*i] stringValue];
                    model.clmc = [secondElementArr[1+j*i] stringValue];
                    model.xh = [secondElementArr[2+j*i] stringValue];
                    model.gg = [secondElementArr[3+j*i] stringValue];
                    model.jldwbm = [secondElementArr[4+j*i] stringValue];
//                    model.clsl = [secondElementArr[5+j*i] stringValue];
                    
                    [self.dataSource addObject:[[secondElementArr[5+j*i] stringValue] componentsSeparatedByString:@".0"][0]];
                    model.clsl = self.dataSource[i];
                    model.cbj = [secondElementArr[6+j*i] stringValue];
                    model.xsj = [secondElementArr[7+j*i] stringValue];
                    [self.mydataSource addObject:model];
                    [CoredataManager insertModel:model];//将数据插入数据库
//                    [self.mydataSource addObject:[model.pssl componentsSeparatedByString:@".0"][0]];
                    
                }
                
                
                //显示金额总价
                float sum = 0;
                
                NSInteger i = 0;
                for (matermyModel *model in [CoredataManager findAppALL]) {
                    
                    float y = [model.xsj floatValue]*[self.dataSource[i] floatValue];
                    //        self.count = [NSString stringWithFormat:@"%ld",];
                    sum = sum + y;
                    
                    i++;
                    
                    
                }//删除所有的数据
                self.LLabel.text = [NSString stringWithFormat:@"材料总价为 : %g元",sum];
              
                
               
                

                [self.tableView reloadData];
                
                
                
                
                
                for (GDataXMLElement * secondElement in secondElementArr) {
                    NSLog(@">>>>>%@=%@", secondElement.name, secondElement.stringValue);
                    
                    //                    clbm=FC0000000000
                    //                    clmc=大芯板E1级(鑫生
                    //                                xh=
                    //                                gg=1220?440?8mm
                    //                                jldwbm=张
                    //                                pssl=5.0

                    
                    if ([secondElement.name isEqualToString:@"row1"]) {
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



#pragma mark - 注册tableView
-(void)registerTableView
{
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 160, self.view.bounds.size.width, self.view.bounds.size.height - 185) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"MaterialsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
     self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 380)];
    self.tableView.rowHeight = 158;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - 实现tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MaterialsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.model = self.mydataSource[indexPath.row];
    cell.quantitytextField.tag = indexPath.row;
    if ([self.model.xsdzt isEqualToString:@"等待审核"]) {
//        [cell.quantitytextField removeFromSuperview];
        cell.quantitytextField.enabled = NO;
        [cell.add removeFromSuperview];
        [cell.unadd removeFromSuperview];
    }
    cell.quantitytextField.text = self.dataSource[indexPath.row];
    cell.quantitytextField.delegate = self;
    
    
    [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField:) forControlEvents:UIControlEventEditingDidBegin];
    [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField1:) forControlEvents:UIControlEventEditingDidEnd];
    
    
    
    
    [cell.add addTarget:self action:@selector(onAdd:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.unadd addTarget:self action:@selector(onUnadd:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.add.tag = indexPath.row;
    cell.unadd.tag = indexPath.row;
    
    
    
    return cell;
    
}



-(void)onAdd:(UIButton *)btn
{
    
    
    //    [self.textField resignFirstResponder];
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
        }else{
    
            [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
        }
    
    float sum = 0;
    
    
    NSInteger h = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[self.dataSource[h] floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        h++;
        
        
    }//删除所有的数据
    
    self.LLabel.text = [NSString stringWithFormat:@"材料总价为 : %g元",sum];
    
    
    
}

-(void)onUnadd:(UIButton *)btn
{
//    [self.textField resignFirstResponder];
    NSInteger i = [self.dataSource[btn.tag] integerValue];
    
    if (i < 1) {
        return;
    }else{
        
        i = i - 1;
    }
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
    }else{
        
        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    }
    float sum = 0;
    
    
    NSInteger h = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[self.dataSource[h] floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        h++;
        
        
    }//删除所有的数据
    

    
    self.LLabel.text = [NSString stringWithFormat:@"材料总价为 : %g元",sum];
    
    
    

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
    
    
    
    //    MaterialsListModel *model = self.mydataSource[textField.tag];
    //    model.clsl = textField.text;//更新clsl
    //
    //    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    //
    //
    //    if ([CoredataManager returnCount:model] > 0) {
    //        [CoredataManager updataData:self.mydataSource[textField.tag]];//更新数据
    //    }else{
    //
    //        [CoredataManager insertModel:self.mydataSource[textField.tag]];//插入数据
    //    }
    //
    
    
    
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    DetailViewController *detail = [[DetailViewController alloc]init];
    //    BuildModel *model = self.dataSource[indexPath.row];
    //    detail.myModel = model;
    //    [self.navigationController pushViewController:detail animated:NO];
}


#pragma mark - textField代理

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
    
    
    float sum = 0;
    
    
    NSInteger h = 0;
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[self.dataSource[h] floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        h++;
        
        
    }//删除所有的数据
    

    
    self.LLabel.text = [NSString stringWithFormat:@"材料总价为 : %g元",sum];
    
    

    

    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
    return YES;
}
//1秒定位结束
-(void)createTime11
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(dismissAlertView11)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)dismissAlertView11
{
    
    
    
    [self.HHView removeFromSuperview];
    
}



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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
