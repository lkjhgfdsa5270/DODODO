//
//  MySubscriptionTableViewCell.m
//  news
//
//  Created by lanou3g on 15/8/19.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "MySubscriptionTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MySubscriptionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//model 的set方法
- (void)setModel:(ReadModel *)model{
    self.titleLabel.text =model.title;
    self.sourceLabel.text = model.source;
    [self.bigImgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    if (model.imgnewextra.count==2 ) {
        [self.secondImgView sd_setImageWithURL:[NSURL URLWithString:[model.imgnewextra[0] objectForKey:@"imgsrc"]]];
        [self.thirdImgView sd_setImageWithURL:[NSURL URLWithString:[model.imgnewextra[1]  objectForKey:@"imgsrc"]]];
    }
    
   
    
}


- (IBAction)deleteButton:(id)sender {
}
@end
