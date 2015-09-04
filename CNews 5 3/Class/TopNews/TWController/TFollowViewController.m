//
//  TFollowViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TFollowViewController.h"
#import "TFollowTableViewCell.h"
#import "TFollowListViewController.h"
#import "TFollowListTableViewCell.h"


#import "TFunViewController.h"
#import "TJokeViewController.h"
#import "TPictureViewController.h"

#import "FunManager.h"

#import "SDCycleScrollView.h"

@interface TFollowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * followDataArray;//存放首页数据

@property(nonatomic,strong)NSMutableArray * followArray;//存放模型

//存放所有数据
@property (nonatomic, strong)NSMutableArray *allDataArray;

@property(nonatomic,assign)int number;



@end

@implementation TFollowViewController


//懒加载
-(NSMutableArray *)followDataArray{
    if (!_followDataArray) {
        _followDataArray = [NSMutableArray array];
    }
    return _followDataArray;
}



- (NSMutableArray *)followArray{
    if (!_followArray) {
        _followArray = [NSMutableArray array];
    }
    return _followArray;
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
    
    self.navigationItem.title = @"游戏";
    
    _number = 0;
    
    self.TFollowView.delegate = self;
    self.TFollowView.dataSource = self;
    
    [self upData];
    

    

    
}

- (void)upData{
    //添加头部控件的方法
    [self.TFollowView addHeaderWithTarget:self action:@selector(headerUpData)];
    
    //添加尾部控件的方法
    [self.TFollowView addFooterWithTarget:self action:@selector(footerUpData)];
    
    [self.TFollowView headerBeginRefreshing];
    
    
 
    
}

- (void)headerUpData{
    //请求数据
    [[FunManager sharedInstance] getDataWithUrl:@"http://c.m.163.com/nc/article/list/T1348654151579/0-20.html" Result:^(NSDictionary * dic) {
        
        [self.followArray removeAllObjects];
        
        self.allDataArray = dic[@"T1348654151579"];
        self.followDataArray = _allDataArray;
        
        for (NSDictionary * dic in self.followDataArray) {
            TModel * model = [[TModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.followArray addObject:model];
            
          
             self.TFollowView.tableHeaderView.frame = CGRectMake(0, 0, self.TFollowView.frame.size.width, 220);
            
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:self.TFollowView.tableHeaderView.frame];
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
            
            self.TFollowView.tableHeaderView = imgView;
            
            
        }
        
        [self.TFollowView reloadData];
        
     
    }];
       //头部刷新结束
        [self.TFollowView headerEndRefreshing];
}

- (void)footerUpData{
    
    if (_number ==40) {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"到底啦!!!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        
        return;
    }
    
    //请求数据
    [[FunManager sharedInstance] getDataWithUrl:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1348654151579/%d0-20.html",_number+2] Result:^(NSDictionary * dic) {
        
        self.allDataArray = dic[@"T1348654151579"];
        self.followDataArray = _allDataArray;
        
        for (NSDictionary * dic in self.followDataArray) {
            TModel * model = [[TModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.followArray addObject:model];
        }
        
        [self.TFollowView reloadData];
         //尾部部刷新结束
    [self.TFollowView footerEndRefreshing];
        
    }];
   
    
    _number = _number+2;
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.followArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TModel *model =self.followArray[indexPath.row];
    
    
    if ( model.imgextra ==nil ) {
        
        UINib * nib = [UINib nibWithNibName:@"TFollowTableViewCell" bundle:nil];
        [self.TFollowView registerNib:nib forCellReuseIdentifier:@"mycell"];
        TFollowTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
  
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
        
    }else if ( model.imgextra !=nil ){
        
        UINib * nib = [UINib nibWithNibName:@"TFollowListTableViewCell" bundle:nil];
        [self.TFollowView registerNib:nib forCellReuseIdentifier:@"mycellOnePicture"];
        TFollowListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycellOnePicture" forIndexPath:indexPath];
  
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
    TModel *model =self.followArray[indexPath.row];
    
 
    if ( model.imgextra ==nil){
        return 125;
    }else if ( model.imgextra !=nil){
        return 150;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
 
        TModel *model =self.followArray[indexPath.row];
    
    if ( model.imgextra ==nil ) {
        
        
    TFollowListViewController * TFollowListVC = [[TFollowListViewController alloc]init];
    
 
        [self.navigationController pushViewController:TFollowListVC animated:YES];
        
        model = self.followArray[indexPath.row];
        
        TFollowListVC.model =model;
        
        
        
    }else if ( model.imgextra !=nil ){
        

    }

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"4.jpg"];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.TFollowView setBackgroundView:imageView];

}
- (IBAction)didJumpToFun:(UIButton *)sender {
    
   
    
    TFunViewController * TFunVC = [[TFunViewController alloc]init];
    
    [self.navigationController pushViewController:TFunVC animated:YES];
    
}

- (IBAction)didJumpToJoke:(UIButton *)sender {
    
  
    
    TJokeViewController * TJokeVC = [[TJokeViewController alloc]init];
    
    [self.navigationController pushViewController:TJokeVC animated:YES];
    
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
