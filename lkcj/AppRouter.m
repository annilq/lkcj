//
//  AppRouter.m
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppRouter.h"
#import "mainViewController.h"
#import "IndexViewController.h"
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
    IndexViewController *index=[[IndexViewController alloc] init];
    UINavigationController *mainNav=[[UINavigationController alloc] initWithRootViewController:index];
    index.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"聊天" image:[UIImage imageNamed:@"gz-a"] tag:0];

    userUIViewController *user=[[userUIViewController alloc] init];
    UINavigationController *userNav=[[UINavigationController alloc] initWithRootViewController:user];
    user.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"工作" image:[UIImage imageNamed:@"user"] tag:1];

    UITabBarController *mainBar=[[UITabBarController alloc] init];
    mainBar.viewControllers=@[mainNav,userNav];
//    mainBar.selectedIndex=1;
    [[AppManger sharedInstance] appInitWithCon:mainBar];
}
-(void)goLoginView{
    [AppManger sharedInstance].islogin=false;
    loginViewController *login=[[loginViewController alloc] init];
    [[AppManger sharedInstance] appInitWithCon:login];
}
@end
