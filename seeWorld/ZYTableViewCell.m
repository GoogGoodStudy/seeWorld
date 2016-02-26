//
//  ZYTableViewCell.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ZYTableViewCell

- (void)updateWith:(ZYNewsModel *)model {
    self.newsLab.text = model.title;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.image]placeholderImage:[UIImage imageNamed:@"replace"]];
    if ([[model.videotype stringValue] isEqualToString: @"5"]) {
        self.titleLab2.text = model.title;
        [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:model.contentImage[0]]placeholderImage:[UIImage imageNamed:@"replace"]];
        [self.imgV2 sd_setImageWithURL:[NSURL URLWithString:model.contentImage[1]]placeholderImage:[UIImage imageNamed:@"replace"]];
        [self.imgV3 sd_setImageWithURL:[NSURL URLWithString:model.contentImage[2]]placeholderImage:[UIImage imageNamed:@"replace"]];
    }

}


- (void)awakeFromNib {
    
    //选中效果
    //self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
