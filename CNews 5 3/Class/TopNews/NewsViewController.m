//
//  NewsViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "NewsViewController.h"
#import "MilitaryTableViewController.h"




#import "MilitaryTableViewController.h"

#import "NewsRootTableViewController.h"
#import "STTableViewController.h"
#import "Financial1TableViewController.h"
#import "TitleSegmentedControl.h"
#import "TravelTableViewController.h"
#import "CarTableViewController.h"
#define NewsViewControllerContent 3
#define kscrollViewSegH 35
#define kMyViewW 50
#define kScrollW CGRectGetWidth(_scrollView.frame)
#define kScrollH CGRectGetHeight(_scrollView.frame)
@interface NewsViewController ()<UIScrollViewDelegate>

@property(nonatomic,assign)CGFloat imageW ;
@property(nonatomic,assign)CGFloat imageH;


@property(nonatomic,strong)MilitaryTableViewController * militaryTVC;


@property(nonatomic,strong)STTableViewController * sttVC;
@property(nonatomic,strong)TitleSegmentedControl * titSegment;
@property(nonatomic,strong)Financial1TableViewController * financVC;
@property(nonatomic,strong)TravelTableViewController * traveVC;
@property(nonatomic,strong)CarTableViewController * carVC;
@property(nonatomic,strong)NewsRootTableViewController * NewVC;
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,strong)UIScrollView * titleSC;
@property(nonatomic,assign) CGPoint MovePoint;
@property(nonatomic,assign)  CGFloat indexY;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //navigationBar 颜色
    //[self.navigationController.navigationBar setBarTintColor:[UIColor coffeeColor]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tdf.jpg"] forBarMetrics:UIBarMetricsDefault];
    //让 tableView 的 fram在 navigationbar 下面
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor purpleColor];
    [self p_scrollViewTableView];
    [self p_tableView];
    
   [self createScrollViewSegment];//创建segment
    
}

//布局scrollView用于添加TableView
-(void)p_scrollViewTableView{
    
    self.scrollView=[[UIScrollView alloc] init];
    _scrollView.frame=CGRectMake(0,30, SCREEN.size.width, SCREEN.size.height-64-49-30);
    _scrollView.contentSize=CGSizeMake(kScrollW*6, kScrollH);
    _scrollView.bounces=NO;//边界回弹
    _scrollView.bouncesZoom=NO;
    _scrollView.alwaysBounceHorizontal=NO;
    _scrollView.alwaysBounceVertical=NO;
    _scrollView.pagingEnabled=YES;
    
    _scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_scrollView];
    _scrollView.delegate=self;
}

//布局 tableView
-(void)p_tableView{
    
    //1头条
    self.NewVC=[[NewsRootTableViewController alloc] init];
    _NewVC.tableView.frame=CGRectMake(kScrollW*1, 0, kScrollW, kScrollH);
    [self addChildViewController:self.NewVC];
    [self.scrollView addSubview:self.NewVC.tableView];
    //2军事
    self.militaryTVC=[[MilitaryTableViewController alloc] init];
    _militaryTVC.tableView.frame=CGRectMake(kScrollW*1, 0, kScrollW, kScrollH);
    [self addChildViewController:self.militaryTVC];
    [self.scrollView addSubview:self.militaryTVC.tableView];
    //体育
    self.sttVC = [[STTableViewController alloc] init];
    _sttVC.tableView.frame =CGRectMake(kScrollW*2, 0, kScrollW, kScrollH);
    [self addChildViewController:self.sttVC];
    [self.scrollView addSubview:self.sttVC.tableView];

    
    //财政
    self.financVC = [[Financial1TableViewController alloc] init];
    _financVC.tableView.frame =CGRectMake(kScrollW*3, 0, kScrollW, kScrollH);
    [self addChildViewController:self.financVC];
    [self.scrollView addSubview:self.financVC.tableView];
    //旅游
    self.traveVC = [[TravelTableViewController alloc] init];
    _traveVC.tableView.frame =CGRectMake(kScrollW*4, 0, kScrollW, kScrollH);
    [self addChildViewController:self.traveVC];
    [self.scrollView addSubview:self.traveVC.tableView];

    
    //汽车
    self.carVC =[[CarTableViewController alloc] init];
    _carVC .tableView.frame=CGRectMake(kScrollW*5, 0, kScrollW, kScrollH);
    [self addChildViewController:self.carVC];
    [self.scrollView addSubview:self.carVC.tableView];
    
}
-(void)createScrollViewSegment{
    UIScrollView * titleSC = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN.size.width, kscrollViewSegH)];
    self.titleSC= titleSC;
    [self.view addSubview:titleSC];
    titleSC.contentSize = CGSizeMake(CGRectGetWidth(_titleSC.frame)*2, CGRectGetHeight(_titleSC.frame));
    _titleSC.bounces=NO;//边界回弹
    _titleSC.bouncesZoom=NO;
    _titleSC.alwaysBounceHorizontal=NO;
    _titleSC.alwaysBounceVertical=NO;
    [_titleSC setShowsHorizontalScrollIndicator:NO];
    
// _titleSC.backgroundColor=[UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:titleSC.bounds];
    imageView.image = [UIImage imageNamed:@"wer.jpg"];
    [self.view addSubview:imageView];
    _titleSC.delegate = self;
    TitleSegmentedControl * titSegment = [[TitleSegmentedControl alloc] initWithItems:@[@"头条",@"国际",@"科技",@"财经",@"旅游",@"汽车"]];
    titSegment.frame = CGRectMake(0, 0, CGRectGetWidth(_titleSC.frame), kscrollViewSegH);
    self.titSegment = titSegment;
    imageView.userInteractionEnabled  = YES;
    [imageView addSubview:titSegment];
    //titSegment的点击事件
    
    [titSegment addTarget:self action:@selector(didClickChangePage:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)didClickChangePage:(UISegmentedControl *)sement{

    NSNumber * number = [NSNumber numberWithFloat:_titSegment.selectedSegmentIndex];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:number,@"index", nil];
    if (dic[@"index"] == number) {
        NSLog(@"%@",number);
      _indexY =  SCREEN.size.width * [number floatValue];
        NSDictionary * dict=@{@"key":@(_indexY)};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notificationloading" object:self userInfo:dict];
        _scrollView.contentOffset = CGPointMake(SCREEN.size.width * [number floatValue], 0);
       
    }
 ;
}


//记录手指移动距离 用通知传值
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offfsetX=  self.scrollView.contentOffset.x;
    double indexdouble = offfsetX/self.view.frame.size.width;
    int index = (int)(indexdouble  +0.5);
    NSLog(@"======%d",index);
   NSDictionary * dict=@{@"key":@(index)};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notificationloading" object:self userInfo:dict];
    _titSegment.selectedSegmentIndex = index;
    
}


@end
