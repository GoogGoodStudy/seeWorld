//
//  ZYDetailViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYDetailViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "ZYCollectionModel.h"

@interface ZYDetailViewController () <UIGestureRecognizerDelegate, UIWebViewDelegate>
{   //托管对象上下文，负责增删改查等操作、
    NSManagedObjectContext *_context;
}

@end

@implementation ZYDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"usercenter_hd_myfavorites"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(collect:)];

    self.navigationItem.rightBarButtonItem = item;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.url]]];
    [self.view addSubview:_webView];
    self.webView.scrollView.bounces = NO;
    [self coreData];
    self.hud = [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    self.hud.labelText = @"loading...";
    self.hud.opacity = 0.3;
   
    
    self.webView.delegate = self;
}

- (void)coreData {
    //去除不能打了里面的所有模型文件
    NSManagedObjectModel *theModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    //实例化永久存储协调器（使用model实例化）
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:theModel];
    //配置协调器操作的文件路径和类型
    NSString *sqlitePath = [NSString stringWithFormat:@"%@/Library/CollectionModel.sqlite",NSHomeDirectory()];
    /*
     COREDATA_EXTERN NSString * const NSSQLiteStoreType
     COREDATA_EXTERN NSString * const NSXMLStoreType
     COREDATA_EXTERN NSString * const NSBinaryStoreType
     */
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:nil];
    //实例化上下文
    _context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context.persistentStoreCoordinator = coordinator;
}

- (void)collect:(UIBarButtonItem *)item {
    __block BOOL stats = YES;
    NSError *error = nil;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"已收藏" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertC animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertC dismissViewControllerAnimated:YES completion:nil];
    });
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Collection" inManagedObjectContext:_context];
    NSArray *dataSource = [_context executeFetchRequest:request error:&error];
    [dataSource enumerateObjectsUsingBlock:^(ZYCollectionModel  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.model.title isEqualToString:obj.title]) {
            stats = NO;
        }
    }];
    if (stats) {
        //插入一个记录，不用alloc init方法。
        ZYCollectionModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:_context];
        model.pic = self.model.pic;
        model.title = self.model.title;
        model.url = self.model.url;
        //保存修改
        [_context save:&error];
        
    }
}


- (void)viewWillAppear:(BOOL)animated {
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBack)];
    tgr.delegate = self;
    tgr.numberOfTapsRequired = 2;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (delegate.isLogin) {
        [self.webView addGestureRecognizer:tgr];
    }
    
    
}


- (void)gotoBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.hud hide:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
