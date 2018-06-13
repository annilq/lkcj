//
//  mainViewController.m
//  lkcj
//
//  Created by annilq on 2018/4/10.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "mainViewController.h"
#import "AppDelegate.h"
#import "DatalistViewController.h"
#import "UIColor+Hex.h"
@interface mainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView *collectionview;
@end

@implementation mainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"首页";
    [self initDatalist];
}

-(void)initDatalist{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    UICollectionView *collectionview=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionview.backgroundColor=[UIColor clearColor];
    collectionview.delegate=self;
    collectionview.dataSource=self;
    [self.view addSubview:collectionview];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithHexString:@"4095ff"];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.text=[NSString stringWithFormat:@"%ld section %ld row",indexPath.section,indexPath.row];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DatalistViewController *list=[[DatalistViewController alloc] init];
    [self.navigationController pushViewController:list animated:false];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
