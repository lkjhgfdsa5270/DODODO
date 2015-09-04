//
//  Financial1TableViewController.m
//  BanBen2
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "Financial1TableViewController.h"
#import "RESmallPicTableViewCell.h"
@interface Financial1TableViewController ()
{
    int _loadNumber;
    BOOL _isload;
}

@property(nonatomic,strong)NSMutableArray*arrayID;
@property(nonatomic,strong)NSMutableArray*arrayTitle;
@property(nonatomic,strong)NSMutableArray*arrayPic;

@property(nonatomic,assign)CGPoint starPoint;

@end

@implementation Financial1TableViewController

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
    if (index >=3 &index <4) {
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
    NSString*stringUrl=[NSString stringWithFormat:@"http://api.m.jiemian.com/article/cate/137.json?page=%d",_loadNumber];
    
    [RequestTool requestWithUrl:stringUrl body:nil backValue:^(NSData *value) {
        if (!value) {
            [[DataHandle shardataHandle] tipboxNetwork];
           
        }else{
            //头部请求时清空之前数据
            if (_loadNumber==1) {
                [_arrayID removeAllObjects];
                [_arrayTitle removeAllObjects];
                [_arrayPic removeAllObjects];
            }
            
            NSDictionary*dict=[NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            for (NSDictionary*d in dict[@"result"][@"rst"]) {
                [_arrayID addObject:d[@"id"]];
                [_arrayTitle addObject:d[@"title"]];
                [_arrayPic addObject:d[@"z_image"]];
                NSLog(@"%@44444444444444",_arrayID);
            }
            
        }
        [self.tableView headerEndRefreshing];//头部刷新结束
        [self.tableView footerEndRefreshing];//尾部刷新结束
        
        [self.tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrayTitle.count;
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
    RESmallPicTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
        cell=[[RESmallPicTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.RETitle.text=_arrayTitle[indexPath.row];
    [cell.REImageView sd_setImageWithURL:[NSURL URLWithString:_arrayPic[indexPath.row]]];
    
    //改变 lable 的 frame
    CGRect temp=cell.RETitle.frame;
    temp.size.height=[self p_HightWithstring:_arrayTitle[indexPath.row]];
    cell.RETitle.frame=temp;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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

//记录手指移动距离 用通知传值
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _starPoint.y=scrollView.contentOffset.y;
    //    Dlog(@"开始拖拽中%f",_starPoint.y);
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint movePoint=scrollView.contentOffset;
    CGFloat detalY=_starPoint.y-movePoint.y;
    NSNumber*number=[NSNumber numberWithFloat:detalY];
    
    NSMutableDictionary*dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:number,@"key", nil];
    
    NSNotification *notification =[NSNotification notificationWithName:@"通知" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    //    Dlog(@"拖拽中%f",detalY);
}

@end
