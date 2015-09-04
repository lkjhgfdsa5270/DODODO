//
//  MovieTableViewCell.h
//  CNews
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seemodel.h"
#import "Mybutton.h"
@protocol   MovieTableViewCell <NSObject>

//-(void)tapImageView:(UIView *)view;

-(void)PlaybuttonAction:(UIImageView *)imageView
                 button:(Mybutton *)sender;

@end

@interface MovieTableViewCell : UITableViewCell
//跟帖人数
@property (strong, nonatomic) IBOutlet UILabel *replycountlabel;
//播放按钮事件
- (IBAction)StratPlay:(UIButton *)sender;
//标题
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
//详情
@property (strong, nonatomic) IBOutlet UILabel *Descriptionlable;
//时间
@property (strong, nonatomic) IBOutlet UILabel *ptimelabel;
//播放次数
@property (strong, nonatomic) IBOutlet UILabel *playcountlabel;
//照片
@property (strong, nonatomic) IBOutlet UIImageView *myimage;
//播放按钮
@property (strong, nonatomic) IBOutlet UIButton *playButton;
//点击播放
@property (strong, nonatomic) IBOutlet Mybutton *button;

@property(strong,nonatomic)Seemodel * seemodel;
@property(nonatomic,weak)id <MovieTableViewCell>delegate;
@end
