//
//  ZYVideoModel.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYVideoModel : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *videourl;
@property (nonatomic, strong)NSNumber *up;
@property (nonatomic, strong)NSNumber *down;
@property (nonatomic, assign)float height;


@end
