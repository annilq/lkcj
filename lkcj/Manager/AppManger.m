//
//  AppManger.m
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppManger.h"
#import "loginViewController.h"
@implementation AppManger
@synthesize islogin;
+ (AppManger *)sharedInstance {
    static AppManger *mSharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mSharedInstance = [[AppManger alloc] init];
    });
    
    return mSharedInstance;
}
- (id)init {
    self = [super init];
    return self;
}
-(void)appInitWithCon:(UIViewController *) con{
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.window.rootViewController=con;
}
@end
