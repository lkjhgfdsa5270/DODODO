//
//  TFunViewController.h
//  网易新闻
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFunViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *TFunTableView;

- (IBAction)didJumpToJoke:(UIButton *)sender;

- (IBAction)didJumpToFollow:(UIButton *)sender;

- (IBAction)didJumpToPicture:(UIButton *)sender;

#pragma mark --------------



@end
