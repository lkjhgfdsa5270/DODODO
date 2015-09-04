//
//  STTableViewController.m
//  BanBen2
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "STTableViewController.h"
#import "RETableViewCell.h"
@interface STTableViewController ()

{
    int _loadNumber;
    BOOL _isload;
}

@property(nonatomic,strong)NSMutableArray*arrayID;
@property(nonatomic,strong)NSMutableArray*arrayTitle;
@property(nonatomic,strong)NSMutableArray*arrayPic;
@property(nonatomic,strong)NSMutableArray * snArray;
@property(nonatomic,strong)NSMutableArray * sArray;
@property(nonatomic,strong)NSMutableArray * snIDArray;
@property(nonatomic,assign)CGPoint starPoint;

@end

@implementation STTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建数组接收对象数据
    self.arrayID=[NSMutableArray array];
    self.arrayTitle=[NSMutableArray array];
    self.arrayPic=[NSMutableArray array];
    
    _loadNumber=1;//加载数据时的页码数
    _isload=YES;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upFram:) name:@"Notificationloading" object:nil];
}
    //加载数据
-(void)upFram:(NSNotification*)notification{
        
        int index = [notification.userInfo[@"key"] intValue];
        if (index >=2 &index <3) {
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
    if (_loadNumber<9) {
        
        [self requestData];//加载更多数据
    }else{
        [self.tableView footerEndRefreshing];//尾部刷新结束
      
    }
}

-(void)requestData{
    NSString*stringUrl=[NSString stringWithFormat:@"http://api.m.jiemian.com/article/cate/123.json?page=%d",_loadNumber];
    self.snArray = [NSMutableArray array];
    self.sArray = [NSMutableArray array];
    self.snIDArray = [NSMutableArray array];

    [RequestTool requestWithUrl:stringUrl body:nil backValue:^(NSData *value) {
        if (!value) {
            [[DataHandle shardataHandle]tipboxNetwork];
           
        }else{
            //头部请求时清空之前数据
            if (_loadNumber==1) {
                [_arrayID removeAllObjects];
                [_arrayTitle removeAllObjects];
                [_arrayPic removeAllObjects];
            }
            
            NSDictionary*dict=[NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            NSMutableArray * array =dict[@"result"][@"rst"];
            
            for (int i=0; i< array.count; i++) {
                if (i<3) {
                    [_sArray addObject:array[i][@"title"]];
                    [_snArray addObject:array[i][@"z_image"]];
                    [_snIDArray addObject:array[i][@"id"]];
                    NSLog(@"nnnnnnnnnnnn%@",_snArray);
                }else{
                    
                    [_arrayID addObject:array[i][@"id"]];
                    [_arrayTitle addObject:array[i][@"title"]];
                    [_arrayPic addObject:array[i][@"z_image"]];
                    
                }
            }
            [self loadimageCarouselfigure];
        }
        [self.tableView headerEndRefreshing];//头部刷新结束
        [self.tableView footerEndRefreshing];//尾部刷新结束
        
        [self.tableView reloadData];
        
    }];
}
////轮播图数据和布局
-(void)loadimageCarouselfigure{
    
    NSString * str= _sArray[1];
    NSString * str1 = _sArray[2];
    NSString * str2 = _sArray[0];
    NSString * image = _snArray[1];
    NSString * image1 = _snArray[2];
    NSString * image2 = _snArray[0];
    
    
    
    
    [[DataHandle shardataHandle] Carouselfigure:self.tableView delegate:self ModelImage:image ModelName:str ModelI1mage:image1 Model1Name:str1 Model2Image:image2 Model2Name:str2 Height: ImageH+50];
}

//轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    DetailsPageViewController* detail = [[DetailsPageViewController alloc] init];
    
    
    
    detail.url = [NSString stringWithFormat:@"http://m.jiemian.com/article/%@.html",_snIDArray[index]];
    
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:NC animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayTitle.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RETableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[RETableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.RETitle.text=_arrayTitle[indexPath.row];
    [cell.REImageView sd_setImageWithURL:[NSURL URLWithString:_arrayPic[indexPath.row]]];
    
    //改变 lable 的 frame
    CGRect temp=cell.RETitle.frame;
    temp.size.height=[self p_HightWithstring:_arrayTitle[indexPath.row]];
    cell.RETitle.frame=temp;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ImageH+15+[self p_HightWithstring:_arrayTitle[indexPath.row]];
}

//计算文字高度方法(只有文字)
-(CGFloat)p_HightWithstring:(NSString*)s{
    CGRect r=[s boundingRectWithSize:CGSizeMake(SCREEN.size.width-10, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]} context:nil];
    return r.size.height;
}

//点击模态详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsPageViewController*DitalVC=[[DetailsPageViewController alloc] init];
    DitalVC.title1=_arrayTitle[indexPath.row];
    DitalVC.url=[NSString stringWithFormat:@"http://m.jiemian.com/article/%@.html",_arrayID[indexPath.row]];
    
    UINavigationController*DitalNVC=[[UINavigationController alloc] initWithRootViewController:DitalVC];
    //模态动画推出
    DitalNVC.modalPresentationStyle = UIModalPresentationFormSheet;
    DitalNVC.modalTransitionStyle  = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:DitalNVC animated:YES completion:^{
        
    }];
}






@end
