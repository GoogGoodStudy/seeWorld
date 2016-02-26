//
//  ZYVideoTableViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/24.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYVideoTableViewController.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "ZYVideoGetData.h"
#import "ZYVideoTableViewCell.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSInteger, RefreshStats) {
    RefreshStatsNomal = 0,
    RefreshStatsHeader,
    RefreshStatsFooter
};

@interface ZYVideoTableViewController ()
{
    NSMutableArray *_dataSource;
    NSInteger _page;
    RefreshStats _refreshStats;
}
@end

@implementation ZYVideoTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"videoURL" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    _dataSource = [[NSMutableArray alloc] init];
    _refreshStats = RefreshStatsNomal;
    [self setRefresh];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerVideo:) name:@"videoURL" object:nil];
    //隐藏线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)playerVideo:(NSNotification *)notfication {
    NSString *indexStr = notfication.userInfo[@"tag"];
    NSInteger index = [indexStr integerValue];
    ZYVideoModel *model = _dataSource[index];
    AVPlayerViewController * avPlayerViewController=[[AVPlayerViewController alloc]init];
    NSURL *url = [NSURL URLWithString:model.videourl];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    avPlayerViewController.player=player;
    avPlayerViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:avPlayerViewController animated:YES completion:nil];
}

- (void)setRefresh {
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
        _page = 1;
        [weakSelf getData];
        _refreshStats = RefreshStatsHeader;
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakSelf getData];
        _refreshStats = RefreshStatsFooter;
    }];
}


- (void)getData {
    [ZYVideoGetData getVideoDataWith:_page andHandle:^(id result, NSError *error) {
        if (_refreshStats == RefreshStatsHeader) {
            [_dataSource removeAllObjects];
        }
        [_dataSource addObjectsFromArray:result];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.imgV.tag = indexPath.row;
    [cell updateWith:_dataSource[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_dataSource[indexPath.row] height]+5+3+300+10+5+10+30+5;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
