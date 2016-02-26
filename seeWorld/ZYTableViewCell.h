//
//  ZYTableViewCell.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNewsModel.h"

@interface ZYTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *newsLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;


- (void)updateWith:(ZYNewsModel *)model;


@end
