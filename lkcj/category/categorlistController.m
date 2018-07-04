//
//  categorlistController.m
//  lkcj
//
//  Created by annilq on 2018/6/12.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppDelegate.h"
#import "detailViewController.h"
#import "categorlistController.h"
#import "categorcell.h"
#import "UIColor+Hex.h"
#import "AppUtil.h"
@interface categorlistController ()
@property NSMutableArray *lists;
@property id totalCount;
@end

@implementation categorlistController
@synthesize listConfig;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"数据页";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getlistConfig];
}

-(void)getlistConfig{
    NSString *urlString = @"http://oa.jianguanoa.com/app-data-list/get-app-display-config.do";
    
    NSDictionary *paramData=@{@"functionId":[NSNumber numberWithInt:[self.functionId intValue]]};
    [AppUtil postDataTo:urlString withBody:paramData andBlock:^(NSDictionary *data) {
        self.listConfig=[data valueForKey:@"result"];
        [self getlistWithUrl:[self.listConfig valueForKey:@"urlAddress"] ];
    }];
    
}-(void)getlistWithUrl:(NSString *)configurl{
    NSString *urlString = [NSString stringWithFormat:@"http://oa.jianguanoa.com/%@?",configurl];
    NSDictionary *param=@{@"limit":[NSNumber numberWithInt:1],@"start":[NSNumber numberWithInt:0],@"id":self.functionId};
    [AppUtil getDataFrom:urlString withParams:param andBlock:^(NSDictionary *data) {
        self.lists=[data valueForKey:@"dataList"];
        self.totalCount=[data valueForKey:@"totalCount"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.lists count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    categorcell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[categorcell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *cellData=[self.lists objectAtIndex:indexPath.row];
    NSDictionary *displayFields=[self.listConfig objectForKey:@"displayFields"];
    [cell configCellWithConfig:displayFields andData:cellData];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    titleLabel.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    if(self.totalCount!=nil){
        titleLabel.text=[NSString stringWithFormat:@"  共有%@条数据",self.totalCount];
    }
    return titleLabel;
}
//- (NSString *)tableView:(UITableView *)tableView
//titleForHeaderInSection:(NSInteger)section{
//    return @"sss";
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailViewController *detail=[[detailViewController alloc] init];
    detail.from=@"main";
    [self.navigationController pushViewController:detail animated:false];
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
