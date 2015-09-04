//
//  TFollowViewController.h
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFollowViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *TFollowView;

- (IBAction)didJumpToFun:(UIButton *)sender;

- (IBAction)didJumpToJoke:(UIButton *)sender;

- (IBAction)didJumpToPicture:(UIButton *)sender;

#pragma mark --------------













@end
