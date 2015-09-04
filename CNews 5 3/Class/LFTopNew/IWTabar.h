//
//  IWTabar.h
//  微博
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWTabar;
@protocol IWTabarDelegate<NSObject>

@optional
-(void)taBar:(IWTabar *)taBer didselectedButtonFrom:(long)from to:(long)to;


@end
@interface IWTabar : UIView
-(void)addTabBarButtonWithTitle:(UITabBarItem *)item;
@property(nonatomic,weak)id<IWTabarDelegate>delegate;
@end
