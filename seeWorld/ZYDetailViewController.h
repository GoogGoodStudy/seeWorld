//
//  ZYDetailViewController.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/22.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYCollectModel.h"
#import "MBProgressHUD.h"
@interface ZYDetailViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ZYCollectModel *model;
@property (nonatomic, strong) MBProgressHUD *hud;



@end
