//
//  TPictureViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TPictureViewController.h"
#import "TPictureTableViewCell.h"
#import "TPictureListViewController.h"


#import "TFunViewController.h"
#import "TJokeViewController.h"
#import "TFollowViewController.h"


#import "FunManager.h"
@interface TPictureViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * picDataArray;//存放首页数据

@property(nonatomic,strong)NSMutableArray * picArray;//存放模型

//存放所有数据
@property (nonatomic, strong)NSMutableArray *allDataArray;

@property(nonatomic,assign)int number;




@end

@implementation TPictureViewController

//懒加载
-(NSMutableArray *)picDataArray{
    if (!_picDataArray) {
        _picDataArray = [NSMutableArray array];
    }
    return _picDataArray;
}

- (NSMutableArray *)picArray{
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
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
   
    self.navigationItem.title = @"图片";
    
    self.TPictureView.delegate = self;
    self.TPictureView.dataSource = self;
    
    self.number = 0;
    
    [self upData];
}

- (void)upData{
    //添加头部控件的方法
    [self.TPictureView addHeaderWithTarget:self action:@selector(headerUpData)];
    
    //添加尾部控件的方法
    [self.TPictureView addFooterWithTarget:self action:@selector(footerUpData)];
    
    [self.TPictureView headerBeginRefreshing];
    
}

- (void)headerUpData{
    //请求数据
    [[FunManager sharedInstance] getArrayDataWithUrl:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/morelist/0096/4GJ60096/%@.json",@"74657"] Result:^(NSMutableArray *array) {
        
        [self.picArray removeAllObjects];
        
        for (NSDictionary * dic in array) {
            PicModel * picModel = [[PicModel alloc]init];
            [picModel setValuesForKeysWithDictionary:dic];
            [self.picArray addObject:picModel];
        }
        [self.TPictureView reloadData];
        
           //头部刷新结束
     [self.TPictureView headerEndRefreshing];
    }];
 
    
}

- (void)footerUpData{
    
    if (_number ==22) {
        UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"到底啦!!!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
       
        return;
    }
    
    
    NSArray * array = @[@"74609",@"74307",@"74232",@"74221",@"74208",@"74191",@"74180",@"74169",@"74158",@"741147",@"14132",@"74116",@"74106",@"73984",@"74096",@"74081",@"74064",@"74052",@"74041",@"774030",@"74017"];
    
        //请求数据
        [[FunManager sharedInstance] getArrayDataWithUrl:[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/morelist/0096/4GJ60096/%@.json",array[_number]] Result:^(NSMutableArray *array) {
            
            for (NSDictionary * dic in array) {
                PicModel * picModel = [[PicModel alloc]init];
                [picModel setValuesForKeysWithDictionary:dic];
                [self.picArray addObject:picModel];
            }
            [self.TPictureView reloadData];
            
        }];
        //尾部部刷新结束
        [self.TPictureView footerEndRefreshing];

    _number=_number+1;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.picArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PicModel * picModel = self.picArray[indexPath.row];
    
    UINib * nib = [UINib nibWithNibName:@"TPictureTableViewCell" bundle:nil];
    [self.TPictureView registerNib:nib forCellReuseIdentifier:@"TPictureCell"];
    
    TPictureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TPictureCell" forIndexPath:indexPath];
    
         cell.picModel = picModel;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PicModel * picModel = self.picArray[indexPath.row];
      
    TPictureListViewController * TPictureListVC = [[TPictureListViewController alloc]init];

    TPictureListVC.picModel = picModel;
    if (picModel.pics.count > 0) {
         [self.navigationController pushViewController:TPictureListVC animated:YES];
    }
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"5.jpg"];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.TPictureView setBackgroundView:imageView];

}



- (IBAction)didJumpToFun:(UIButton *)sender {
    
    TFunViewController * TFunVC = [[TFunViewController alloc]init];
    
    [self.navigationController pushViewController:TFunVC animated:YES];
  
}

- (IBAction)didJumpToJoke:(UIButton *)sender {
    
    TJokeViewController * TJokeVC = [[TJokeViewController alloc]init];
    
    [self.navigationController pushViewController:TJokeVC animated:YES];
    
}

- (IBAction)didJumpToFollow:(UIButton *)sender {
    
    TFollowViewController * TFollowVC = [[TFollowViewController alloc]init];
    
    [self.navigationController pushViewController:TFollowVC animated:YES];
  
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
