//
//  AppManger.h
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AppManger:NSObject
@property Boolean islogin;
+ (AppManger *)sharedInstance;
- (void)appInitWithCon:(UIViewController *)con;
@end
