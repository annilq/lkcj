//
//  AppRouter.m
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppRouter.h"
#import "main/mainViewController.h"
#import "user/userUIViewController.h"
#import "login/loginViewController.h"
#import "AppManger.h"
@implementation AppRouter
+ (AppRouter *)sharedInstance {
    static AppRouter *mSharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mSharedInstance = [[AppRouter alloc] init];
    });
    return mSharedInstance;
}
- (id)init {
    self = [super init];
    return self;
}
-(void)goMainView{
    [AppManger sharedInstance].islogin=true;
    mainViewController *main=[[mainViewController alloc] init];
    UINavigationController *mainNav=[[UINavigationController alloc] initWithRootViewController:main];
    main.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"加油哇" image:[UIImage imageNamed:@"gz-a"] tag:0];

    userUIViewController *user=[[userUIViewController alloc] init];
    UINavigationController *userNav=[[UINavigationController alloc] initWithRootViewController:user];
    user.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"思辰" image:[UIImage imageNamed:@"user"] tag:1];

    UITabBarController *mainBar=[[UITabBarController alloc] init];
    mainBar.viewControllers=@[mainNav,userNav];
    [[AppManger sharedInstance] appInitWithCon:mainBar];
}
-(void)goLoginView{
    [AppManger sharedInstance].islogin=false;
    loginViewController *login=[[loginViewController alloc] init];
    [[AppManger sharedInstance] appInitWithCon:login];
}
@end
