//
//  TJokeViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TJokeViewController.h"

#import "TJokeTableViewCell.h"
#import "TJokePicTableViewCell.h"

#import "TFunViewController.h"
#import "TFollowViewController.h"
#import "TPictureViewController.h"

#import "FunManager.h"
@interface TJokeViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)NSMutableArray * jokeDataArray;//存放首页数据

@property(nonatomic,strong)NSMutableArray * jokeArray;//存放模型

//存放所有数据
@property (nonatomic, strong)NSMutableArray *allDataArray;




@end

@implementation TJokeViewController


//懒加载
-(NSMutableArray *)jokeDataArray{
    if (!_jokeDataArray) {
        _jokeDataArray = [NSMutableArray array];
    }
    return _jokeDataArray;
}

- (NSMutableArray *)jokeArray{
    if (!_jokeArray) {
        _jokeArray = [NSMutableArray array];
    }
    return _jokeArray;
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
    
    
     self.navigationItem.title = @"段子";
    
    self.JokeTableView.delegate = self;
    self.JokeTableView.dataSource = self;
    
   
    [self upData];
    
}


- (void)upData{
    //添加头部控件的方法
    [self.JokeTableView addHeaderWithTarget:self action:@selector(headerUpData)];
    
    //添加尾部控件的方法
    [self.JokeTableView addFooterWithTarget:self action:@selector(footerUpData)];
    
    [self.JokeTableView headerBeginRefreshing];
    
}

- (void)headerUpData{
    //请求数据
    [[FunManager sharedInstance] getDataWithUrl:@"http://c.3g.163.com/recommend/getChanListNews?passport=&devId=869579010953274&size=20&channel=duanzi " Result:^(NSDictionary * dic) {
        
        [self.jokeArray removeAllObjects];
        
        self.allDataArray = dic[@"段子"];
        self.jokeDataArray = _allDataArray;
        
        for (NSDictionary * dic in self.jokeDataArray) {
            JokeModel * model = [[JokeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.jokeArray addObject:model];
        }
        
        [self.JokeTableView reloadData];
        
        //头部刷新结束
        [self.JokeTableView headerEndRefreshing];
    }];
    
}

- (void)footerUpData{
    
    
    //请求数据
    [[FunManager sharedInstance] getDataWithUrl:[NSString stringWithFormat:@"http://c.3g.163.com/recommend/getChanListNews?passport=&devId=869579010953274&size=20&channel=duanzi "] Result:^(NSDictionary * dic) {
        
        self.allDataArray = dic[@"段子"];
        self.jokeDataArray = _allDataArray;
        
        for (NSDictionary * dic in self.jokeDataArray) {
            JokeModel * model = [[JokeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.jokeArray addObject:model];
        }
        
        [self.JokeTableView reloadData];
    }];
    //尾部部刷新结束
    [self.JokeTableView footerEndRefreshing];
    
   
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jokeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeModel * jokeModel = self.jokeArray[indexPath.row];
    
    
    if (jokeModel.img != nil) {
        
        UINib * nib = [UINib nibWithNibName:@"TJokeTableViewCell" bundle:nil];
        [self.JokeTableView registerNib:nib forCellReuseIdentifier:@"TJokeCell"];
        
        TJokeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TJokeCell" forIndexPath:indexPath];
    
            cell.jokeModel = jokeModel;
       

        //取消选中颜色
        
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        //取消边框线
        
        [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];

        return cell;

    } else {
        UINib * nib = [UINib nibWithNibName:@"TJokePicTableViewCell" bundle:nil];
        [self.JokeTableView registerNib:nib forCellReuseIdentifier:@"TJokePicCell"];
        TJokePicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TJokePicCell" forIndexPath:indexPath];
      
            cell.jokeModel = jokeModel;
 
        
        //取消选中颜色
        
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView = backView;
        cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        //取消边框线
        
        [cell setBackgroundView:[[UIView alloc] init]];          //取消边框线
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
 
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeModel * jokeModel = self.jokeArray[indexPath.row];
    
    if (jokeModel.img != nil) {
        
        
        TJokeTableViewCell * cell = [[TJokeTableViewCell alloc]init];
    CGFloat height = [cell getTextLabelHeight:jokeModel.digest];
        
        return 500+height;
    } else {
        
        TJokePicTableViewCell * cell = [[TJokePicTableViewCell alloc]init];
        CGFloat height = [cell getTextLabelHeight:jokeModel.digest];
        
        return 150+height;
    }
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.JokeTableView setBackgroundView:imageView];
    
}





- (IBAction)didJumpToFun:(UIButton *)sender {
    
   
    
    TFunViewController * TFunVC = [[TFunViewController alloc]init];
    
    [self.navigationController pushViewController:TFunVC animated:YES];
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
