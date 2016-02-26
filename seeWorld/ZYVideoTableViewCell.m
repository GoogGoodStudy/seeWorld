//
//  ZYVideoTableViewCell.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYVideoTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZYVideoTableViewCell

- (void)updateWith:(ZYVideoModel *)model {
    self.titleLab.text = model.title;
    self.upLab.text = [model.up stringValue];
    self.downLab.text = [model.down stringValue];
    self.imgV.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.pic]placeholderImage:[UIImage imageNamed:@"replace"]];
    self.imgV.userInteractionEnabled = YES;
   
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerVideo:)];
    
    [self.imgV addGestureRecognizer:tap];
}

- (void)playerVideo:(UITapGestureRecognizer *)tgr {
    //self.imgV = (UIImageView *)tgr.view;
    NSString *str = [NSString stringWithFormat:@"%ld",tgr.view.tag];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str, @"tag", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"videoURL" object:nil userInfo:dict];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
