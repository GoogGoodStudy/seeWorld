//
//  ZYNewsModel.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYNewsModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *videotype;
@property (nonatomic, strong) NSArray *contentImage;

@end
