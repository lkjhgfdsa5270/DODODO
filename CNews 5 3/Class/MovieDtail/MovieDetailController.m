   //
//  MovieDetailController.m
//  SeeingAndHearing
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MovieDetailController.h"
#import "DetailView.h"
#import "MoviedetailCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "RequestTool.h"
#import "MBProgressHUD.h"
#define CHZhR @"http://c.3g.163.com/nc/video/detail/VAUOKOP3D.html"
#define CZRDD @"http://c.3g.163.com/nc/video/detail/"
#define CZRong @".html"
#import "DtailModel.h"
@interface MovieDetailController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)DetailView *dv;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIRefreshControl * refreshe;
//创建视频播放控制器
@property(nonatomic,strong)MPMoviePlayerController *moviePlay;
@property(nonatomic,strong)UIImageView *image ;
@end

@implementation MovieDetailController
-(NSUInteger)supportedInterfaceOrientations{

    return UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate{

    return YES;
}
-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)loadView{
    _dv = [[DetailView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _dv;
}
- (void)viewDidLoad {     
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftbutton.frame = CGRectMake(3, 0, 30, 35);
    leftbutton.layer.cornerRadius = 10;
    
    
    [leftbutton setBackgroundImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(leftbarbuttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftbarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = leftbarbutton;
    
    [self setData];
    [self delegate];
    [self PlayMovie];
    [self supportedInterfaceOrientations];
    [self shouldAutorotate];
    
}
-(void)leftbarbuttonAction{
    [self removePlayerView];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)delegate{
    self.dv.seetableView.delegate = self;
    self.dv.seetableView.dataSource = self;
    [self.dv.seetableView registerClass:[MoviedetailCell class] forCellReuseIdentifier:@"cell"];
}
-(void)PlayMovie{
    
    [self removePlayerView];
    self.moviePlay.view.backgroundColor = [UIColor blackColor];
    
    self.moviePlay.view.frame = self.dv.View.bounds;
    
    self.moviePlay.contentURL = [self getNetworkUrl];
    
    self.moviePlay.scalingMode = MPMovieScalingModeAspectFill;
    
    [self.dv.View addSubview:_moviePlay.view];
    
    [self.moviePlay play];
    
    //添加通知
    [self addNotification];
}
- (void)removePlayerView
{
    if (_moviePlay)
    {
        [_moviePlay stop];
        [_moviePlay.view removeFromSuperview];
        _moviePlay = nil;
    }
}
-(NSURL *)getNetworkUrl{
    NSString * urlStr = _aString ;
    NSString *newUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:newUrl];
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
//添加通知播放控制器的播放状态
-(void)addNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlay];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlay];
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

//播放完成的通知对象
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    
    //NSLog(@"%li",self.moviePlay.playbackState);
}
-(void)setData{
    self.dataArray = [NSMutableArray array];
    self.array = [NSArray array];
    NSString * url = [CZRDD stringByAppendingFormat:@"%@.html",_string];
    //NSLog(@"%@",url);
    
    [RequestTool requestWithUrl:url body:nil backValue:^(NSData *value){
        if (!value) {
            UIAlertView *aler =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查你的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }else{
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:value options:NSJSONReadingAllowFragments error:nil];
            
            if (dict[@"secList"]) {
                _array= dict[@"secList"];
            }else if(dict[@"recommend"]){
                _array = dict[@"recommend"];
            }else{
                self.dv.lable.text = @"无推荐";
            }
            
            for (NSDictionary * d in _array) {
                DtailModel * dmessage = [[DtailModel alloc]init];
                [dmessage setValuesForKeysWithDictionary:d];
                [_dataArray addObject:dmessage];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.dv.seetableView reloadData];
            });
        }
        
    }];
}


#pragma Table Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dv.seetableView == tableView) {
        return _dataArray.count;
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (_dataArray != nil) {
        if (self.dv.seetableView == tableView) {
            MoviedetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            DtailModel *message = _dataArray[indexPath.row];
            cell.titleLable.text = message.title;
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        }else{
            
            return 0;
        }
    }else{
        
        return 0;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self removePlayerView];
    
    self.moviePlay.view.backgroundColor = [UIColor blackColor];
    
    self.moviePlay.view.frame = self.dv.View.bounds;
    DtailModel * message = _dataArray[indexPath.row];
    NSString * urlStr = message.mp4_url;
    NSString *newUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:newUrl];
    self.moviePlay.contentURL = url;
    self.moviePlay.scalingMode = MPMovieScalingModeAspectFill;
    [self.dv.View addSubview:_moviePlay.view];
    [self.moviePlay play];
    
    //添加通知
    [self addNotification];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||
            interfaceOrientation==UIInterfaceOrientationLandscapeRight);
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
