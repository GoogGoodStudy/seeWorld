//
//  ZYVideoTableViewCell.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYVideoModel.h"
@interface ZYVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *upLab;
@property (weak, nonatomic) IBOutlet UILabel *downLab;

- (void)updateWith:(ZYVideoModel *)model;

@end
