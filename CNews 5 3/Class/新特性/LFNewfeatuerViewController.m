//
//  LFNewfeatuerViewController.m
//  微博
//
//  Created by lanou3g on 15/8/15.
//  Copyright (c) 2015年 路飞. All rights reserved.
//
#define NewfeatuerContent 2
#import "LFNewfeatuerViewController.h"
#import "NewsViewController.h"
#import "LFTabBarViewController.h"
@interface LFNewfeatuerViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong)UIPageControl * pagcontrol;
@end

@implementation LFNewfeatuerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     //设置scrollView
    [self setupScrollView];
    //添加pageController
    [self setuppageController];
    
}
-(void)setuppageController{
    CGFloat centerX= self.view.frame.size.width* 0.5;
    CGFloat centerY =self.view.frame.size.height -30;
    UIPageControl * pagcontrol = [[UIPageControl alloc] init];
    pagcontrol.center =CGPointMake(centerX,centerY);
    pagcontrol.bounds = CGRectMake(0, 0, 100, 20);
    pagcontrol.numberOfPages =NewfeatuerContent;

    [self.view addSubview:pagcontrol];
    //添加原点选中的颜色
    pagcontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
    //未选中的颜色
    pagcontrol.pageIndicatorTintColor = [UIColor grayColor];
    //默认选中哪一个
    pagcontrol.currentPage = 0;
    self.pagcontrol = pagcontrol;
    
    //点击原点市区作用
    pagcontrol.userInteractionEnabled = NO;
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
}


//添加 //设置scrollView
-(void)setupScrollView{
    //设置scrollView
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    //设置scrollView的尺寸大小
    scrollView.contentSize = CGSizeMake(NewfeatuerContent *imageW , imageH);
    //增加图片
    for (int index = 0; index<NewfeatuerContent; index++) {
        // [UIImage imageNamed]
        NSString * name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
        imageView.frame=CGRectMake(index * imageW, 0, imageW,imageH );
        [scrollView addSubview:imageView];
        if (index == NewfeatuerContent-1) {
            [self setupLastImageView:imageView];
        }
    }
    

    self.scrollView = scrollView;
    //去掉滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //去掉弹性
    scrollView.bounces = NO;
    //分页效果
    scrollView.pagingEnabled = YES;
    //背景颜色
    scrollView.backgroundColor = [UIColor whiteColor];
    
    
//设置代理
    scrollView.delegate = self;
}

/**
 *  在最后一个View上增加Button
 *
 *  @param imageView 最后一个view
 */
-(void)setupLastImageView:(UIImageView *)imageView{
 [self setBackgroundImage:@"new_feature_finish_button" HighlightedImageName:@"new_feature_finish_button_highlighted" setTitleName:@"开始体验" setTitleColor:[UIColor blackColor] ViewControlter:imageView ];
    //添加checkbox
    CGFloat checkboxButtonX= imageView.frame.size.width* 0.5;
    CGFloat checkboxButtonY =imageView.frame.size.height*0.7;
    UIButton * checkboxButton =[[UIButton alloc] init];
    //让chechboxButton默认为选中
    checkboxButton.selected = YES;
    [checkboxButton setTitle:@"" forState:UIControlStateNormal];
    [checkboxButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkboxButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkboxButton .bounds = CGRectMake(0, 0, 200, 50);
    checkboxButton.titleLabel.font = [UIFont systemFontOfSize:15];
    checkboxButton.center= CGPointMake(checkboxButtonX, checkboxButtonY-50);
    [checkboxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkboxButton addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkboxButton];
    
    //button的几个属性
    //文字里上下左右的距离
    checkboxButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    
}

-(void)checkClick:(UIButton *)button{
    button.selected= !button.isSelected;


}
//封装
-(UIButton *)setBackgroundImage:(NSString*)image HighlightedImageName:(NSString *)highlightName setTitleName:(NSString *)stetitleName setTitleColor:(UIColor *)color ViewControlter:(UIImageView *)imageView{
       UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    [button setTitle:stetitleName forState:UIControlStateNormal];
    [button setTitleColor:color  forState:UIControlStateNormal];
    CGFloat centerX= imageView.frame.size.width* 0.5;
    CGFloat centerY =imageView.frame.size.height*0.9;
    button.center =CGPointMake(centerX,centerY);
    imageView.userInteractionEnabled = YES;
    button.bounds =(CGRect){CGPointZero,button.currentBackgroundImage.size};
    [imageView addSubview:button];
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
     button.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    return button;

}
-(void)start{

    self.view.window.rootViewController = [[LFTabBarViewController alloc] init];
}

//- (void)dealloc
//{
//    NSLog(@"pppp");
//}

#pragma mark--------实现ScrollView的代理方法
//只要scrollView调用就会调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offfsetX=  self.scrollView.contentOffset.x;
    double indexdouble = offfsetX/self.view.frame.size.width;
    int index = (int)(indexdouble  +0.5);
    self.pagcontrol.currentPage = index;
}


@end
