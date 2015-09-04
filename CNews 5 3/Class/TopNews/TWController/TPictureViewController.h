//
//  TPictureViewController.h
//  网易新闻
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPictureViewController : UIViewController

- (IBAction)didJumpToFun:(UIButton *)sender;

- (IBAction)didJumpToJoke:(UIButton *)sender;

- (IBAction)didJumpToFollow:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UITableView *TPictureView;

#pragma mark --------------













@end
