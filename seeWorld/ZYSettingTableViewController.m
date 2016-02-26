//
//  ZYSettingTableViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/25.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYSettingTableViewController.h"
#import "AppDelegate.h"
#import "ZYCollectionTableViewController.h"
@interface ZYSettingTableViewController ()
{
    BOOL _states;
    BOOL _states2;
}
@property (weak, nonatomic) IBOutlet UISlider *lightSlider;
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLab;

@end

@implementation ZYSettingTableViewController

- (void)viewWillAppear:(BOOL)animated {
    //得到缓存的大小
    self.cacheSizeLab.text = [NSString stringWithFormat:@"%@M", [self getCachesSize]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"callBg"];
    [self.tableView setBackgroundView:bgView];
   
    
    
    //隐藏线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _states = NO;
    _states2 = NO;

}
- (IBAction)closeDoubleTap:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _states = !_states;
    delegate.isLogin = _states;
}
- (IBAction)lightSlider:(UISlider *)sender {
    float value = sender.value;
    [[UIScreen mainScreen] setBrightness:value];
}
- (IBAction)nightStyle:(id)sender {
    _states2 = !_states2;
    if (_states2) {
        [[UIScreen mainScreen] setBrightness:0.0];
        _lightSlider.value = 0.0;
    } else {
        [[UIScreen mainScreen] setBrightness:0.5];
        _lightSlider.value = 0.5;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (NSString *)getCachesSize {
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    __block long long sumSize = 0;
    //获取子文件名称数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    [files enumerateObjectsUsingBlock:^(NSString  *_Nonnull subPath, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *filePath = [cachPath stringByAppendingFormat:@"/%@",subPath];
        long long fileSize = [[[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil]fileSize];
        sumSize += fileSize;
    }];
    float size_m = sumSize/(1000*1000);
    return [NSString stringWithFormat:@"%.2f",size_m];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 1) {
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"gotoCollection" sender:self];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.row == 4) {
        NSString *str = [NSString stringWithFormat:@"确定删除%@缓存吗？", self.cacheSizeLab.text];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"清理缓存" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            printf("取消\n");
        }]];
        [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            [self removeCache];
        }]];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }
}

- (void)removeCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
        
    });
}


-(void)clearCacheSuccess
{
    self.cacheSizeLab.text = @"0.00M";
    
}





#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gotoCollection"]) {
        //找出搜索tableViewController对象
        //ZYCollectionTableViewController *tvc = segue.destinationViewController;
        
    }
}


@end
