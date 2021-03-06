//
//  DatalistViewController.m
//  lkcj
//
//  Created by annilq on 2018/6/12.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "AppDelegate.h"
#import "detailViewController.h"
#import "DatalistViewController.h"
#import "DataListCellTableViewCell.h"
#import "AppUtil.h"
@interface DatalistViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property UITableView *table;
@property UISearchBar *searchbar;
@property UISegmentedControl *seg;
@property UITableViewCell *cell;
@property NSMutableArray *catlists;
@property int start;
@property int total;
@end

@implementation DatalistViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.catlists=[[NSMutableArray alloc] init];
    self.navigationItem.title=@"待我审批";
    [self initserachbar];
    [self initsegment];
    [self getdatalist:0];
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
    self.seg=[[UISegmentedControl alloc]initWithItems:@[@"未批复",@"已批复"]];
    self.seg.selectedSegmentIndex=0;
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
    self.catlists=[[NSMutableArray alloc] init];
    [self getdatalist:0];
}
-(void)getdatalist:(int) start{
    NSMutableString *urlString;
    if(self.seg.selectedSegmentIndex==0){
        urlString =[NSMutableString stringWithFormat: @"http://oa.jianguanoa.com//my-task/get-untreated.do"];
    }else{
        urlString =[NSMutableString stringWithFormat: @"http://oa.jianguanoa.com//my-task/get-treated.do"];
    }
    NSDictionary *param=@{@"limit":[NSNumber numberWithInt:10],@"start":[NSNumber numberWithInt:start]};
    [AppUtil getDataFrom:urlString withParams:param andBlock:^(NSDictionary *data) {
        //        self.catlists=[data valueForKey:@"dataList"];
        NSMutableArray* datas=[data valueForKey:@"dataList"];
        [self.catlists addObjectsFromArray:datas];
        self.start=[[data valueForKey:@"startIndex"] integerValue];
        self.total=[[data valueForKey:@"totalCount"] integerValue];
        NSLog(@"%d===%d",self.start,self.total);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
            if(start==0){
                [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        });
    }];
    
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
    return [self.catlists count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row] == ([self.catlists count]-1)&&self.start<=self.total)
    {
        [self getdatalist:self.start+10];
    }
    DataListCellTableViewCell *cell=[self.table dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil){
        cell=[[DataListCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *celData=[self.catlists objectAtIndex:indexPath.row];
    [cell configCellWithData:celData];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 92;
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
