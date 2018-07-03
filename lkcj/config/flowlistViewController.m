//
//  flowlistViewController.m
//  lkcj
//
//  Created by annilq on 2018/7/3.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "flowlistViewController.h"
#import "AppDelegate.h"
#import "detailViewController.h"
#import "DataListCellTableViewCell.h"
#import "AppUtil.h"
@interface flowlistViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property UITableView *table;
@property UISearchBar *searchbar;
@property UISegmentedControl *seg;
@property UITableViewCell *cell;
@property NSArray *catlists;
@end

@implementation flowlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我发起的";
    [self initserachbar];
    [self initsegment];
    [self initTable];
}
-(void)initserachbar{
    self.searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(20, 74,SCREEN_WIDTH-40 , 40)];
    self.searchbar.placeholder=@"请输入";
    self.searchbar.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:self.searchbar];
    self.searchbar.delegate=self;
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"search");
}
-(void)initsegment{
    self.seg=[[UISegmentedControl alloc]initWithItems:@[@"已通过",@"审核中",@"未批准"]];
    self.seg.selectedSegmentIndex=1;
    [self.seg addTarget:self action:@selector(switchTab:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.seg];
    self.seg.translatesAutoresizingMaskIntoConstraints=NO;
    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[seg]-30-|" options:0 metrics:nil views:@{@"seg":self.seg}];
    //69=20+44+10
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[searchbar]-10-[seg(30)]" options:0 metrics:nil views:@{@"seg":self.seg,@"searchbar":self.searchbar}];
    [self.view addConstraints:h];
    [self.view addConstraints:v];
}
-(void)switchTab:(UISegmentedControl *)seg{
    NSLog(@"%ld",seg.selectedSegmentIndex);
}
-(void)getdatalist{
    NSString *urlString =[NSString stringWithFormat: @"http://oa.jianguanoa.com/my-process/my-process-list-for-app.do?flag=%ld&limit=10&start=0",self.seg.selectedSegmentIndex+1];
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
            self.catlists=[json valueForKey:@"dataList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
        } else {
            // 网络访问失败
            NSLog(@"error=%@",error);
        }
    }];
    
    // 5.每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}
-(void)initTable{
    self.cell=[[DataListCellTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.table.translatesAutoresizingMaskIntoConstraints=NO;
    self.table.delegate=self;
    self.table.dataSource=self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    NSArray *h=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[table]-0-|" options:0 metrics:nil views:@{@"table":self.table}];
    NSArray *v=[NSLayoutConstraint constraintsWithVisualFormat:@"V:[seg]-10-[table]-50-|" options:0 metrics:nil views:@{@"table":self.table,@"seg":self.seg}];
    [self.view addConstraints:h];
    [self.view addConstraints:v];
}
#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DataListCellTableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[DataListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=@"hey";
    cell.detailTextLabel.text=@"annilq";
    cell.imageView.image=[UIImage imageNamed:@"user"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
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
