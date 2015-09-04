//
//  ReadingViewController.m
//  news
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "ReadingViewController.h"
#import "RecommendedTableViewCell.h"
#import "ReadModel.h"
#import "MySubscriptionTableViewCell.h"

#import "TodayTableViewCell.h"
#import "SubContentTableViewCell.h"
#import "ReadDetailViewController.h"
#import "TodayViewController.h"
#import "TnameViewController.h"

@interface ReadingViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ToDayDelegate>
{
    int _count;
    int _count1;//用来判断底部刷新的时候是否删除加载之前的内容
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;//推荐阅读

@property (nonatomic,strong)NSMutableArray * modelArray;//接收所有的model对象

@property (strong, nonatomic) IBOutlet UITableView *subTableView;//我的订阅
@property(nonatomic,strong)UISegmentedControl *segmented;



@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建UISegmentController
    [self setSegmentController];
    
    //设置tabview和scrollView的一些属性
    [self setAttribute];

    //请求和解析数据
    [[WBDataHandle defaultDataHandel]requestDataDidFinish:^(NSMutableArray *modelArray) {
        self.modelArray = [NSMutableArray array];
        
        self.modelArray = modelArray;
        
        [self.tableVIew reloadData];
    }];
    
    
    //刷新
    [self upData];
    
    //

}

- (void)upData{
   
    //顶部刷新
    [self.tableVIew  addHeaderWithTarget:self action:@selector(headerUpData)];
    
    //底部刷新
    [self.tableVIew addFooterWithTarget:self action:@selector(footerUpData)];
    
    [self.tableVIew headerBeginRefreshing];
}

//顶部刷新
- (void)headerUpData{
    
    [self requestTopData];//请求数据
    
    [self.tableVIew reloadData];
    [self.tableVIew headerEndRefreshing]; //头部刷新结束
    
}

//底部刷新
- (void)footerUpData{
    [self requestTopData];//请求数据
    
    [self.tableVIew reloadData];
    [self.tableVIew footerEndRefreshing];//底部刷新结束
     _count++;
}

//刷新时候请求的数据
- (void)requestTopData{
    
    AFHTTPRequestOperationManager *manager =[[AFHTTPRequestOperationManager alloc]init];
    
    NSString * strUrl =[kReadUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //GET请求
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求数据成功
        NSData *data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     
        
        //解析数据
        
        //开辟数组
        NSArray * array =[result objectForKey:@"推荐"];
        if (_count==_count1+1) {
            _count1 ++;
            
        }else
        {
             [self.modelArray removeAllObjects];
        }
        
        
        //遍历数组
        for (NSDictionary *dic in array) {
            
            ReadModel * model =[ReadModel new];
            
            [model setValuesForKeysWithDictionary:dic];
       
            [self.modelArray addObject:model];
            
      
        }
      
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求数据失败
  
        
    }];
    
    
}

//设置一些属性
- (void)setAttribute{
    //设置scrollView分页效果
    self.scrollView.pagingEnabled=YES;
    
    //设置边界反弹效果
    self.scrollView.bounces=NO;
    
    
    self.scrollView.delegate=self;
    
    
    //设置导航栏不透明
    self.navigationController.navigationBar.translucent =NO;
    
    //设置代理
    self.tableVIew.delegate =self;
    self.tableVIew.dataSource =self;
    self.subTableView.delegate=self;
    self.subTableView.dataSource=self;
    
    
    //注册
    UINib * nib =[UINib nibWithNibName:@"RecommendedTableViewCell" bundle:nil];
    [self.tableVIew registerNib:nib forCellReuseIdentifier:@"recommenCell"];
    
    //注册第二种cell
    UINib *nib1 =[ UINib nibWithNibName:@"MySubscriptionTableViewCell" bundle:nil];
    [self.tableVIew registerNib:nib1 forCellReuseIdentifier:@"subscripCell"];
    
    //注册第三种cell
    UINib *nib2 =[UINib nibWithNibName:@"TodayTableViewCell" bundle:nil];
    [self.subTableView registerNib:nib2 forCellReuseIdentifier:@"tadayCell"];
    
    //注册第四种cell
    UINib *nib3 =[UINib nibWithNibName:@"SubContentTableViewCell" bundle:nil];
    
    [self.subTableView registerNib:nib3 forCellReuseIdentifier:@"subCell"];

}

- (void)setSegmentController{
    
    //创建
    self.segmented =[[UISegmentedControl alloc]initWithItems:@[@"推荐阅读",@"我的订阅"]];
    //设置大小
    _segmented.frame = CGRectMake(0.0, 0.0, 200, 30.0);
    
    //设置默认选中
    _segmented.selectedSegmentIndex=0;
    
    //设置颜色
    _segmented.tintColor = [UIColor grayColor];
    
    //添加事件
    [_segmented addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationItem setTitleView:_segmented];
    
    
}
//响应segement事件
- (void)changeView:(UISegmentedControl *)segment{
    NSInteger index =segment.selectedSegmentIndex;
    
    self.scrollView.contentOffset=CGPointMake(index*self.scrollView.frame.size.width, 0);
}

//scrollview拖拽
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     self.segmented.selectedSegmentIndex =self.scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
}


//区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==self.subTableView) {
        
       return 2;
        
    }else  {
        return self.modelArray.count;
    }
    
}


//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableVIew) {
        return 1;
        
    }else {
        
        
        if (section==1) {
            
            return self.todayModelArray.count;
            
        }
        
        return 1;
    }
    

}


//创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    ReadModel * model =[[WBDataHandle defaultDataHandel]getModelWithIndex:indexPath.section];
    if (tableView == self.tableVIew) {
        
    ReadModel *model =self.modelArray[indexPath.section];
    //判断设置不同的cell
         if (model.imgnewextra.count==0) {
         RecommendedTableViewCell * recommencell =[tableView  dequeueReusableCellWithIdentifier:@"recommenCell" forIndexPath:indexPath];
       
       //添加cell上面button的响应事件
        [recommencell.deleteCellBt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        recommencell.model =model;
        
        
        return recommencell;
        
        }else{
        
        MySubscriptionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"subscripCell" forIndexPath:indexPath];
        
        //添加cell上面button的响应事件
        [cell.deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.model =model;
        
        return cell;
        
        
         }
    
    }else {
        
        if (indexPath.section==0) {
            TodayTableViewCell * todayCell =[tableView dequeueReusableCellWithIdentifier:@"tadayCell" forIndexPath:indexPath];
            
            
            return todayCell;
            
        }else {
            
            SubContentTableViewCell * subCell =[tableView dequeueReusableCellWithIdentifier:@"subCell" forIndexPath:indexPath];
            TodayModel *model =self.todayModelArray[indexPath.row];
            subCell.model =model;
            
            [subCell.deleteButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside ];
            
            return subCell;
            
            
          }
    
    }
    
}



//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView ==self.tableVIew) {
        ReadModel *model =self.modelArray[indexPath.section];
        
        if (model.imgnewextra.count==0) {
            
            return 150;
        }else{
            
            return 300;
        }
        
        
    }else {
        
        
        return 100;
    }
   
}


- (void)buttonAction:(UIButton *)bt{
    
    
    UITableViewCell * cell =(UITableViewCell *)[[bt superview]superview];
    NSIndexPath * indexPath =[self.tableVIew indexPathForCell:cell];
 
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要删除" preferredStyle:UIAlertControllerStyleAlert];
    
     UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
         if ([[cell superview]superview] ==self.tableVIew) {
             [_modelArray removeObjectAtIndex:indexPath.section];
             
             [self.tableVIew  reloadData];
         }else{
             [_todayModelArray removeObjectAtIndex:indexPath.section];
             [self.subTableView reloadData];
         }
        

     }];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action1];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//选中cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableVIew) {
        
        ReadModel *model =self.modelArray[indexPath.section];
     
        ReadDetailViewController * readVC =[[ReadDetailViewController alloc]init];
        readVC.docid=model.docid;
        
        [self.navigationController pushViewController:readVC animated:YES];
        
        
    }else{
        
        if (indexPath.section==0) {
            
            TodayViewController *todayVC =[[TodayViewController alloc]init];
            todayVC.delegate =self;
            if (self.todayModelArray.count>0 ) {
                todayVC.reciveArray=[NSMutableArray array];
                todayVC.reciveArray=self.todayModelArray;
               
                
                
                
            }
            
            
            [self.navigationController pushViewController:todayVC animated:YES];
            
        }else {
            
            TnameViewController * tnameVC =[[TnameViewController alloc]init];
            
            TodayModel * model =self.todayModelArray[indexPath.row];
            tnameVC.tid =model.tid;
            tnameVC.tname =model.tname;
            [self.navigationController pushViewController:tnameVC animated:YES];
            
        }
    }
    
}

//设置区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView==self.subTableView) {
        if (section==1) {
            return 30;
        }
        
    }
    return 0;
}

//设置区头的标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView==self.subTableView) {
        if (section==1) {
            
            return @"精彩订阅";
        }
    }
    return nil;
}


//实现代理的方法(TodayViewController里面的协议)
-(void)getTodayModel:(TodayModel *)model{
    
    
    [self.todayModelArray addObject:model];
    [self.subTableView reloadData];
    
    
   
    
    
}


//懒加载
-(NSMutableArray *)todayModelArray{
    if (!_todayModelArray) {
        
        self.todayModelArray =[NSMutableArray array];
    }
    return _todayModelArray;
    
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
