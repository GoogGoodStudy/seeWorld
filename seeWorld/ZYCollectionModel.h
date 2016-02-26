//
//  ZYCollectionModel.h
//  seeWorld
//
//  Created by 赵志远 on 16/1/26.
//  Copyright © 2016年 赵志远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ZYCollectionModel : NSManagedObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *pic;

@end
