//
//  ZYNewsCollectionViewCell.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/21.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNewsCollectionViewCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>

- (void)setData:(NSInteger)num;

@end
