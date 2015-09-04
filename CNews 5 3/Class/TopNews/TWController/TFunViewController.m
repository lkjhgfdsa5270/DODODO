//
//  TFunViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TFunViewController.h"


#import "TFunOnePictureTableViewCell.h"
#import "TFunListOnePictureViewController.h"
#import "TFunThreePicTableViewCell.h"

#import "TJokeViewController.h"
#import "TFollowViewController.h"
#import "TPictureViewController.h"

#import "FunManager.h"

#import "SDCycleScrollView.h"

@interface TFunViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray * funDataArray;//存放首页数据

@property(nonatomic,strong)NSMutableArray * funArray;//存放模型

//存放所有数据
@property (nonatomic, strong)NSMutableArray *allDataArray;

@property(nonatomic,assign)int number;

@end

@implementation TFunViewController

//懒加载
-(NSMutableArray *)funDataArray{
    if (!_funDataArray) {
        _funDataArray = [NSMutableArray array];
    }
    return _funDataArray;
}

- (NSMutableArray *)funArray{
    if (!_funArray) {
        _funArray = [NSMutableArray array];
    }
    return _funArray;
}

//懒加载
-(NSMutableArray *)allDataArray
{
    
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    
    return _allDataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"娱乐";
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tdf.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    
     _number = 0;
    
    self.TFunTableView.delegate = self;
    self.TFunTableView.dataSource = self;
   
    [self upData];
    
}

- (void)upData{
    //添加头部控件的方法
    [self.TFunTableView addHeaderWithTarget:self action:@selector(headerUpData)];
 
    //添加尾部控件的方法
    [self.TFunTableView addFooterWithTarget:self action:@selector(footerUpData)];
    
    [self.TFunTableView headerBeginRefreshing];
    
}

- (void)headerUpData{
    //请求数据
    [[FunManager sharedInstance] getDataWithUrl:@"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html" Result:^(NSDictionary * dic) {
        
        [self.funArray removeAllObjects];
        
        self.allDataArray = dic[@"T1348648517839"];
        self.funDataArray = _allDataArray;
        
        for (NSDictionary * dic in self.funDataArray) {
            TModel * model = [[TModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.funArray addObject:model];
            
            
            TModel * model1 = self.funArray[0];
            
            self.TFunTableView.tableHeaderView.frame = CGRectMake(0, 0, self.TFunTableView.frame.size.width, 180);
            
            NSArray * array = model1.ads;
            NSString * str = @"";
            NSString * titleName = @"";
            
            for (NSDictionary * dic in array) {
                str = dic[@"imgsrc"];
                titleName = dic[@"title"];
            }
            
            NSArray *imagesURLStrings = @[model1.imgsrc,str];
            NSArray * titles = @[model1.title,titleName];
      
            //网络加载 --- 创建带标题的图片轮播器
            SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:self.TFunTableView.tableHeaderView.frame imageURLStringsGroup:nil]; // 模拟网络延时情景
            cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
            
          cycleScrollView2.titlesGroup = titles;
          
            cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
            cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
            [self.view addSubview:cycleScrollView2];
            
            //             --- 模拟加载延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
            });

            
            self.TFunTableView.tableHeaderView = cycleScrollView2;
     
   
        }
 
        [self.TFunTableView reloadData];
        
        
        //头部刷新结束
    [self.TFunTableView headerEndRefreshing];
    }];
    
}

- (void)footerUpData{
    
    if (_number ==40) {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"到底啦!!!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
        return;
    }
        //请求数据
        [[FunManager sharedInstance] getDataWithUrl:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348648517839/%d0-20.html",_number+2] Result:^(NSDictionary * dic) {
            
            self.allDataArray = dic[@"T1348648517839"];
            self.funDataArray = _allDataArray;
            
            for (NSDictionary * dic in self.funDataArray) {
                TModel * model = [[TModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.funArray addObject:model];
            }
            
            [self.TFunTableView reloadData];
        }];
        //尾部部刷新结束
        [self.TFunTableView footerEndRefreshing];
    
   _number = _number+2;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.funArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
        TModel *model =self.funArray[indexPath.row];
        
        if ( model.imgextra ==nil){
            
            UINib * nib = [UINib nibWithNibName:@"TFunOnePictureTableViewCell" bundle:nil];
            [self.TFunTableView registerNib:nib forCellReuseIdentifier:@"mycellOnePicture"];
            TFunOnePictureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycellOnePicture" forIndexPath:indexPath];
            
            cell.model =model;
            
            
            
            //取消选中颜色
            
            UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView = backView;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            
            //取消边框线
            
            [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
            cell.backgroundColor = [UIColor clearColor];
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
            
        }else if ( model.imgextra !=nil){
            
            UINib * nib = [UINib nibWithNibName:@"TFunThreePicTableViewCell" bundle:nil];
            [self.TFunTableView registerNib:nib forCellReuseIdentifier:@"mycellThreePicture"];
            TFunThreePicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycellThreePicture" forIndexPath:indexPath];
            
            cell.model =model;
            
            
            //取消选中颜色
            
            UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView = backView;
            cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
            
            //取消边框线
            
            [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
            cell.backgroundColor = [UIColor clearColor];
            
            
            cell.backgroundColor = [UIColor clearColor];
            
            return cell;
        }else{
            return nil;
        }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TModel *model =self.funArray[indexPath.row];

   if ( model.imgextra ==nil){
        return 125;
    }else if (model.imgextra !=nil){
        return 150;
    }else{
        return 0;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TModel *model =self.funArray[indexPath.row];
    
    if (model.ads != nil) {
       
        
        
        
    } else if (model.ads == nil && model.imgextra ==nil){
        TFunListOnePictureViewController * TFunListOnePictureVC = [[TFunListOnePictureViewController alloc]init];
        [self.navigationController pushViewController:TFunListOnePictureVC animated:YES];
        
        model = self.funArray[indexPath.row];
        TFunListOnePictureVC.model = model;

        
    }else if (model.ads == nil && model.imgextra !=nil){
        

        
    }
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"3.jpg"];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.TFunTableView setBackgroundView:imageView];
    
    
    
    
    
}



- (IBAction)didJumpToJoke:(UIButton *)sender {
    

    
    TJokeViewController * TJokeVC = [[TJokeViewController alloc]init];

    [self.navigationController pushViewController:TJokeVC animated:YES];
    
    
}

- (IBAction)didJumpToFollow:(UIButton *)sender {
    
   
    
    TFollowViewController * TFollowVC = [[TFollowViewController alloc]init];

    [self.navigationController pushViewController:TFollowVC animated:YES];
}

- (IBAction)didJumpToPicture:(UIButton *)sender {
    
    
    
    TPictureViewController * TPictureVC = [[TPictureViewController alloc]init];

    [self.navigationController pushViewController:TPictureVC animated:YES];
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
