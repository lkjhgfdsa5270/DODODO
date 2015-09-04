//
//  TJokeViewController.h
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJokeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *JokeTableView;

- (IBAction)didJumpToFun:(UIButton *)sender;

- (IBAction)didJumpToFollow:(UIButton *)sender;

- (IBAction)didJumpToPicture:(UIButton *)sender;

#pragma mark --------------





@end
