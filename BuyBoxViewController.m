//
//  BuyBoxViewController.m
//  ForemanAPP
//
//  Created by mac on 16/5/11.
//  Copyright © 2016年 YF. All rights reserved.
//

#import "BuyBoxViewController.h"


#import "MaterialsListTableViewCell.h"


#import "SureOrderViewController.h"


#import "MaterialsListViewController.h"


#import "CoredataManager.h"

#import "MaterialsListModel.h"


#import "RequsetManager.h"

#import "MybuylistViewController.h"

#import "BuyListViewController.h"

#import "MyCoredataManager.h"

@interface BuyBoxViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataSource;


@property (nonatomic,strong)NSMutableArray *mydataSource;

@property (nonatomic,assign)NSInteger Mytag;

@property (strong,nonatomic)UITextField *textField;

@property (nonatomic,strong)RequsetManager *requset;

@property (nonatomic,strong)BuyListViewController *buyList;

@property (nonatomic,strong)UILabel *myView;

@property (nonatomic,strong)NSString *myobject;

@property (nonatomic,strong)UILabel *HHView;

@property (nonatomic,strong)UIView *IView;

@property (nonatomic,strong)NSString *sumMoney;//价格总价

@end

@implementation BuyBoxViewController

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self createTableView];
    [self costumNavigation];
   
    
    [self createButton];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
//    self.view.backgroundColor = [UIColor redColor];
}


-(void)loadData
{

    [self.dataSource removeAllObjects];
    [self.mydataSource removeAllObjects];
    [self.mydataSource addObjectsFromArray:[CoredataManager findAppALL]];//读取数据库所有数据
    
    for (matermyModel * model in self.mydataSource) {
        [self.dataSource addObject:model.clsl];
    }
    
    
//    self.dataSource addObject:s
    [self.tableView reloadData];
}
-(NSMutableArray *)mydataSource
{

    if (_mydataSource == nil) {
        _mydataSource = [NSMutableArray array];
    }
    return _mydataSource;
}


-(RequsetManager *)requset
{

    if (_requset == nil) {
        _requset = [[RequsetManager alloc]init];
    }
    return _requset;
}

-(NSMutableArray *)dataSource
{

    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - 创建tableView

-(void)createTableView
{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 40) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"MaterialsListTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 158;
     self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 380)];
    [self.view addSubview:self.tableView];
}


#pragma mark - 创建Button
-(void)createButton
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:@"确定下单" forState:UIControlStateNormal];
    [button setBackgroundColor: [UIColor colorWithRed:15/256.0 green:135/256.0 blue:206/256.0 alpha:0.8]];
    [button addTarget:self action:@selector(onSureOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    
}

#pragma mark - 点击确定下单
-(void)onSureOrder
{

    
//    
//    if (self.dataSource.count == 0) {
//        
//        self.myView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
//        self.myView.center = self.view.center;
//        self.myView.backgroundColor = [UIColor redColor];
//        self.myView.layer.cornerRadius = 5;
//        self.myView.layer.masksToBounds = YES;
//        self.myView.text = @"请去重新添加购物车";
//        self.myView.textAlignment = NSTextAlignmentCenter;
//        [self.view addSubview:self.myView];
//        
//        [self createTime];
//        
//    }else
    
        
    if ([CoredataManager findAppALL].count == 0) {
        [self.navigationController popViewControllerAnimated:NO];
        
        for (matermyModel *model in [MyCoredataManager findAppALL]) {
            [MyCoredataManager deleteModel:model];
        }
        
    }else{
    
        if ([self.panduan isEqualToString:@"yes"]){
            
            
            [self.requset requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?fclb=1&psfs=&psdzt=&funname=insertCld&jhshsj=&lrr=%@&psph=&khbh=%@",self.userName,self.model.khbh] parameters:nil complicate:^(BOOL success, id object) {
                if (success) {
                    NSLog(@"%@",object);
                    
                    self.myobject = object;
                    NSMutableString *dates = [[NSMutableString alloc]init];
                    
                    NSInteger i = 0;
                    
                    for (matermyModel *model in [CoredataManager findAppALL]) {
                        NSString *MyStr = [NSString stringWithFormat:@"%@*%@^",model.clbm,model.clsl];
                        
                        
                        [dates appendString:MyStr];
                        i++;
                        
                        
                    }
                    
                    
                    
                    
                    NSString *ss =  [[dates substringToIndex:dates.length - 1] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//去除最后的^并转换URL
                    
                    NSLog(@"########%@",ss);
                    [self.requset requestWithUrl:[NSString stringWithFormat:@"http://111.200.41.13:8090/sgdmm?dates=%@&psph=%@&funname=insertCldmxs",ss,object] parameters:nil complicate:^(BOOL success, id object) {
                        if (success) {
                            
                            NSLog(@"%@",object);
                            
                            for (matermyModel *model in [CoredataManager findAppALL]) {
                                [CoredataManager deleteModel:model];
                            }//删除所有的数据
                            
                            for (matermyModel *model in [MyCoredataManager findAppALL]) {
                                [MyCoredataManager deleteModel:model];
                            }//删除所有的数据
                            
                            SureOrderViewController *sure = [[SureOrderViewController alloc]init];
                            
                            sure.money = self.sumMoney;
                            
                            sure.panduan = @"yes";
                            sure.model = self.model;
                            sure.mybh = self.myobject;
                            sure.khdz = self.khdz;
                            [self.navigationController pushViewController:sure animated:NO];
                            
                        }else{
                            NSLog(@"%@",object);
                            
                        }
                    }];
                    
                    
                }else{
                    
                    NSLog(@"%@",object);
                }
            }];
            
        }else{
            
            
            MybuylistViewController *my = [[MybuylistViewController alloc]init];
            my.userName = self.userName;
            my.khdz = self.khdz;
            [self.navigationController pushViewController:my animated:NO];
        }

    }
    
}


//1秒定位结束
-(void)createTime3
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.7f
                                     target:self
                                   selector:@selector(dismissAlertView3)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)dismissAlertView3
{
    
    
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:NO];
    
}




//1秒定位结束
-(void)createTime
{
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.3f
                                     target:self
                                   selector:@selector(dismissAlertView)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)dismissAlertView
{
    
    
    
    [self.myView removeFromSuperview];
    
}




#pragma mark - 设置导航栏
-(void)costumNavigation

{
    
    self.title = @"购物车";
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/256.0 green:150/256.0 blue:124/256.0 alpha:1]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_left.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(onback)];
  
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    
    float sum = 0;
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
    
        float y = [model.xsj floatValue]*[model.clsl floatValue];
//        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        
       
        
    }//删除所有的数据
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"总价:%g元",sum] style:0 target:nil action:nil];
    self.sumMoney = [NSString stringWithFormat:@"%g元",sum];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];

}


-(void)onback
{
    for (matermyModel *model in [CoredataManager findAppALL]) {
        [CoredataManager deleteModel:model];
    }//删除所有的数据
    
    for (matermyModel *model in [MyCoredataManager findAppALL]) {
        [MyCoredataManager deleteModel:model];
    }
    
    [self.navigationController popViewControllerAnimated:NO];
   
}



#pragma mark - 实现tableView代理

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
    

    
    
    
//    MaterialsListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
//
//    
//    cell.model = self.dataSource[indexPath.row];
//    
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.layer.borderWidth = 1;
//    cell.layer.borderColor = [[UIColor grayColor]CGColor];
//    cell.add.tag = indexPath.row;
//    cell.unadd.tag = indexPath.row;
//    self.Mytag = indexPath.row;
////    cell.quantitytextField.text = self.dataSource[indexPath.row];
//    cell.selected = NO;
//    cell.quantitytextField.delegate = self;
//    cell.quantitytextField.layer.cornerRadius = 5;
//    cell.quantitytextField.layer.masksToBounds = YES;
//    cell.quantitytextField.tag = indexPath.row;
//    [cell.add addTarget:self action:@selector(onAdd:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.unadd addTarget:self action:@selector(onUnadd:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField:) forControlEvents:UIControlEventEditingDidBegin];
//    [cell.quantitytextField addTarget:self action:@selector(onClickquantitytextField1:) forControlEvents:UIControlEventEditingDidEnd];
//
//    
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
//    return cell;
//
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [CoredataManager deleteModel:self.mydataSource[indexPath.row]];
    
    [self.mydataSource removeObjectAtIndex:[indexPath row]];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    [self loadData];
    
    float sum = 0;
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[model.clsl floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
    }//删除所有的数据
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"总价:%g元",sum] style:0 target:nil action:nil];
    self.sumMoney = [NSString stringWithFormat:@"%g元",sum];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
}


//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//
////    MaterialsListModel *model = self.dataSource[indexPath.row];
////    [CoredataManager deleteModel:model];
//}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [CoredataManager deleteModel:self.mydataSource[indexPath.row]];
    return @"删除";
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
    }else{
        
        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    }
    
    float sum = 0;
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[model.clsl floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        
        
        
    }//删除所有的数据
    
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"总价:%g元",sum] style:0 target:nil action:nil];
     self.sumMoney = [NSString stringWithFormat:@"%g元",sum];
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
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
    }else{
        
        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    }
    
    if ([self.dataSource[btn.tag] isEqualToString:@"0"] || [self.dataSource[btn.tag] isEqualToString:@"."]) {//判断当减到0时删除
        [CoredataManager deleteModel:self.mydataSource[btn.tag]];
    }
    
    
    float sum = 0;
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[model.clsl floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        
        
        
    }//删除所有的数据
    
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"总价:%g元",sum] style:0 target:nil action:nil];
     self.sumMoney = [NSString stringWithFormat:@"%g元",sum];
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
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
    
    
    
    if ([textField.text isEqualToString:@"0"] || [textField.text isEqualToString:@""]||[textField.text isEqualToString:@" "]) {//判断当减到0时删除
        
        [CoredataManager deleteModel:self.mydataSource[textField.tag]];
    }
    
    matermyModel *model = self.mydataSource[textField.tag];
    model.clsl = self.dataSource[textField.tag];//更新clsl
    
    //        [CoredataManager insertModel:self.mydataSource[btn.tag]];//插入数据
    //        [CoredataManager updataData:self.mydataSource[btn.tag]];//更新数据
    //        [CoredataManager deleteModel:self.mydataSource[btn.tag]];//删除数据
    
    
    if ([CoredataManager returnCount:model] > 0) {
        [CoredataManager updataData:self.mydataSource[textField.tag]];//更新数据
    }
    
    
    
    float sum = 0;
    
    
    for (matermyModel *model in [CoredataManager findAppALL]) {
        
        float y = [model.xsj floatValue]*[model.clsl floatValue];
        //        self.count = [NSString stringWithFormat:@"%ld",];
        sum = sum + y;
        
        
        
        
    }//删除所有的数据
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:[NSString stringWithFormat:@"总价:%g元",sum] style:0 target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
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

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
//    for (matermyModel *model in [CoredataManager findAppALL]) {
//        [CoredataManager deleteModel:model];
//    }//删除所有
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
