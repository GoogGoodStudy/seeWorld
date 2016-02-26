//
//  ZYRootViewController.m
//  seeWorld
//
//  Created by 赵志远 on 16/1/25.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import "ZYRootViewController.h"

@interface ZYRootViewController ()

@end

@implementation ZYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarItem];
    
    

}

- (void)setTabBarItem {
    UITabBarItem * item0=self.tabBar.items[0];
    item0.image=[[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item0.selectedImage=[[UIImage imageNamed:@"tab_home_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UITabBarItem * item1=self.tabBar.items[1];
    item1.image=[[UIImage imageNamed:@"tab_gallery"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage=[[UIImage imageNamed:@"tab_gallery_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem * item2=self.tabBar.items[2];
    item2.image=[[UIImage imageNamed:@"tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage=[[UIImage imageNamed:@"tab_my_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
   
    //[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    UIColor *selectColor = [UIColor colorWithRed:0.0 green:201.0/255 blue:134.0/255 alpha:1.0];
    UIColor *normalColor = [UIColor colorWithRed:91.0/255 green:99/255 blue:104/255 alpha:1.0];
  
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:normalColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:selectColor, NSForegroundColorAttributeName, [UIFont systemFontOfSize:12], NSFontAttributeName, nil] forState:UIControlStateSelected];
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
