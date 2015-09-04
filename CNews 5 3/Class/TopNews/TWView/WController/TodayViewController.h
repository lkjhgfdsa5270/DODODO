//
//  TodayViewController.h
//  news
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ToDayDelegate <NSObject>

//获得TodayModel对象
- (void)getTodayModel:(TodayModel *)model;

@end

@interface TodayViewController : UIViewController

@property(nonatomic,assign)id<ToDayDelegate> delegate ;//设置代理属性

@property(nonatomic,strong)NSMutableArray *  reciveArray;//接收传过来的对象

@end
