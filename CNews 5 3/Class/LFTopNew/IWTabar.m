//
//  IWTabar.m
//  微博
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "IWTabar.h"
#import "LFButton.h"
@interface IWTabar()
@property(nonatomic ,weak)UIButton * selectedButton;
@property(nonatomic,weak)UIButton * plusButton;
@property(nonatomic,strong)NSMutableArray * tabBarButttons;//放所有的tabber

@end
@implementation IWTabar

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1D494F7B-27C8-4670-8781-F1B56C024524.png"]];
    
           }
    return self;

}
-(NSMutableArray *)tabBarButttons{

    if (!_tabBarButttons) {
        _tabBarButttons = [NSMutableArray array];
    }
    return _tabBarButttons;
}
//创建按钮

-(void)addTabBarButtonWithTitle:(UITabBarItem *)item{
    LFButton * button = [[LFButton alloc] init];
    [self addSubview:button];
    button.backgroundColor = [UIColor oldLaceColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents: UIControlEventTouchDown ];
    
    button.item = item;
         //添加按钮到数组数组中去
     [self.tabBarButttons addObject:button];
    //默认选中第0个按钮
    if(self.tabBarButttons.count==0){
    
        [self buttonClick:button];
    }
  

}

//button 事件
-(void)buttonClick:(UIButton *)button{
    //通知代理/放在最前面
    if ([self.delegate respondsToSelector:@selector(taBar:didselectedButtonFrom:to:)])  {
        [self.delegate taBar:self didselectedButtonFrom:self.selectedButton.tag to:button.tag];
        
    }

    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;

}
-(void)layoutSubviews{
#pragma mark =------➕号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    
#pragma mark =------按钮fram的数据
    [super layoutSubviews];
     CGFloat buttonW = w/self.subviews.count;
     CGFloat buttonH = h;
     CGFloat buttonY =0;
    for (int index = 0; index < self.tabBarButttons.count; index++) {
        UIButton * button = self.tabBarButttons[index];
               CGFloat buttonX = index* buttonW;
        if (index > 4) {
            buttonX += buttonW;
        }

        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //绑定tag值
        
        button.tag = index;
    }
}
@end
