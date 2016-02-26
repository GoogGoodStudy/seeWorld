//
//  ZYCollectionViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/26.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYCollectionViewController.h"

@interface ZYCollectionViewController ()

@end

@implementation ZYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView = [[UIWebView alloc]init];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
