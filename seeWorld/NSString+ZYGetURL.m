//
//  NSString+ZYGetURL.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/21.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "NSString+ZYGetURL.h"
#import "AFNetworking.h"
#import "ZYNewsModel.h"
#define TOUTIAO_URL (@"http://open.cztv.com/mobileapp/index.php?module=cztv&controller=m&action=newslist&uid=0&params=2tt&size=10")
#define QITA_URL (@"http://cn.doome.com/api/news_list_get.php?")
@implementation NSString (ZYGetURL)
/**
 *  得到数据
 *
 *  @param num    当前是那一个item，头条，科技
 *  @param page   网址中的第几页
 *  @param hanler 回调，类型是数组，里面装的是模型
 */
+ (void)getUrlWithNum:(NSInteger)num andPage:(NSInteger)page andHandle:(NetHandle)handler {
    NSMutableArray *modelArr = [[NSMutableArray alloc] init];
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (num == 0) {
        [urlStr appendFormat:@"%@",TOUTIAO_URL];
        [urlStr appendFormat:@"&page=%ld",page];
        
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSArray *listArr = dataDic[@"list"];
            [listArr enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZYNewsModel *model = [[ZYNewsModel alloc] init];
                model.url = obj[@"url"];
                model.image = obj[@"image"];
                model.title = obj[@"title"];
                model.videotype = obj[@"videotype"];
                model.contentImage = obj[@"contentImage"];
                [modelArr addObject:model];
            }];
            handler (modelArr, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            handler (nil, error);
        }];
    } else if (num == 1 || num == 2||num == 3||num == 4||num == 5||num == 6 || num == 7) {
        [urlStr appendFormat:@"%@",QITA_URL];
        [urlStr appendFormat:@"page=%ld&typeid=%ld",page, num];
        NSLog(@"%@",urlStr);
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSArray *dataArr = responseObject[@"data"];
            
            [dataArr enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ZYNewsModel *model = [[ZYNewsModel alloc] init];
                model.title = obj[@"title"];
                model.url = obj[@"mobileurl"];
                model.image = obj[@"litpic"];
                [modelArr addObject:model];
            }];
            handler (modelArr, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            handler (nil, error);
        }];
    }
    
}
@end













