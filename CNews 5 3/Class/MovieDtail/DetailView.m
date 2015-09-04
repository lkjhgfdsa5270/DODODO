//
//  DetailView.m
//  SeeingAndHearing
//
//  Created by lanou3g on 15/7/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailView.h"
#define Kwidth self.frame.size.width
@implementation DetailView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self CHZHR_setView];
    }
    return self;
}
-(void)CHZHR_setView{
    
    
    self.View = [[UIView alloc]init];
    _View.frame  = CGRectMake(0, 64, CGRectGetWidth(self.frame), 230);
    //self.View.backgroundColor = [UIColor yellowColor];
    [self addSubview:_View];
    
    self.lable = [[UILabel alloc]init];
    _lable.frame = CGRectMake(CGRectGetMinX(_View.frame), CGRectGetMaxY(_View.frame), Kwidth,30);
    _lable.backgroundColor = [UIColor whiteColor];
    _lable.text = @"推荐";
    _lable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_lable];
    
    self.seetableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_lable.frame), Kwidth, CGRectGetHeight(self.frame)-260) style:UITableViewStylePlain];
    //self.seetableView.backgroundColor = [UIColor redColor];
    [self addSubview:_seetableView];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
