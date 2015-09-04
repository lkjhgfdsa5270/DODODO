//
//  DetailView.h
//  SeeingAndHearing
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
@property(nonatomic,strong)UIView *View;

@property(nonatomic,strong)UIScrollView *scorlView;

@property(nonatomic,strong)UILabel *lable;

@property(nonatomic,strong)UITableView *seetableView;

@property(nonatomic,strong)UITableView *commentstableview;

@property(nonatomic,strong)UISegmentedControl *segmented;
@end
