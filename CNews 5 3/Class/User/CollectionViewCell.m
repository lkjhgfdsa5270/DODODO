//
//  CollectionViewCell.m
//  CNews
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
   self =  [super initWithFrame:frame];
    if (self) {
       
        
       
        self.uiimage.image = [UIImage circleImageWithName:@"X36UZ[4YS`8RUSIL%DZC(56.jpg" borderWidth:5 borderColor:[UIColor cyanColor]];
    }
    return self;
}


@end
