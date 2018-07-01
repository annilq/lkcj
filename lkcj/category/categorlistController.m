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
@interface categorlistController ()
@property NSMutableArray *lists;
@property id totalCount;
@end

@implementation categorlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"数据页";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getlist];
}

-(void)getlist{
    NSString *urlString = @"http://oa.jianguanoa.com/project-money/find-page.do?id=13&limit=10&start=0";
    // 一些特殊字符编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    // 3.采用苹果提供的共享session
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    
    // 4.由系统直接返回一个dataTask任务
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            self.lists=[json valueForKey:@"dataList"];
            self.totalCount=[json valueForKey:@"totalCount"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
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
    [cell configCellWithData:cellData];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel=[[UILabel alloc]init];
    titleLabel.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    titleLabel.textColor=[UIColor colorWithHexString:@"8c8c8c"];
    titleLabel.text=[NSString stringWithFormat:@"  共有%@条数据",self.totalCount];
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
