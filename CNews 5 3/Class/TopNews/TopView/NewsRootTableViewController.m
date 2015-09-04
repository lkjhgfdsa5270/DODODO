//
//  NewsRootTableViewController.m
//  BanBen2
//
//  Created by lanou3g on 15/8/1.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "NewsRootTableViewController.h"
#import "Model.h"

#import "NewsTableViewCell.h"
#import "NewsPicTableViewCell.h"
#import "NewsLoopTableViewCell.h"

#import "GDataXMLNode.h"
#define kLoopH 150
//#define kHomeUrl @"http://ku.m.chinanews.com/forapp/cl/yw/newslist_%d.xml"
#define kLoopURL  @"http://api.sina.cn/sinago/list.json?uid=e3898136fba05a35&loading_ad_timestamp=0&platfrom_version=4.4.4&wm=b207&imei=863360020255307&from=6048095012&connection_type=2&chwm=14010_0001&AndroidID=a8ef68441a4d3f720221bc063ae748c9&v=1&s=20&IMEI=c2001c3d0d18a136aa352a080420aa14&p=1&MAC=11c75cd60e19855cfba86fc727f601ff&channel=news_toutiao"

@interface NewsRootTableViewController ()<SDCycleScrollViewDelegate>
{
    int _loadNumber;
}

@property(nonatomic,strong)NSMutableArray*array;
@property(nonatomic,strong)NSMutableArray*arr;
@property(nonatomic,strong)NSMutableArray*arrayLoopTitle;
@property(nonatomic,strong)NSMutableArray*arrayLoopPic;
@property(nonatomic,strong)NSMutableArray*arrayLoopUrl;

@property(nonatomic,strong)SDCycleScrollView*cycleScrollView;
@property(nonatomic,assign)CGPoint starPoint;

@end

@implementation NewsRootTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.array=[NSMutableArray array];//创建数组接收模型对象
    self.arrayLoopTitle=[NSMutableArray array];
    self.arrayLoopPic=[NSMutableArray array];
    self.arrayLoopUrl=[NSMutableArray array];
    
    
    _loadNumber=1;
    
    //布局--更新加载
    [self upData];
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
        [self requestLoopData];//请求轮播图数据
        [self requestData];//数据请求
    }else{
        _loadNumber=1;
        [self requestLoopData];//请求轮播图数据
        [self requestData];//数据请求
    }
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

//请求数据放入数组
-(void)requestData{
    NSString*stringUrl=[NSString stringWithFormat:@"http://ku.m.chinanews.com/forapp/cl/yw/newslist_%d.xml",_loadNumber];
//    Dlog(@"%d",_loadNumber);
    [RequestTool requestWithUrl:stringUrl body:nil backValue:^(NSData *value) {
        if (!value) {
                       [[DataHandle shardataHandle] tipboxNetwork];
            
        }else{
            //头部请求时清空之前数据
            if (_loadNumber==1) {
                [_array removeAllObjects];
            }
            
            GDataXMLDocument*xmlDocument=[[GDataXMLDocument alloc] initWithData:value options:0 error:nil];
            GDataXMLElement*rootElement=xmlDocument.rootElement;
            
            for (GDataXMLElement*subElement in rootElement.children) {
                Model*m=[[Model alloc] init];//创建模型
                for (GDataXMLElement*elment in subElement.children) {
                    [m setValue:elment.stringValue forKey:elment.name];
                }
                [_array addObject:m];//把模型放入数组
            }
        }
        [self.tableView headerEndRefreshing];//头部刷新结束
        [self.tableView footerEndRefreshing];//尾部刷新结束
        //请求完数据后修改 fram 让请求数据的图片消失
        self.tableView.frame=CGRectMake(0, 0, SCREEN.size.width, SCREEN.size.height);
        [self.tableView reloadData];
    }];
}
//请求轮播图数据
-(void)requestLoopData{
    NSString*stringUrl=kLoopURL;
    [RequestTool requestWithUrl:stringUrl body:nil backValue:^(NSData *value) {
        if (!value) {
           
        }else{
            [_arrayLoopTitle removeAllObjects];
            [_arrayLoopPic removeAllObjects];
            [_arrayLoopUrl removeAllObjects];
            
            NSDictionary*dict=[NSJSONSerialization JSONObjectWithData:value options:(NSJSONReadingAllowFragments) error:nil];
            for (int i=0; i<4; i++) {
                
                [_arrayLoopTitle addObject:dict[@"data"][@"list"][i][@"title"]];
                [_arrayLoopPic addObject:dict[@"data"][@"list"][i][@"kpic"]];
                [_arrayLoopUrl addObject:dict[@"data"][@"list"][i][@"link"]];
            }
        }
        [self.tableView headerEndRefreshing];//头部刷新结束
        [self.tableView footerEndRefreshing];//尾部刷新结束
        
        [self loopImage];
        [self.tableView reloadData];
    }];
}

////轮播图数据和布局
-(void)loopImage{
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = _arrayLoopPic;
    
    // 情景三：图片配文字
    NSArray *titles =_arrayLoopTitle ;
    //网络加载 --- 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5, 0, SCREEN.size.width-10, kLoopH) imageURLStringsGroup:nil]; // 模拟网络延时情景
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;
    cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//    cycleScrollView2.placeholderImage = [UIImage imageNamed:@"102.png"];//轮播图占位图
    [self.view addSubview:cycleScrollView2];
    
    //--- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    // 清除缓存
    [cycleScrollView2 clearCache];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Model*m=_array[indexPath.row];
    if (indexPath.row==0) {
        //第一种 cell 布局(轮播图)
        NewsLoopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"first"];
        if (cell==nil) {
            cell=[[NewsLoopTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"first"];
        }
        
//        cell.newsLoopImageView.image=[UIImage imageNamed:@"102.png"];
        [cell addSubview:_cycleScrollView];
        return cell;
        
    }else if([m.content isEqualToString:@""]){
        //第二种 cell 布局(3张图片)
        NewsPicTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Second"];
        if (cell==nil) {
            cell=[[NewsPicTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Second"];
        }
        //分割包含多个图片地址的字符串
        NSArray * array = [m.imgs componentsSeparatedByString:@"|"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.newsPicTitle.text=m.title;

        [cell.newsPicImageView1 sd_setImageWithURL:[NSURL URLWithString:array[0]]];
        [cell.newsPicImageView2 sd_setImageWithURL:[NSURL URLWithString:array[1]]];
        [cell.newsPicImageView3 sd_setImageWithURL:[NSURL URLWithString:array[2]]];
        return cell;
    }else{
        //第三种 cell 布局(1张图片)
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell==nil) {
            cell=[[NewsTableViewCell  alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:m.img]];
        cell.newsTitle.text=m.title;
        cell.newsIntroduction.text=m.content;
        
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return kLoopH;
    }else{
        return 100;
    }
}
//点击模态详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailsPageViewController*newsDitalVC=[[DetailsPageViewController alloc] init];
    
    newsDitalVC.url=[_array[indexPath.row] toUrl];
    newsDitalVC.title1=[_array[indexPath.row] title];
    
    UINavigationController*newsNVC=[[UINavigationController alloc] initWithRootViewController:newsDitalVC];
    //模态动画推出
    newsDitalVC.modalPresentationStyle = UIModalPresentationFormSheet;
    newsDitalVC.modalTransitionStyle  = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:newsNVC animated:YES completion:^{
        
    }];
}
//轮播图点击事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailsPageViewController*newsLoopVC=[[DetailsPageViewController alloc] init];
    newsLoopVC.url=_arrayLoopUrl[index];
    newsLoopVC.title1=_arrayLoopTitle[index];
    
    UINavigationController*newsLoopNVC=[[UINavigationController alloc] initWithRootViewController:newsLoopVC];
    //模态动画推出
    newsLoopVC.modalPresentationStyle = UIModalPresentationFormSheet;
    newsLoopVC.modalTransitionStyle  = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:newsLoopNVC animated:YES completion:^{
        
    }];
}













@end