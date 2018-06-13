//
//  detailViewController.m
//  lkcj
//
//  Created by annilq on 2018/4/10.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
   
    label.text=self.from;
    label.textColor=[UIColor blueColor];
    [self.view addSubview:label];
    self.navigationItem.title=@"detail";
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
