//
//  userUIViewController.m
//  lkcj
//
//  Created by annilq on 2018/5/23.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "userUIViewController.h"
#import "AppRouter.h"

@interface userUIViewController ()

@end

@implementation userUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        UIButton *logout = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
        logout.frame = CGRectMake(0, 0, 90, 35);
        [logout setTitle:@"logout" forState:UIControlStateNormal];
        [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        logout.center=CGPointMake(200,  100);
    [self.view addSubview:logout];
    // Do any additional setup after loading the view.
}
-(void)logout{
    [[AppRouter sharedInstance] goLoginView];
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
