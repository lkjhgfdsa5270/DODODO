//
//  XqLiveViewController.m
//  News
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "XqLiveViewController.h"
#import "UIImageView+WebCache.h"
#import "LiveModel.h"

#import <MediaPlayer/MediaPlayer.h>

@interface XqLiveViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (strong, nonatomic) IBOutlet UIImageView *imagePicView;

@property (strong, nonatomic) IBOutlet UILabel *titileLabel;

@property (strong, nonatomic) IBOutlet UILabel *groupLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentsLabel;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;

@property(strong,nonatomic) MPMoviePlayerViewController *moview;
@end

@implementation XqLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverBlurred] placeholderImage:nil options:SDWebImageDelayPlaceholder];
    
    [self.imagePicView sd_setImageWithURL:[NSURL URLWithString:self.model.coverForDetail] placeholderImage:nil options:SDWebImageDelayPlaceholder];
    
    self.titileLabel.text = self.model.title;
    int fen = self.model.duration/60;
    int miao = self.model.duration%60;
    NSString *string = [NSString stringWithFormat:@"#%@  /  %02d' %02d\"",self.model.category,fen,miao];
    self.groupLabel.text = string;
    self.contentsLabel.text = self.model.Description;
    [self.imageButton addTarget:self action:@selector(imageButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (void)imageButtonDidClicked:(UIButton *)sender
{

    self.moview = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.model.playUrl]];
    [self presentMoviePlayerViewControllerAnimated:_moview];
    
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
