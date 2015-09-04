//
//  MovieTableViewCell.m
//  CNews
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)StratPlay:(UIButton *)sender {
    
    [self.delegate PlaybuttonAction:_myimage button:_button];

}


-(void)setSeemodel:(Seemodel *)seemodel{
    self.replycountlabel.text = seemodel.replyCount;
    self.titlelabel.text= seemodel.title;
    self.Descriptionlable.text= seemodel.Description;
    self.ptimelabel.text= seemodel.ptime;
    self.playcountlabel.text= [NSString stringWithFormat:@"%@播放次数",seemodel.playCount];
    [self.myimage sd_setImageWithURL:[NSURL URLWithString:seemodel.cover]];
   
   
    
}
@end
