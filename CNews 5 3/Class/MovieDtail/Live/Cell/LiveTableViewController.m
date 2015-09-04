//
//  LiveTableViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/6/24.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LiveTableViewController.h"

//#import "AllProt.h"

#import "NetWorkManger.h"
#import "LiveTableViewCell.h"
#import "LiveModel.h"
#import "MJRefresh.h"
#define LiveComePort @"http://baobab.wandoujia.com/api/v1/feed"

#import "XqLiveViewController.h"
@interface LiveTableViewController ()

@property(nonatomic,strong)NSMutableArray *modelArray;
@property(nonatomic,assign) int flag;
@property(nonatomic,assign) int more;
@property (nonatomic,strong)NetWorkManger *manager;

@end

@implementation LiveTableViewController
-(NetWorkManger *)manager
{
    if (!_manager) {
        self.manager = [[NetWorkManger alloc]init];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.more = 1;
    self.modelArray = [NSMutableArray array];
    NetWorkManger *manger = [[NetWorkManger alloc]init];
    [manger requestWithUrlString:LiveComePort success:^(id object) {
//        NSLog(@"%@",object);
        for (NSDictionary *temp in [[[object objectForKey:@"dailyList"]firstObject]objectForKey:@"videoList"]) {
            LiveModel *model = [[LiveModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [self.modelArray addObject:model];
        }
        [self.tableView reloadData];
    } failed:^(NSError *error) {
    }];
    [self upData];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tdf.jpg"] forBarMetrics:UIBarMetricsDefault];
}





//布局--更新加载
-(void)upData{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView headerBeginRefreshing];
}
//头部刷新
-(void)headerRereshing{
       [self loadNewData];//数据请求
}

//尾部刷新
-(void)footerRereshing{
    

    
        [self loadMoreData];//加载更多数据
    
       // [self.tableView footerEndRefreshing];//尾部刷新结束
        
    
}











- (void)loadNewData

{
//   [self.tableView headerBeginRefreshing];
    
    [self.manager requestWithUrlString:LiveComePort success:^(id object) {
        
        [self.modelArray removeAllObjects];
        
        for (NSDictionary *temp in [[[object objectForKey:@"dailyList"]firstObject]objectForKey:@"videoList"]) {
            LiveModel *model = [[LiveModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [self.modelArray addObject:model];
        }
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
    
    [self.tableView headerEndRefreshing];
    
}
-(void)loadMoreData
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: - self.more * 24 * 60 * 60];
    NSString *timeString = [formatter stringFromDate:date];
    NSLog(@"%@",timeString);
    NetWorkManger *manger = [[NetWorkManger alloc]init];
    [manger requestWithUrlString:[NSString stringWithFormat:@"%@?date=%@",LiveComePort,timeString] success:^(id object) {
        //        NSLog(@"%@",object);
        int k = 0;
        for (NSDictionary *temp in [[[object objectForKey:@"dailyList"]firstObject]objectForKey:@"videoList"]) {
            LiveModel *model = [[LiveModel alloc]init];
            [model setValuesForKeysWithDictionary:temp];
            [self.modelArray addObject:model];
            k++;
        }
    } failed:^(NSError *error) {
    }];
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
    self.more++;
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
    return self.modelArray.count;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage * iamge = [UIImage imageNamed:@"wer.jpg"];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = iamge;
    imageView.frame = [[UIScreen mainScreen] bounds];
    [self.tableView setBackgroundView:imageView];


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static  NSString* cell_id = @"LiveTableViewCell";
    LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cell_id owner:self options:nil]firstObject];
    }
    LiveModel *model = self.modelArray[indexPath.row];
    [cell setCellToModel:model];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XqLiveViewController *xq = [[XqLiveViewController alloc]init];
    LiveModel *model = self.modelArray[indexPath.row];
    xq.model = model;
    [self.navigationController pushViewController:xq animated:YES];
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
