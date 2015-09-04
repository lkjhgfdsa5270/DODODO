//
//  MovieTableViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieTableViewCell.h"
#import "Reachability.h"
#import "Seemodel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Mybutton.h"
#import "MovieDetailController.h"
@interface MovieTableViewController ()<MovieTableViewCell>
{   NSInteger _index;
    NSInteger _indexcount;
}

//有无网络
@property(nonatomic,strong)Reachability * ability;
@property(nonatomic,strong)NSMutableArray * seeData;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,copy)NSString *string;
@property(nonatomic,strong) MPMoviePlayerController *moviePlay;
@end

@implementation MovieTableViewController
-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(NSMutableArray *)seeData{
    if (!_seeData) {
        self.seeData = [NSMutableArray array];
    }
    return _seeData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UINib * nib = [UINib nibWithNibName:@"MovieTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Moviecell"];
    [self reachability];//判断有误网络
    [self p_setupProgressHud];
    _indexcount = 20;
    [self upData];
}




//刷新
-(void)upData{
    [self.tableView addHeaderWithTarget:self action:@selector(headerupData)];
    [self.tableView addFooterWithTarget:self action:@selector(FooterUpData)];
    [self.tableView headerBeginRefreshing];
    
}
//下拉刷新
-(void)headerupData{
    if (_indexcount == 20) {
        
    }else{
        _indexcount = 20;
    }
    [self CHZHR_Setdata];
    
}
//加载
-(void)FooterUpData{
    
    NSLog(@"%ld",_indexcount);
    
    _indexcount = _indexcount +20;
    if (_indexcount<160) {
        [self CHZHR_Setdata];
    }
}




//网络判断
-(void)reachability{
    __weak typeof(self)weakSrlf = self;
    _ability = [Reachability reachabilityForInternetConnection];
    _ability.reachableBlock = ^(Reachability * reachability){
        NSLog(@"有网");
        [weakSrlf CHZHR_Setdata];
    };
    _ability.unreachableBlock = ^(Reachability *reachability){
        NSLog(@"没网");
        
    };
//通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNetwork:) name:kReachabilityChangedNotification object:_ability];
    [_ability startNotifier];

}
//判断WIFi
-(void)checkNetwork:(NSNotification *)sender{
    Reachability *ability= [sender object];
    if (ability.currentReachabilityStatus == ReachableViaWiFi) {
        [self CHZHR_Setdata];
    }else if(ability.currentReachabilityStatus == ReachableViaWWAN){
//               UIAlertView *alervr= [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否3g浏览" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                [alervr show];
    }
}
//加载
-(void)CHZHR_Setdata{
    NSString *string = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/V9LG4B3A0/y/%ld-%ld.html",_indexcount-20,_indexcount];
    [RequestTool requestWithUrl:string body:nil backValue:^(NSData *value){
        if (!value) {
            
            [[DataHandle shardataHandle] tipboxNetwork];
            
        }else{
            
            if (_indexcount==20) {
                [self.seeData removeAllObjects];
            }
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:value options:NSJSONReadingAllowFragments error:nil];
            
            for (NSDictionary *d in dict[@"V9LG4B3A0"]) {
                Seemodel * m=[[Seemodel alloc]init];
                
                [m setValuesForKeysWithDictionary:d];
                
                [self.seeData addObject:m];
            }
        }
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }];
}


-(void)viewDidAppear:(BOOL)animated{
    //加载数据
    [self reachability] ;
    [_hud removeFromSuperview];
}



-(void)p_setupProgressHud{
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeDeterminate;
    [self.view addSubview:_hud];
    [_hud show:YES];
}



#pragma Seemovie delegate

-(void)PlaybuttonAction:(UIImageView *)imageView button:(Mybutton*)sender {
    
    [self removePlayerView];
    self.string = [NSString string];
    Seemodel * seeMassage = _seeData[sender.indexPath.row];
    
    _string = seeMassage.mp4_url;
    
    //NSLog(@"%@",_string);
    self.moviePlay.view.backgroundColor = [UIColor blackColor];
    self.moviePlay.view.frame = imageView.bounds;
    self.moviePlay.contentURL = [self getNetworkUrl];
    self.moviePlay.scalingMode = MPMovieScalingModeAspectFill;
    [imageView addSubview:_moviePlay.view];
    [self.moviePlay play];
    
    //添加通知/Users/lanou3g/Desktop/D7_张浩_公闻天下/BanBen2/All/Movie/Mybutton.h

    [self addNotification];
}


//添加通知播放控制器的播放状态
-(void)addNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlay];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlay];
    
}
//播放完成的通知对象
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    
    //NSLog(@"%li",self.moviePlay.playbackState);
}
//播放状态的改变的通知对象
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlay.playbackState) {
        case MPMoviePlaybackStatePlaying:
            [self.moviePlay play];
            break;
        case MPMoviePlaybackStatePaused:
            [self.moviePlay pause];
            break;
        case MPMoviePlaybackStateStopped:
            [self.moviePlay stop];
            
        default:
            
            break;
    }
}


- (void)removePlayerView
{
    if (_moviePlay)
    {
        [_moviePlay stop];
        [_moviePlay.view removeFromSuperview];
        _moviePlay = nil;
    }else{
    
    [_moviePlay play];
    }
}

-(NSURL*)getNetworkUrl{
    
    NSString * urlStr = _string;
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:newUrlStr];
    
    return url;
}
//创建媒体播放器
-(MPMoviePlayerController *)moviePlay{
    if (!_moviePlay) {
        _moviePlay = [[MPMoviePlayerController alloc]initWithContentURL:nil];
        _moviePlay.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    }
    
    return _moviePlay;
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
    return self.seeData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Moviecell" forIndexPath:indexPath];
     Seemodel * seeMessage = _seeData[indexPath.row];
    cell.seemodel = seeMessage;
    cell.button.indexPath = indexPath;
    cell.delegate  =self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 300;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removePlayerView];
    
    MovieDetailController *movievc  = [[MovieDetailController alloc]init];
    
    Seemodel * message = _seeData[indexPath.row];
    movievc.aString = message.mp4_url;
    movievc.string = message.vid;
    [self.navigationController pushViewController:movievc animated:YES];
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
            [self removePlayerView];

}

@end
