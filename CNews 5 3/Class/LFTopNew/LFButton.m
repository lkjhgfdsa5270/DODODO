//
//  LFButton.m
//  微博
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "LFButton.h"
#define LFButtonImageRatio 0.6
#define LFButtonTitleColor (iOS7 ?[UIColor orangeColor] :[UIColor whiteColor])
#define LFButtonsetTitleColor [UIColor blackColor]

@interface LFButton ()


@end
@implementation LFButton

-(instancetype)initWithFrame:(CGRect)frame{
  self=  [super initWithFrame:frame];
    
    if (self) {
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:LFButtonsetTitleColor forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //[self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        
        
    }
    return self;
}

//c重写highligh方法
-(void)setHighlighted:(BOOL)highlighted{



}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * LFButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);

}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * LFButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setItem:(UITabBarItem *)item{
    _item= item;
    //KVO 监听属性的item 的 badgeValue 改变
#pragma mark------监听控制器tabber的改变
//监听badgeValue

[item addObserver:self forKeyPath:@"title" options:0 context:nil];
[item addObserver:self forKeyPath:@"image" options:0 context:nil];
[item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    //就会调用下面的方法
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
   }

#pragma mark----- dealloc 
//如果不释放 self被销毁 还会有人改变item的值 还会去调用self 就会出现野指针的现象
//通知也要移除掉
-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
    
}
/**
 *  监听到某个对象的属性的改变 就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个属性对象的值改变
 *  @param change  属性发生的改变
 *  @param context
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self setTitle:self.item.title forState: UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
}

@end
