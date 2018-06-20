//
//  IndexViewController.m
//  lkcj
//
//  Created by annilq on 2018/6/19.
//  Copyright © 2018年 annilq. All rights reserved.
//

#import "IndexViewController.h"
#import "IndexBanner.h"
#import "TitleReusableView.h"
#import "AppDelegate.h"
#import "DatalistViewController.h"
#import "UIColor+Hex.h"
@interface IndexViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property UICollectionView *collectionview;
@property IndexBanner *banner;
@end

@implementation IndexViewController

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
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.backgroundColor=[UIColor clearColor];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[IndexBanner class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:@"banner"];
    [collectionView registerClass:[TitleReusableView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:@"title"];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    //先通过kind类型判断是头还是尾巴，然后在判断是哪一组，如果都是一样的头尾，那么只要第一次判断就可以了
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        if(indexPath.section==0){
            IndexBanner *banner = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                     withReuseIdentifier:@"banner"
                                                                            forIndexPath:indexPath];
            return banner;
        }else{
            TitleReusableView *label = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                          withReuseIdentifier:@"title"
                                                                                 forIndexPath:indexPath];
            if(indexPath.section==1){
                [label setLabelTitle:@"提醒"];
                
            }
            return label;
        }
        
        
    }
    return nil;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section==0){
        CGSize size = {self.view.frame.size.width, 330};
        return size;
    }else{
        CGSize size = {self.view.frame.size.width,40};
        return size;
    }
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGSize size = {240,25};
//    return size;
//}

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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
