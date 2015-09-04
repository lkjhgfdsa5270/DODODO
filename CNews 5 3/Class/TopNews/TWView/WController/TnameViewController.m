//
//  TnameViewController.m
//  news
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "TnameViewController.h"
#import "TnameTableViewCell.h"
#import "TodayModel.h"
#import "NameDetailViewController.h"
@interface TnameViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *modelArray;//接收model对象数组

@end

@implementation TnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置代理
    self.TnameTableView.delegate=self;
    self.TnameTableView.dataSource=self;
    //注册
    UINib * nib =[UINib nibWithNibName:@"TnameTableViewCell" bundle:nil];
    [self.TnameTableView registerNib:nib forCellReuseIdentifier:@"nameCell"];
    
    //请求数据
    [self requestData];
    
    //设置导航栏标题
    self.navigationItem.title=self.tname;

   //刷新
    [self upData];
    
}

//刷新

//刷新
- (void)upData{
    //顶部刷新
    [self.TnameTableView addHeaderWithTarget:self action:@selector(headerUpData)];
    //下拉刷新
    [self.TnameTableView addFooterWithTarget:self action:@selector(footUpData)];
    
    //开始上拉刷新
    [self.TnameTableView headerBeginRefreshing];
    
}

//上拉刷新响应事件
- (void)headerUpData{
    //请求数据
    [self requestData];
    
    [self.TnameTableView reloadData];
    [self.TnameTableView headerEndRefreshing];
}

//下拉刷新
- (void)footUpData{
    [self requestData];
    [self.TnameTableView reloadData];
    [self.TnameTableView footerEndRefreshing];
}

- (void)requestData{
    AFHTTPRequestOperationManager *manager =[[AFHTTPRequestOperationManager alloc]init];
    NSString *url =[[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/%@/0-20.html",self.tid]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates =YES;
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    //GET请求
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        id request = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array =[request objectForKey:self.tid];
        self.modelArray =[NSMutableArray array];
        
        [self.modelArray removeAllObjects];
        for (NSDictionary *dic in array) {
            
            TodayModel *model =[[TodayModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
        
            [self.modelArray addObject:model];
     
            
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.TnameTableView reloadData];
               
                
            });
            
            
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.modelArray.count;
}

//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TnameTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"nameCell" forIndexPath:indexPath];
    
    TodayModel *model =self.modelArray[indexPath.section];
    cell.model=model;
    
    
  
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

//选中cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TodayModel * model =self.modelArray[indexPath.section];
    NameDetailViewController * nameVC =[[NameDetailViewController alloc]init];
    nameVC.docid =model.docid;
    
    [self.navigationController pushViewController:nameVC animated:YES];
    
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
