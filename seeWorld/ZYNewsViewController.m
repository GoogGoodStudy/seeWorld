//
//  ZYNewsViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/21.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYNewsViewController.h"
#import "ZYLabel.h"
#import "ZYNewsCollectionViewCell.h"
#import "ZYDetailViewController.h"
#import "ZYCollectModel.h"
#define VIEW_WIDTH self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height

@interface ZYNewsViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *smallSV;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;

@end

@implementation ZYNewsViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tongzhi" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSmallSV];
    ZYLabel *label = [self.smallSV.subviews firstObject];
    label.scale = 1.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    
    
}



- (void)tongzhi:(NSNotification *)nf {
    NSLog(@"收到消息%@",nf.userInfo[@"model"]);
    ZYDetailViewController *dvc = [[ZYDetailViewController alloc]init];
    self.hidesBottomBarWhenPushed=YES;
    ZYCollectModel *model = nf.userInfo[@"model"];
    dvc.model = model;
    [self.navigationController pushViewController:dvc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

- (void)addSmallSV {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.smallSV.contentSize = CGSizeMake(VIEW_WIDTH/6*8, 0);
    self.smallSV.showsHorizontalScrollIndicator = NO;
    self.smallSV.showsVerticalScrollIndicator = NO;
    NSArray *titleArr = @[@"头条", @"社会", @"娱乐", @"财经", @"军事", @"生活", @"国际", @"体育"];
    for (int i = 0; i < titleArr.count; i ++) {
        ZYLabel *titleLab = [[ZYLabel alloc] init];
        titleLab.tag = i;
        titleLab.frame = CGRectMake(VIEW_WIDTH/6*i, 0, VIEW_WIDTH/6, 35);
        titleLab.text = titleArr[i];
        titleLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCollectionV:)];
        [titleLab addGestureRecognizer:tapGR];
        [self.smallSV addSubview:titleLab];
        
    }
    
}

- (void)changeCollectionV:(UITapGestureRecognizer *)tgr {
    [self.collectionV setContentOffset:CGPointMake(VIEW_WIDTH*tgr.view.tag, 0) animated:YES];
}

#pragma mark - collectionView代理方法 -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-64-49-35);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYNewsCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCellId" forIndexPath:indexPath];
    
    [item setData:indexPath.row];
    return item;
}


//手势导致停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//collection动画导致停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    if (index == 5 || index == 6 || index == 7) {
        [self.smallSV setContentOffset:CGPointMake(VIEW_WIDTH/3, 0) animated:YES];
    } else if (index == 0 || index == 1 || index == 2) {
        [self.smallSV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    [self.smallSV.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            ZYLabel *label = self.smallSV.subviews[idx];
            label.scale = 0.0;
        }
    }];
}

//collection正在滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat value = ABS(scrollView.contentOffset.x/VIEW_WIDTH);
    NSUInteger leftIndex = (int)value;
    CGFloat scale = value - leftIndex;
    ZYLabel * leftLabel = self.smallSV.subviews[leftIndex];
    leftLabel.scale = 1-scale;
    if (leftIndex+1 < self.smallSV.subviews.count) {
        ZYLabel * rightLabel = self.smallSV.subviews[leftIndex+1];
        rightLabel.scale = scale;
    }
    
}


@end
