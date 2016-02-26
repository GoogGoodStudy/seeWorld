//
//  ZYVideoGetData.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYVideoGetData.h"
#import "AFNetworking.h"
#import "ZYVideoModel.h"
#define VIDEO_URL (@"http://mobileapi1.roboo.com/joke/videoSearch.do?")

@implementation ZYVideoGetData

+ (void)getVideoDataWith:(NSInteger)page andHandle:(VideoHandler)handler {
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    [urlStr appendFormat:@"%@",VIDEO_URL];
    [urlStr appendFormat:@"q=&p=%ld&ps=15",page];
    NSLog(@"%@",urlStr);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableArray *modelArr = [[NSMutableArray alloc]init];
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *itemsArr = responseObject[@"items"];
        [itemsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ZYVideoModel *model = [[ZYVideoModel alloc]init];
            model.title = obj[@"title"];
            model.pic = obj[@"pic"];
            model.up = obj[@"up"];
            model.down = obj[@"down"];
            model.videourl = obj[@"videourl"];
            model.height = [obj[@"title"] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size.height;
            [modelArr addObject:model];
        }];
        handler(modelArr,nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
