//
//  TitleSegmentedControl.m
//  CNews
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "TitleSegmentedControl.h"

@implementation TitleSegmentedControl

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self createSegment];
    }
    return self;
}


-(void)createSegment{
    self.selectedSegmentIndex =0;

    
    //去掉颜色,现在整个segment都看不见
    self.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
NSForegroundColorAttributeName: [UIColor purpleColor]};
    [self setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName: [UIColor blackColor]};
    [self setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    

}
@end
