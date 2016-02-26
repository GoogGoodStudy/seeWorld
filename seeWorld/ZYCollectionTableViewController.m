//
//  ZYCollectionTableViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/26.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYCollectionTableViewController.h"
#import <CoreData/CoreData.h>
#import "UIImageView+WebCache.h"
#import "ZYCollectionModel.h"
#import "ZYCollectionViewController.h"
@interface ZYCollectionTableViewController ()
{   //托管对象上下文，负责增删改查等操作、
    NSManagedObjectContext *_context;
    NSArray *_dataSource;
}
@end

@implementation ZYCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCoreData];
    [self createItem];
}

- (void)createItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(clickHandle:)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)clickHandle:(UIBarButtonItem *)item {
    if([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    } else {
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeRowAtIndexPath:indexPath];

    
}

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath {
    [_context deleteObject:_dataSource[indexPath.row]];
    [_context save:nil];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Collection" inManagedObjectContext:_context];
    NSError *error = nil;
    _dataSource = [_context executeFetchRequest:request error:&error];
    [self.tableView reloadData];
    
}


- (void)setCoreData {
    NSManagedObjectModel *theModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //实例化永久存储协调器（使用model实例化）
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:theModel];
    //配置协调器操作的文件路径和类型
    NSString *sqlitePath = [NSString stringWithFormat:@"%@/Library/CollectionModel.sqlite",NSHomeDirectory()];

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    //实例化上下文
    _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context.persistentStoreCoordinator = coordinator;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Collection" inManagedObjectContext:_context];
    NSError *error = nil;
    _dataSource = [_context executeFetchRequest:request error:&error];
    NSLog(@"%ld",_dataSource.count);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYCollectionModel *model = _dataSource[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]placeholderImage:[UIImage imageNamed:@"replace"]];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYCollectionModel *model = _dataSource[indexPath.row];
    ZYCollectionViewController *detailVC = [[ZYCollectionViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    detailVC.url = model.url;
    //self.hidesBottomBarWhenPushed = NO;
    
    
 
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
