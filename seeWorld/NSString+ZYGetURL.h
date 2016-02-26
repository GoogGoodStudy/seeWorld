//
//  NSString+ZYGetURL.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/21.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetHandle)(id, NSError *);

@interface NSString (ZYGetURL)


/**
 *  得到数据
 *
 *  @param num    当前是那一个item，头条，科技
 *  @param page   网址中的第几页
 *  @param hanler 回调，类型是数组，里面装的是模型
 */
+ (void)getUrlWithNum:(NSInteger)num andPage:(NSInteger)page andHandle:(NetHandle)handler;

@end
