//
//  TodayViewController.m
//  news
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "TodayViewController.h"
#import "SDCycleScrollView.h"
#import "TodayModel.h"
#import "TodayRecommendTableViewCell.h"
#import "TnameViewController.h"
#import "ReadingViewController.h"
@interface TodayViewController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
 
}
@property(nonatomic,strong)NSMutableArray *urlArray;//存放轮播图的图片
@property(nonatomic,strong)NSMutableArray *modelArray;//存放model对象的数组
@property(nonatomic,strong)UITableView *todayTableView;

@property(nonatomic,strong)NSMutableArray *tnameArray;//杂志名
@property(nonatomic,strong)NSMutableArray *tidArray;//id编号


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestData];
   
    //创建轮播图
    [self createdShuffling];

    //创建tableview
    [self  createdTableView];
    
    //设置导航栏标题
    self.navigationItem.title =@"今日订阅推荐";
    
}




//创建tableview
- (void)createdTableView{
    
    self.todayTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    //设置代理
    self.todayTableView.delegate=self;
    self.todayTableView.dataSource=self;
    //注册
    UINib * nib =[UINib nibWithNibName:@"TodayRecommendTableViewCell" bundle:nil];
    [self.todayTableView registerNib:nib forCellReuseIdentifier:@"todayCell"];
    
    [self.view addSubview:self.todayTableView];
    
}

//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.modelArray.count;
}

//分组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TodayRecommendTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"todayCell" forIndexPath:indexPath];
    
    TodayModel * model =self.modelArray[indexPath.section];
    cell.model=model;
    //添加按钮响应事件
    [cell.Button addTarget:self action:@selector(addButtonEvents:)
          forControlEvents:UIControlEventTouchUpInside];
    
   
    
    return cell;
}


//按钮响应事件
- (void)addButtonEvents:(UIButton *)Bt{
    
  
    //获取bt点击的cell
    UITableViewCell * cell =(UITableViewCell *)[[Bt superview]superview];
    
    NSIndexPath *indexPath =[self.todayTableView indexPathForCell:cell];
    
    //让代理执行协议方法 并且model对象过去
    [self.delegate getTodayModel:self.modelArray[indexPath.section]];
    
    [self.modelArray removeObjectAtIndex:indexPath.section];
    [self.todayTableView reloadData];
    
    
}


//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

//选中cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TnameViewController  * tnameVC =[[TnameViewController alloc]init];
    TodayModel *model =self.modelArray[indexPath.section];
    tnameVC.tid =model.tid;
    tnameVC.tname =model.tname;
    
    [self.navigationController pushViewController:tnameVC animated:YES];
    
}

//请求数据
- (void)requestData{
    
    AFHTTPRequestOperationManager *manager =[[AFHTTPRequestOperationManager alloc]init];
    NSString * strUrl =[kTodayUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    
    //GET请求
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       //请求成功
        NSData *data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id request =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //解析数据
        NSArray * array =[request objectForKey:@"bannerlist"];
        
        self.urlArray =[NSMutableArray array];
        self.tnameArray=[NSMutableArray array];
        self.tidArray=[NSMutableArray array];
        
        //遍历数组
        for (NSDictionary *dic in array) {
            
            [self.tnameArray addObject:[dic objectForKey:@"tname"]];
            [self.tidArray addObject:[dic objectForKey:@"tid"]];
            [self.urlArray addObject:[dic objectForKey:@"imgsrc"]];
            
        }
        
            NSArray * array1 =[request objectForKey:@"recommendlist"];
        
        
            for (NSDictionary * dic1 in array1) {
                
             TodayModel * model =[[TodayModel alloc]init];
             [model setValuesForKeysWithDictionary:dic1];
                
             [self.modelArray addObject:model];
              if (self.reciveArray.count>0) {
                    
                    for (TodayModel *model1 in _reciveArray) {
                        if ([model1.tid isEqualToString:model.tid]) {
                            
                            [self.modelArray removeObject:model];
                            
                          }
                   }
                    
            }
              
        }
        
       
        
        
        
        
                dispatch_async(dispatch_get_main_queue(), ^{
        
                    
                    [self.todayTableView reloadData];
                
                   
                });
        
            
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}

- (void)createdShuffling{
    self.view.backgroundColor=[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame =self.view.bounds;
    [self.view addSubview:backgroundView];
    
    CGFloat w = [[UIScreen mainScreen]bounds].size.width;

    
    SDCycleScrollView *cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, 150) imageURLStringsGroup:nil];
    cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
    
    cycleScrollView.delegate=self;
    cycleScrollView.dotColor =[UIColor whiteColor];//分页控件小圆标颜色
    cycleScrollView.placeholderImage=[UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView];
    
    //加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        cycleScrollView.imageURLStringsGroup =self.urlArray;
        
    });
    
    
}


//代理方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    
    TnameViewController * tnameVC =[[TnameViewController alloc]init];
    tnameVC.tname =self.tnameArray[index];
    tnameVC.tid =self.tidArray[index];
    
    [self.navigationController pushViewController:tnameVC animated:YES];
    
}

//懒加载
-(NSMutableArray *)modelArray{
    if (!_modelArray) {
        self.modelArray=[NSMutableArray array];
        
    }
    return _modelArray;
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
