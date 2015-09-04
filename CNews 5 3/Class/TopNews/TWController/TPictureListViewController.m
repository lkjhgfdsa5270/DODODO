//
//  TPictureListViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TPictureListViewController.h"

#import "SDCycleScrollView.h"

@interface TPictureListViewController ()

@end

@implementation TPictureListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    NSMutableArray * array = [NSMutableArray array];
    
        for (int i = 0; i<self.picModel.pics.count; i++) {
            [array addObject: self.picModel.pics[i]];
        }
    
    
    CGFloat width = [[UIScreen mainScreen]bounds].size.width ;
    
    NSArray *imagesURLStrings = @[self.picModel.cover,self.picModel.clientcover,self.picModel.clientcover1,array[0],array[1],array[2]];

    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 70, width, [[UIScreen mainScreen]bounds].size.height-250) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    cycleScrollView2.titlesGroup = nil;
    
    cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:cycleScrollView2];
    
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });

    
  
        [self.TPicListView addSubview:cycleScrollView2];
        
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
