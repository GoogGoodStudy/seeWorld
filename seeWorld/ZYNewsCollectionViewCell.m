//
//  ZYNewsCollectionViewCell.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/21.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYNewsCollectionViewCell.h"
#import "NSString+ZYGetURL.h"
#import "ZYTableViewCell.h"
#import "ZYHeaderView.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "ZYCollectModel.h"
@interface ZYNewsCollectionViewCell ()
{
    NSMutableArray *_dataSource;
    NSInteger _page;
    NSInteger _num;
}
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation ZYNewsCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _dataSource = [[NSMutableArray alloc]init];
        _page = 1;
        _num = 0;
    }
    return self;
}

- (void)setData:(NSInteger)num {
    _tabView.separatorStyle = UITableViewCellSelectionStyleNone;
    _num = num;
    [_dataSource removeAllObjects];
    [self.tabView reloadData];
    if (_num == 0) {
        ZYHeaderView *headerV = [[ZYHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width*360/640)];
       
        self.tabView.tableHeaderView = headerV;
    } else {
        self.tabView.tableHeaderView = nil;
    }
    
    [self getData];
    [self setRefresh];
    //[self.tabView.mj_header beginRefreshing];
    
}

- (void)getData {
    [NSString getUrlWithNum:_num andPage:_page andHandle:^(NSArray *array, NSError *error) {
        [_dataSource addObjectsFromArray:array];
        _tabView.separatorStyle = UITableViewCellSelectionStyleDefault;
        [self.tabView reloadData];
        [self.tabView.mj_header endRefreshing];
        [self.tabView.mj_footer endRefreshing];

    }];
}

- (void)setRefresh {
    self.tabView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
 
    
    self.tabView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footerRefresh];
    }];
    
}

- (void)headerRefresh {
    _page = 1;
    [self getData];
}
- (void)footerRefresh{
    _page++;
    [self getData];
    
}


#pragma mark - tableView代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_num == 0) {
        ZYNewsModel *model = _dataSource[indexPath.row];
        if ([[model.videotype stringValue] isEqualToString: @"5"]) {
            
            ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photpCellId"];
            [cell updateWith:model];
            return cell;
        } else {
            ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            [cell updateWith:model];
            return cell;
        }
    } else {
        ZYNewsModel *otherModel = _dataSource[indexPath.row];
        ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        [cell updateWith:otherModel];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_num == 0) {
        ZYNewsModel *model = _dataSource[indexPath.row];
        if ([model.videotype isEqual:@(5)]) {
            return 150;
        }else{
            return 100;
        }
    } else {
        return 100;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_num == 0) {
        ZYCollectModel *model1 = [[ZYCollectModel alloc]init];
        ZYNewsModel *model = _dataSource[indexPath.row];
        model1.url = model.url;
        model1.pic = model.image;
        model1.title = model.title;
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:model1, @"model", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } else {
        ZYCollectModel *model1 = [[ZYCollectModel alloc]init];
        ZYNewsModel *model = _dataSource[indexPath.row];
        model1.url = model.url;
        model1.pic = model.image;
        model1.title = model.title;
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:model1, @"model", nil];
        NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    
    
    
    
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_dataSource[indexPath.row],@"model", nil];
//    NSNotification *notification = [NSNotification notificationWithName:@"tongzhi" object:_dataSource[indexPath.row] userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
}






@end













