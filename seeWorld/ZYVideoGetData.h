//
//  ZYVideoGetData.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VideoHandler)(id, NSError *);

@interface ZYVideoGetData : NSObject

+ (void)getVideoDataWith:(NSInteger)page andHandle:(VideoHandler)handler;

@end
