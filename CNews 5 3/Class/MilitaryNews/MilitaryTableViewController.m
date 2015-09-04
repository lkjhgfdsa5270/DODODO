//
//  MilitaryTableViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "MilitaryTableViewController.h"
#import "GDataXMLNode.h"
#import "PELabelTableViewCell.h"
#import "DataHandle.h"
#import "PETableViewCell.h"
#import "DetailsPageViewController.h"
@interface MilitaryTableViewController ()
{
    int _loadNumber;
    BOOL _isload;
}
@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,assign)CGPoint starPoint;
@end

@implementation MilitaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建数组接收模型对象
    self.array=[NSMutableArray array];
    
    _loadNumber=1;
    
    _isload=YES;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upFram:) name:@"Notificationloading" object:nil];
   
    [self requestData];
}
//加载数据
-(void)upFram:(NSNotification*)notification{
    
   // [self requestData];
    int index = [notification.userInfo[@"key"] intValue];
    if (index >=1 &index <2) {
        if (_isload) {
            
            [self upData];
                _isload=NO;
        }

       }
    }


//布局--更新加载
-(void)upData{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView headerBeginRefreshing];
}
//头部刷新
-(void)headerRereshing{
    if (_loadNumber==1) {
    }else{
        _loadNumber=1;
    }
    [self requestData];//数据请求
}
//尾部刷新
-(void)footerRereshing{
    
    _loadNumber++;
    if (_loadNumber<20) {
        
        [self requestData];//加载更多数据
    }else{
        [self.tableView footerEndRefreshing];//尾部刷新结束
      
    }
}


//请求数据放入数组

-(void)requestData{
    
    [[DataHandle shardataHandle] requestUrl:[NSString stringWithFormat:@"http://ku.m.chinanews.com/forapp/cl/gj/newslist_%d.xml",_loadNumber] requestDataDidfinish:^(NSMutableArray *dataArry) {
        _array = dataArry;
        [self.tableView reloadData];

             }];
    

        [self.tableView headerEndRefreshing];//头部刷新结束
        [self.tableView footerEndRefreshing];//尾部刷新结束
        
    
    }





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _array.count;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    UIImage * iamge = [UIImage imageNamed:@"wer.jpg"];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = iamge;
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.tableView setBackgroundView:imageView];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    Model*m=_array[indexPath.row];
    if ([m.img isEqualToString:@""]) {
        
        //只有文字
        PELabelTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[[PELabelTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.PElabelTitle.text=m.title;
        
        //改变 lable 的 frame
        CGRect temp=cell.PElabelTitle.frame;
        temp.size.height=[self p_HightWithstring:m.title];
        cell.PElabelTitle.frame=temp;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        //文字和图片
        PETableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"second"];
        if (cell==nil) {
            cell=[[PETableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"second"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.PETitle.text=m.title;
        [cell.PEImageView sd_setImageWithURL:[NSURL URLWithString:m.img]];
        
        
        
        //改变 lable 的 frame
        CGRect temp=cell.PETitle.frame;
        temp.size.height=[self p_PicHightWithstring:m.title];
        cell.PETitle.frame=temp;
        
        cell.backgroundColor =[UIColor clearColor];
        return cell;
        
    }
}

//计算文字高度方法(只有文字)
-(CGFloat)p_HightWithstring:(NSString*)s{
    CGRect r=[s boundingRectWithSize:CGSizeMake(SCREEN.size.width-10, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    return r.size.height;
}

//计算文字高度方法(图片和文字)
-(CGFloat)p_PicHightWithstring:(NSString*)s{
    CGRect r=[s boundingRectWithSize:CGSizeMake(SCREEN.size.width-5-100-10-5, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]} context:nil];
    return r.size.height;
}

//cell 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Model*m=_array[indexPath.row];
    
    if ([m.img isEqualToString:@""]) {
        //只有文字
        return 20+[self p_HightWithstring:m.title];
        
    } else {
        
        return 80;
    }
}

//点击模态详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Model*m=_array[indexPath.row];
    DetailsPageViewController*gameDitalVC=[[DetailsPageViewController alloc] init];
    gameDitalVC.url=m.toUrl;
    gameDitalVC.title1=m.title;
    UINavigationController*gameNVC=[[UINavigationController alloc] initWithRootViewController:gameDitalVC];
    //模态动画推出
    gameNVC.modalPresentationStyle = UIModalPresentationFormSheet;
    gameNVC.modalTransitionStyle  = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:gameNVC animated:YES completion:^{
        
    }];
}

@end
