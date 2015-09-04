//
//  LiveModel.h
//  Live
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveModel : NSObject
@property(nonatomic,copy) NSString *category;
@property(nonatomic,copy) NSString *coverForDetail;
@property(nonatomic,copy) NSString *coverBlurred;
@property(nonatomic,copy) NSString *Description;
@property(nonatomic,assign) int duration;
@property(nonatomic,copy) NSString *playUrl;
@property(nonatomic,copy) NSString *title;


@end
