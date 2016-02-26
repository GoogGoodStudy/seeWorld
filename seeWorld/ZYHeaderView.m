//
//  ZYHeaderView.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYHeaderView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#define TOUTIAO_URL (@"http://open.cztv.com/mobileapp/index.php?module=cztv&controller=m&action=newslist&uid=0&params=2tt&size=10&page=1")
#import "ZYCollectModel.h"
@implementation ZYHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self getData];
        self.frame = frame;
    }
    return self;
}

- (void)getData {
    UIScrollView *sv = [[UIScrollView alloc]init];
    sv.frame = self.bounds;
    _modelArr = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
        [manager GET:TOUTIAO_URL parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSArray *hotArr = dataDic[@"hot"];
            sv.contentSize = CGSizeMake(self.frame.size.width*hotArr.count, 0);
            
            [hotArr enumerateObjectsUsingBlock:^(NSDictionary *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UIImageView *imgV = [[UIImageView alloc]init];
                imgV.frame = CGRectMake(self.frame.size.width*idx, 0, self.frame.size.width, self.frame.size.height);
                [imgV sd_setImageWithURL:obj[@"image"]placeholderImage:[UIImage imageNamed:@"replace"]];
              
                ZYCollectModel *model = [[ZYCollectModel alloc]init];
                model.title = obj[@"title"];
                model.pic = obj[@"image"];
                model.url = obj[@"url"];
                [_modelArr addObject:model];
                imgV.userInteractionEnabled = YES;
                imgV.tag = idx;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoDetail:)];
                [imgV addGestureRecognizer:tap];
                [sv addSubview:imgV];
                
                [self addSubview:sv];
                
            }];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(30, self.frame.size.height-30, self.frame.size.width-30, 30);
            label.text = [_modelArr[0] title];
            label.tag = 10;
            label.textColor = [UIColor whiteColor];
            
            UIImageView *bgV = [[UIImageView alloc]init];
            bgV.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
            bgV.image = [UIImage imageNamed:@"headnewscell_banner_shadow"];
            
            [self addSubview:bgV];
            [self addSubview:label];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    sv.delegate = self;
    sv.pagingEnabled = YES;
    
    
}

- (void)gotoDetail:(UITapGestureRecognizer *)tgr {
    NSInteger index = tgr.view.tag;
    ZYCollectModel *model = _modelArr[index];
    NSString *urlStr = model.url;
    NSLog(@"%@",urlStr);
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:model,@"model" ,nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tongzhi" object:nil userInfo:dict];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/self.frame.size.width;
    ZYCollectModel *model = _modelArr[index];
    UILabel *label = [self viewWithTag:10];
    label.text = model.title;
    NSLog(@"%@",label.text);
 
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
@end
